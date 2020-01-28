# The Master mind game
A web browser based single player permutation guessing game built using the Ruby on Rails framework


This README should explain how an
interviewer could run your code, document your thought process and/or code structure, and
describe any creative extensions attempted or implemented. There is no prescribed format for
the README, but it should be clear and unambiguous in listing all the steps in building, running,
and playing the game you built (you should make no assumptions about what software the
interviewer has, and err on the side of being explicit).

### Prerequisites
```
-redis
-postgresql 11
-ruby 2.5.1
-bundler
```
### Installing (Based on Linux)

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

## How to Play
Game Rules:
```
At the start of the game the computer will randomly select a pattern of n different numbers from a total of 8 different numbers (0..7)

Player has 10 attempts to guess the correct number combination
At the end of each guess, computer will provide one of the following responses:
    -1. A correct digit was guessed
    -2. A correct digit and its location was guessed
    -3. The guess was incorrect
```
## Code Structure
Database:
```
I decided to implement a relational database (postgres) to store game data between sessions. This way, a player could log into the game at a later point and try to beat there previous high score without weighing down the browser cache because video games can generate lots of data. The User, Game(has_many: feedbacks), and Feedback(belongs_to: game) models/tables made it easy to keep track of user history and allow to feature extensions in the future (difficulty settings, account page, hints, advanced statistics..)
```
Framework choice:
```
I chose to use the Ruby on Rails framework because it naturally follows the MVC architecture. I thought the MVC architecture pattern would go well with a web based game (accessible on a variety of mobile and desktop devices). In addition Rails has a focus on rapid development of applications which applied to the delivery time constraints for this game submission.
```
Feedback:
```
The api call to the random number generator was placed in a background task because Ruby is a blocking language. This prevents i/o delay errors when multiple requests come into the Game controller (handles: start new game requests). A Feedback object is create each time a user submits a guess along
with the result of their guess compared to the actual random number generated for that game. These Feedbacks are associated with the current game being played so that the user can see a history of their guesses throughout the game.
Attempts are also saved in the feedback model for leader board calculations.
```
Gameflow:
```
The game begins on the home screen managed by the Games controller. When the user clicks 'new game', the user is directed to a New User form handled by the Users controller. If the user enters an existing name, that database record is
retrieved otherwise a new User record is created. The difficulty level input value from the New User form is saved into the session hash for use in the next controller action. The user id from sed User model is passed as a parameter to the Games controller index action.
Here the call to the random number api is made(in a background job) and that response is saved to the newly created Game object(associated with the current User object) along with the difficulty setting input value from the session hash.
The user is now redirected to the Game object page we just created(show action in game controller). On this show page, a user can submit a guess that will be compared against the randomly generated number previously saved to the current Game object. A feedback object is created and the feedback from
the user guess and random number comparison is saved with it.
If the user guessed correctly the game ends and the user is sent back to the home page with a congratulatory message. If the user hasnt exceeded 10 guess attempts, the Game show page is refreshed with updated Game object information and a list of associated Feedback records in the form of a "Guess history table". Otherwise, the game ends and the user is redirected to the home page with a message stated they lost.
Finally, the home screen displays a leaderboard which includes (if at least 2 games exist in the database) the top 3 users and there scores. The scores are based on Games completed in the fewest
attempts on the highest difficulty setting.
```
Creative Extensions:
```
• configurable “difficulty level”:
  -during user name input submission, a difficulty level select option is passed
  along as form data with as[default value of  4]:  easy, y=4, med y=5, hard y=6 or Ludicrous y=7. The y value will determine the number of digits contained in the random number api response. see below..
  ```
  - difficulty permutations(combinations where order matters)
  - x = 8, possible digit values 0..7
  - easy, y=4, med y=5, hard y=6, Ludicrous y=7
  - possible choices:
  -   8^7 = 2,097,152
  -   8^6 = 262,144
  -   8^5 = 32,768
  -   8^4 = 4,096
  ```

• Add animations and sounds:
  Using javascript, when the document DOMContentLoaded event fires on the home page and user name/difficulty selection form page, a wav file is played from
  the asset pipeline (assets/audio). In addition, when the buttons are clicked
  on each of these pages, a wav file is played. (the new_user page has a bug when the 'START' button is clicked. I put a submit event listener on the form but something is preventing that from triggering). CSS animations were added to the body of the application as well as the jumbotron header on the home screen to liven up the appearance of the game.

• Keep track of scores/leaderboard:
  the home screen displays a leaderboard which includes (if at least 2 games exist in the database) the top 3 users and there scores. The scores are based on Games completed in the fewest attempts on the highest difficulty setting.

• User tracking:
  A users table was added so that I could display which players had the best scores in the leaderboard as well as keep associations of player game data

• Rules modal:
  On the Game show page, there is a 'See Rules' button that triggers a modal
  popup window displaying the game rules to assist players in understanding how
  the game works whenever they need a reminder.

• Dynamic user guess input label:
  on the Game show page, the amount of digits in the random number the user has to guess will be dynamically displayed: "Enter a {@current_game.number_combo.size} digit number:" by displaying the string size of the number_combo attribute from the Game object since that object is already available on that page.
```
