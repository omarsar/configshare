
acc1 = Account.new(username: 'soumya.ray', email: 'sray@nthu.edu.tw')
acc1.password = 'mypassword'
acc1.save

proj1 = acc1.add_owned_project(name: 'Soumya Project')
proj1.repo_url = 'http://github.com/soumya/project.git'
proj1.save
doc11 = proj1.add_configuration(filename: 'config_env.rb')
doc11.document = "this is the first line\nthis is the second line"
doc11.description = 'environmental configurations for test, development envs'
dic11.save
doc12 = proj1.add_configuration(filename: 'environments.ini')
doc12.document = '---'
doc12.save

proj2 = acc1.add_owned_project(name: 'Config Project')
doc21 = proj2.add_configuration(filename: 'credentials.json')
doc21.document = 'username: password'
doc21.save

acc2 = Account.new(username: 'lee123', email: 'lee@nthu.edu.tw')
acc2.password = 'randompassword'
acc2.save

proj21 = acc2.add_owned_project(name: 'Lee\'s Project')
proj22 = acc2.add_owned_project(name: 'Lee\'s Solo Project')
acc1.add_project(proj21)
acc2.add_project(proj2)