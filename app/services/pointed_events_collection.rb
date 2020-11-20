class PointedEventsCollection
  def initialize(params: {})
    @params = params
  end

  def q
    @q ||= PointedEvent.ransack(params_with_defaults)
  end

  private

  attr_reader :params

  def params_with_defaults
    unless params.has_key?('created_at_gteq')
      params['created_at_gteq'] = PointedEvent.minimum(:created_at)
    end

    unless params.has_key?('created_at_lteq')
      params['created_at_lteq'] = Date.today
    end

    params['created_at_gteq'] = Time.parse(
      params['created_at_gteq'].to_s
    ).beginning_of_day

    params['created_at_lteq'] = Time.parse(
      params['created_at_lteq'].to_s
    ).end_of_day

    if params[:user_email_eq].present?
      params[:user_id_eq] = User.find_by(email: params[:user_email_eq] ).id
      params[:user_email_eq] = nil
    end
    params
  end
end
