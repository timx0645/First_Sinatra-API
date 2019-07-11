# First Sinatra API

This is my first attempt at an API builded throught RUBY using Sinatra and Mongoid. </br>
The API is ready for heroku deployment through docker. 

## About 
The API 

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
Release you're almost good to go
```
$ heroku container:release web --app <your-app> 
```

Last get an online MongoDB, and paste the URI as an environment variables in heruko. </br>
<your-app> -> settings -> reveal config vars </br>
key = CLUSTER_0_PSW
value = <your-URI>

## How to use the API through javascript
The API is made to GET, POST, PATCH and DELETE Businesses in a MongoDB. </br>
The Business model is like: 
```json 
[
  {
    "name": "String value",
    "address": "String value",
    "city": "String value",
    "country": "String value",
    "email": "String value",
    "phone": "String value"
  }
]
```
### GET
Here you get all the Businesses in your MongoDB:
```javascript 
  fetch(`${your-herokuapp-url}/api/firma`)
          .then(response => response.json())
          .then(data => 
          //Do something with your data
          )
```

### POST
Here you add a new Business to your MongoDB:
```javascript 
  fetch(`${your-herokuapp-url}/api/firma`, {
          method: 'POST',
          headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
          },
          body: JSON.stringify({
             name: "String value",
             address: "String value",
             city: "String value",
             country: "String value",
             email: "String value",
             phone: "String value"
          })        
        })
```

### PATCH
Here you can update an existing Business in your MongoDB
```javascript 
  fetch(`${your-herokuapp-url}/api/firma/<Business-ID>`, {
          method: 'PATCH',
          headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
          },
          body: JSON.stringify({
             name: "String value",
             address: "String value",
             city: "String value",
             country: "String value",
             email: "String value",
             phone: "String value"
          })        
        })
```

### DELETE
Here you delete a Business in your MongoDB:
```javascript 
  fetch(`${your-herokuapp-url}/api/firma/<Business-ID>`, {
            method: 'DELETE',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
            }})
```
