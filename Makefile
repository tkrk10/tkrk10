APP_NAME  = tkrk10
INSTANCE_COUNT = 1
ROOT_RUBY_FILE = config.ru

# Order
all:
	echo $(APP_NAME)

init:
	bundle install --path vendor/bundle

clean-all-gems:
	sudo gem list --local | cut -d" " -f1 | sudo xargs gem uninstall

start-local:
	bundle exec rackup $(ROOT_RUBY_FILE)

create-heroku-app:
	bundle exec heroku create --stack cedar $(APP_NAME) 

upload-to-heroku:
	git push heroku master

heroku-log:
	bundle exec heroku logs

restart-heroku:
	bundle exec heroku restart

create-instance:
	bundle exec heroku ps:scale web=1

scale-instance:
	bundle exec heroku ps:scale web=$(INSTANCE_COUNT)

delete-instance:
	bundle exec heroku ps:scale web=0
