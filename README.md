# :computer: Devium
![screenshot](screeshot.png)

Devium is social networking platform for developers.
You can connect with your peer develpers and interact with them.
Devium is built with Rails, and fully tested with RSpec and Capybara.

## Intro
This is a part of Rails curriculum on [Microverse](https://www.microverse.org/), originally built for educational purposes.

## Setup

```bash
~ git clone git@github.com:mosaaleb/devium.git
~ cd devium
~ rails db:migrate:reset
~ rails s
```

## Live Version
The live version of this project is hosted in heroku 
[Devium](https://deviumio.herokuapp.com/).


## Built with:
- Ruby on Rails
- RSpec
- Capybara
- Bootstrap

## Database Design
[ERD](https://www.lucidchart.com/invitations/accept/02f604cf-c6bb-4e94-a595-4b3c6856d8a3)

## Features
- Sending friend requests.
- Accepting friend requests.
- Remove friends.
- Add posts.
- Add comment to posts.
- Add likes to either posts or comments
- Having newsfeed page based on the friends list.
- Ability to login with facebook.
- Edit setting and profile information.
- Adding hashtags
- Notification system.
- Mentioning friends in comments or posts.

## Coming Features:
- [x] mention users on comments or posts.

**Having specific feature in mind?**
Please [Submit](https://github.com/mosaaleb/devium/labels/enhancement) it

### Testing
The app is fully tested with `1:2.2` Code to Test Ratio

**Included Tests:**
- Model Tests (rspec)
- Request Tests (rspec)
- View Tests (rspec)
- Integration Tests (capybara)

#### Running the tests:
You can run all the tests by simply running:

`rspec`

## Contributors
- [Saheed](https://github.com/suretrust)
- Muhammad
  - [GitHub](https://github.com/mosaaleb)
  - [LinkedIn](https://www.linkedin.com/in/muhammadebeid/)
  - [muhammed.ebeid@gmail.com](muhammed.ebeid@gmail.com)

