homer = User.find_or_create_by(email: 'homer@simpsons.com') do |user|
  user.password = 'password'
end
marge = User.find_or_create_by(email: 'marge@simpsons.com') do |user|
  user.password = 'password'
end
bart = User.find_or_create_by(email: 'bart@simpsons.com') do |user|
  user.password = 'password'
end

marge.pointed_events.create! value: 1000, type: 'PR_APPROVAL'
marge.pointed_events.create! value: 1000, type: 'PR_APPROVAL'
marge.pointed_events.create! value: 1000, type: 'PR_APPROVAL'

homer.pointed_events.create! value: 1000, type: 'PR_APPROVAL'
homer.pointed_events.create! value: 1000, type: 'PR_APPROVAL'

bart.pointed_events.create! value: 1000, type: 'PR_APPROVAL'
