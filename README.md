# The Master mind game
A web browser based single player permutation guessing game built using the Ruby on Rails framework


This README should explain how an
interviewer could run your code, document your thought process and/or code structure, and
describe any creative extensions attempted or implemented. There is no prescribed format for
the README, but it should be clear and unambiguous in listing all the steps in building, running,
and playing the game you built (you should make no assumptions about what software the
interviewer has, and err on the side of being explicit).

### Prerequisites


[redis](https://redis.io/download) [windows 10](https://redislabs.com/blog/redis-on-windows-10/) 
[postgresql 11](https://www.postgresql.org/download/) 
ruby 2.5.1 
[bundler](https://bundler.io/) 
[rvm](https://rvm.io/) (optional)

### Installing (Based on Linux, if using windows/Mac see OS specific docs for installation details)

Clone the repo onto your local machine

```
$ git clone https://github.com/Nevillealee/master_mind_game.git
```

Install gemfile

```
$ bundle install
```

Edit  master_mind_game/config/database.yml
```
development:
  url: postgresql://[DB_USER_NAME]:[DB_USER_PW]@localhost/master_mind_game

```
Set up database

```
$ rake db:create
$ rake db:migrate
```
Install [bootstrap 4](https://medium.com/@adrian_teh/ruby-on-rails-6-with-webpacker-and-bootstrap-step-by-step-guide-41b52ef4081f)
```
$ yarn add bootstrap jquery popper.js
```
Start rails server
```
$ rails s
```
1. Open another terminal tab (in same dir [2nd tab])

2. Start redis server manually if redis not already installed/running as daemon
in another terminal tab
```
$ redis-server path/to/redis.conf

  (macOS default_path: /usr/local/etc/redis.conf)
  (linux default_path: /etc/redis.conf)
```
Open another terminal tab (in same dir [3rd tab])
```
$ rake QUEUE=default resque:work
```
Visit http://localhost:3000/ in the browser

## Author(s)

* **Neville Lee** - *Initial work* - [Nevillealee](https://github.com/nevillealee)
