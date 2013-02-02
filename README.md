# Autoscaler Sample

This is the simplest possible app to demonstrate the Sidekiq Heroku Autoscaler gem.

[https://github.com/JustinLove/autoscaler](https://github.com/JustinLove/autoscaler)

## Running Locally

    cp example.env .env
    foreman start -f Procfile.dev

    # new tab/terminal
    foreman start --formation="web=1,worker=1"

The application implements both the simple and complex configurations from the autoscaler examples.  To run the complex config, edit `AUTOSCALER_CONFIG` in `.env` and run

    foreman start --formation="web=1,default=1,import=1"

## Remote controlling Heroku

Edit `.env` to add your Heroku app name and api key. The application will detect the presence of these variables and play puppet master.  To observe it working:

    heroku logs --app your-heroku-app -t

## Running on Heroku

    heroku apps:create your-heroku-app --addons redistogo:nano --stack cedar --remote your-heroku-app
    heroku config:set HERKOU_APP=your-heroku-app HEROKU_API_KEY=xxxxx --app your-heroku-app
    heroku config:set AUTOSCALER_CONFIG=simple --app your-heroku-app
    heroku logs --app your-heroku-app -t
