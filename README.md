# FragmentX

## 3D Visualization of restored objects

[![Build Status](https://travis-ci.org/FragmentX/FRAGMENTX.svg?branch=master)](https://travis-ci.org/FragmentX/FRAGMENTX) [![Maintainability](https://api.codeclimate.com/v1/badges/900fd8a114c8d71e0142/maintainability)](https://codeclimate.com/github/FragmentX/FRAGMENTX/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/900fd8a114c8d71e0142/test_coverage)](https://codeclimate.com/github/FragmentX/FRAGMENTX/test_coverage) [![security](https://hakiri.io/github/FragmentX/FRAGMENTX/master.svg)](https://hakiri.io/github/FragmentX/FRAGMENTX/master)



[//]: # (badges)
[![security](https://img.shields.io/badge/contributors-4-blue)](https://img.shields.io/badge/contributors-4-blue)

[//]: # (badges)

> [FragmentX web](http://scanviewer.herokuapp.com/)
>
> [http://scanviewer.herokuapp.com/](http://scanviewer.herokuapp.com/)
>

## Description
 FragmentX is an open source 3D objects viewer build using Ruby on Rails and Three JS. Is part of an European project in the UPV and the final degree project of one of the creators.

FragmentX tries to bring to museums in particular and people in general a tool to store and visualize masterpieces and any type of 3D objects. Often this kind of objects are fragmented or divided in several pieces. Our 3D viewer is able to show all the fragments of these objects.

The platform created is on the web because we wanted to create a more accessible tool for everybody. It could be used in any device.

## Version
The application is under development. This means that there is not a release or a beta version yet. The FragmentX team and its community is working on its first beta release.

### 0.2 Alpha 20181127
#### Features
* [X] OBJ file format loader
* [X] Orthographic and Perspective cameras switch
* [X] Added continuous Integration
* [X] Added code quality checker
* [X] Added vulnerability checker
* [X] Added dependaBot
#### Bugs
* [X] Orthographic fails when is switched a few times


#### Changes
* [X] Redesigned interface
* [X] Refactored Code


### 0.1 Alpha 20180713

#### Features
* [X] STL file format loader
* [X] ZIP automatic restored object loader
* [X] 3D Restored Object viewer
* [X] Clipping X, Y, Z planes
* [X] Canvas Screenshoot
* [X] Pieces measurement
* [X] Show nearby pieces
* [X] Basic design and lading page
* [X] Async pieces loader using ThreeJS web workers
* [X] Automatic deploy on Heroku
* [X] Translations (English and Spanish)


## Installation

### Dependecies
* Ruby version: [2.6](https://www.ruby-lang.org/es/news/2019/03/13/ruby-2-6-2-released/)
* Rails version: [5.2.3](https://weblog.rubyonrails.org/2019/3/28/Rails-5-2-3-has-been-released/)
* PostgreSQL version:  [9.5](https://www.postgresql.org/docs/9.5/index.html)
* NodeJS version: [10.16.3](https://nodejs.org/uk/blog/release/v0.10.16/)
* gcc and g++ version: [5.4](https://ftp.gnu.org/gnu/gcc/gcc-5.4.0/)

### Recomended
* Ubuntu 16.04~18.04, Kubuntu, or Debian based OS
* Git
### Installation steps

* Update the Ubuntu repositories
```shell
sudo apt-get update
```
* Install basic dependencies for Ruby on Rails (Git is optional)
```shell
sudo apt-get install git
sudo apt install curl
sudo apt install -y nodejs
sudo apt install gcc g++ make
```
* Clone the repo from our master branch
```shell
git clone https://github.com/FragmentX/FRAGMENTX.git
cd FRAGMENTX/
```
* Ruby installation and basic setup of the rvm
```shell
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --ruby
source /home/duxy1996/.rvm/scripts/rvm
rvm install ruby-2.6.1
rvm --default use ruby-2.6.1
```
* Rails 5.2.0 installation
```shell
gem update --system
gem install rails -v 5.2.0
```
* PostgreSQL database installation and postgresql gem installation
```shell
sudo apt install postgresql postgresql-contrib libpq-dev -y
systemctl start postgresql
systemctl enable postgresql
```
* Ruby basic gem installation
```shell
sudo apt-get install  ruby-railties
sudo apt install ruby-bundler
bundle install
```
* Database creation and migration. Applies all the changes made in the migrations folder. It is empty, to feed the database should run ` rails db:seed`. With the `rails s` command the appplication is launched in localhost:3000
```shell
rails db:create
rails db:migrate
rails s
```
#### Optional
PostgreSQL sometimes is not well set up. You have to modify the file **pg_hba.conf** to allow to enter to the database and create the profile/user for manage the application databases.
```shell
sudo gedit /etc/postgresql/9.5/main/pg_hba.conf
```

## Contributors


 [Álvaro Casado Coscollá.](https://github.com/alvarocasadoc) Architect and developer

 [ Carlos Durán Roca.](https://github.com/Duxy1996) Architect and developer

 [Dependa Baller bot.](https://github.com/marketplace/dependabot-preview)

[//]: #  (contributors)




## References


* [Ruby tests for models and controllers](https://guides.rubyonrails.org/testing.html)
* [PostgreSQL test database initialization error](https://stackoverflow.com/questions/19097558/pg-undefinedtable-error-relation-users-does-not-exist)
* [PostgreSQL test fixture error](https://stackoverflow.com/questions/58190137/database-error-on-executing-test-ruby-on-rails-with-postgres)
* [PostgreSQL Travis configuration](https://medium.com/hexient-labs/configuring-travis-ci-for-a-rails-project-d25bc2f2ba7e)

