amzn-ics
===============================

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)
[![Circle CI](https://circleci.com/gh/mallowlabs/amzn-ics.svg?style=shield)](https://circleci.com/gh/mallowlabs/amzn-ics)

Overview
-------------------------------

[Amazon](http://www.amazon.co.jp) bookmarks and ics generator.

Setup
-------------------------------

copy dot.env to .env, and edit it.

#### DEVISE\_SECRET\_KEY

Generate secret key

```
bundle exec rake secret
```

#### OMNIAUTH\_PROVIDER, OMNIAUTH\_ARGS

You need to set environment variables as follows:
```
OMNIAUTH_PROVIDER=twitter
OMNIAUTH_ARGS="['TWITTER_API_KEY','TWITTER_SECRET']"
```

#### AWS\_ACCESS\_KEY\_ID, AWS\_SECRET\_KEY
Set Amazon Product Advertising API keys.
```
AWS_ACCESS_KEY_ID=Your AWS Access Key
AWS_SECRET_KEY=Your AWS Secret Key
```

#### run

    $ bundle install --path .bundle
    $ bundle exec rake db:migrate
    $ bundle exec rails s

License
-------------------------------
[The MIT License (MIT)](http://opensource.org/licenses/mit-license)
Copyright (c) 2015 mallowlabs
