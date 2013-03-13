web:     bundle exec script/rails server -p $PORT
worker:  bundle exec sidekiq
import:  env HEROKU_PROCESS=import bundle exec sidekiq -q import -c 1
critical: env HEROKU_PROCESS=critical bundle exec sidekiq -c 2 -q critical,4
default: env HEROKU_PROCESS=default bundle exec sidekiq -c 4 -q default,2
low: env HEROKU_PROCESS=low bundle exec sidekiq -c 1 -q low,1
