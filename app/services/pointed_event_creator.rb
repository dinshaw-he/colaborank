class PointedEventCreator
  include Dry::Monads[:result, :do]
  include Dry::Matcher.for(:call, with: Dry::Matcher::ResultMatcher)

  Payload = Struct.new :message, :ids, keyword_init: true
  TEXT = ScopedI18n.new scope: 'services.pointed_event_creator'

  def initialize klass: PointedEvent, user_class: User, text: TEXT
    @klass = klass
    @user_class = user_class
    @text = text
  end

  def call params
    users = yield find_users(params)

    pointed_events = []

    users.each do |user|
      pointed_events << user.pointed_events.create!(
        type: params[:type],
        value: klass::VALUES.fetch(params[:type]),
        repo: params[:repo]
      )
    end

    payload = Payload.new(
      message: text.call('success', count: pointed_events.count),
      ids: pointed_events.map(&:id)
    )

    Success payload
  rescue ActiveRecord::RecordInvalid => e
    Failure e.message
  end

  private

  attr_reader :klass, :user_class, :text

  def find_users(params)
    conditions = case params[:type]
    when 'PR_APPROVAL'
      { github: params[:github_handles].split(',') }
    when 'PR_COAUTHORS'
      { email: params[:emails].split(',') }
    end

    users = user_class.where conditions
    users.empty? ? Failure('No user found') : Success(users)
  end
end
