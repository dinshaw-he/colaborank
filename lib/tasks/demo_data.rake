namespace :demo_data do
  desc "Create a bunch of data for our demo"
  task create: :environment do
    users = User.all
    creator = PointedEventCreator.new
    # day of the week in 0-6. Sunday is day-of-week 0; Saturday is day-of-week 6.
    my_days = [1,2,3,4,5]
    days = (30.days.ago.to_date..Date.today).select {|k| my_days.include?(k.wday) }
    days.each do |day|
      puts "Creating evens for date: #{day}"

      Timecop.travel day do
        random_users = users.sample([1,2].sample)

        # puts "for users: #{random_users.map(&:email)}"

        random_users.each do |user|
          [1,2].sample.times do
            creator.call(
              type: 'PR_APPROVAL',
              github_handles: [user.github, users.sample.github]
            )
          end
          creator.call(type: 'PR_COAUTHORS', emails: [user.email, users.sample.email])
        end
      end
    end
  end
end
