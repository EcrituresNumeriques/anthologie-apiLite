# Lexicon

- user : 

# API endpoints

## GET

Most GET requests don't need the user to provide an identification token




## POST

Most POST requests require the user to provide an identification token, the two following exemple are the execption:

### /v1/user/login

- POST parameters : 
  - username : Username of the User (required)
  - password : Password of the User (required)

- response : 
  - success : 1 | 0 (1 is a successfull login, 0 is not). ex: 1
  - token : (the token is composed of the three following informations)
    - time : Timestamp of the request. ex: 1489494154
    - token : Token of connection. ex: ZmZkNjQ4MzdiMmMyNjRiZmVhOWZlNTdjYjU3ZDgwNmQ4MzAzNzMwMGQzOTA4MjVhM2IxjEM0MDg1ywE5ZjY2M2I5YjgzZjc2MzI3MZKyMmU5OTIxZjg3MjFhZGQ5ZjAxNTFhY2E2YmNlMjVkZDE2YTIyZWYyN2MwZjAyN2VmNjI
    - user : user id linked to the token. ex: 2
  - username : Username of the User atached to the token. ex : Arthur
  
  
### /v1/user/register

- POST parameters :
  - username : Desired username for the user. (required) ex: arthur
  - password : Desired password for the user. (required) ex: MyPassword$£c|_|re
  - email : Desired email of the user. (required) ex: my.email@domain.com
  - firstName : First name of the user. ex: Arthur
  - lastName : Last name of the user. ex: Juchereau
  - institution : Institution of the user. ex: Université de Montréal
  
- response :
  - success : 1 | 0 (1 is a successfull login, 0 is not). ex: 1
  
  if success is 0 :
  - why : explanation of the problem. ex : Username or Email already used
  
You can then login using the information you provided
  
