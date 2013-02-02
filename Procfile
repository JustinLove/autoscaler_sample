web:     bundle exec script/rails server -p $PORT
worker:  bundle exec sidekiq
default: env HEROKU_PROCESS=default bundle exec sidekiq
import:  env HEROKU_PROCESS=import bundle exec sidekiq -q import -c 1
