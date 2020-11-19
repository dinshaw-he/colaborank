namespace :demo_data do
  desc "Create a bunch of data for our demo"
  task create: :environment do
    homer = User.find_by email: 'homer@simpsons.com'
    marge = User.find_by email: 'marge@simpsons.com'
    bart = User.find_by email: 'bart@simpsons.com'
    dinshaw = User.find_by email: 'dinshaw.gobhai@hotelengine.com'
    will = User.find_by email: 'will.piers@hotelengine.com'
    derek = User.find_by email: 'derek@hotelengine.com'
    stephen = User.find_by email: 'stephen.malek@hotelengine.com'

    users = User.all
    creator = PointedEventCreator.new

    (100.days.ago.to_date..Date.today).each do |day|
      random_users = users.sample(rand(1..users.size))

      random_users.each do |user|
        (1..3).to_a.sample.times do
          creator.call(type: 'PR_APPROVAL', user: user.github)
        end
        creator.call(type: 'PR_COAUTHORS', emails: [user.email, users.sample.email])
      end

    end
  end
end
