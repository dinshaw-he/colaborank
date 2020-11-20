namespace :demo_data do
  desc "Create a bunch of data for our demo"
  task create: :environment do
    users = User.all
    creator = PointedEventCreator.new

    (100.days.ago.to_date..Date.today).each do |day|
      # puts "Creating evens for date: #{day}"

      Timecop.travel day do
        random_users = users.sample(rand(1..(users.size/2)))

        # puts "for users: #{random_users.map(&:email)}"

        random_users.each do |user|
          (1..3).to_a.sample.times do
            creator.call(type: 'PR_APPROVAL', github_handles: [
              user.github, users.sample.github
            ])
          end
          (1..3).to_a.sample.times do
            creator.call(type: 'PR_COAUTHORS', emails: [user.email, users.sample.email])
          end
        end
      end
    end
  end
end
