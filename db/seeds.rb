homer = User.create! email: 'homer@simpsons.com', password: 'password'
marge = User.create! email: 'marge@simpsons.com', password: 'password'
bart = User.create! email: 'bart@simpsons.com', password: 'password'

marge.pointed_events.create! value: 1000
marge.pointed_events.create! value: 1000
marge.pointed_events.create! value: 1000

homer.pointed_events.create! value: 1000
homer.pointed_events.create! value: 1000

bart.pointed_events.create! value: 1000
