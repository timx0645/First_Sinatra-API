# First Sinatra API

This is my first attempt at an API builded throught RUBY using Sinatra and Mongoid. </br>
The API is ready for heroku deployment through docker. 

## SETUP to Heroku 
You'll have to have installed: 
* [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli#download-and-install)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [Ruby](https://www.ruby-lang.org/en/downloads/) 

First login to both Heroku and docker:
```
$ heroku login 
```
```
$ docker login 
```
Now get heroku docker plugin
```
$ heroku plugins:install heroku-docker  
```
Configure Docker and Docker Compose:
```
$ heroku docker:init  
```
Then create a heroku app on your heroku:
```
$ heroku create 
```
Push your docker container to heroku to the app you just made
```
$ heroku container:push web --app <your-app> 
```
Release and it's good to go
```
$ heroku container:release web --app <your-app> 
```

* GET
* POST
* PATCH
* DELETE

### GET
Hey

### POST
hey

### PATCH
hey

### DELETE
hey 
