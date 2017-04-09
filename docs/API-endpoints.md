# API endpoints

## GET

Most GET requests don't need the user to provide an identification token

### /v1/entities
- response :
  - entities : array of [entities object](https://github.com/EcrituresNumeriques/anthologie-apiLite/blob/master/docs/Objects.md#entities-object-)
    

### /v1/entities/([0-9]+)
- response :
  - entities : array of [extended entities object](https://github.com/EcrituresNumeriques/anthologie-apiLite/blob/master/docs/Objects.md#extended-entities-object--extends-entities-object)
  
### /v1/entities/URIs
(This endpoint will soon move to /v1/URILinks/([a-zA-Z0-9_-]+) to be more consistent with the REST philosphy, the [a-zA-Z0-9_-]+ group represents the base64Url [see implementation](https://brockallen.com/2014/10/17/base64url-encoding/) of the URI to be queried)

This endpoint serve the purpose of matching a specific URI with an entity already in the database
- params :
  - uri : URI to the ressource (ex. http://data.perseus.org/citations/urn:cts:greekLit:tlg7000.tlg001.perseus-grc1:5.6 )
- response :
  - entities : array of [URI Link object](https://github.com/EcrituresNumeriques/anthologie-apiLite/blob/master/docs/Objects.md#uri-link-object). Usually one URI link object, or none if no link found
  - query : URI used by the server to query the database (replay of the uri param)

### /v1/authors
### /v1/URIs
### /v1/languages
### /v1/languages/([0-9]+)
### /v1/languages/families
### /v1/languages/families/([a-zA-Zα-ωΑ-Ω]+)
### /v1/align/([0-9]+)/([0-9]+)
### /v1/export
- response :
  - entities : array of [entities object](https://github.com/EcrituresNumeriques/anthologie-apiLite/blob/master/docs/Objects.md#entities-object-)

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
  
### /v1/entities/new/
### /v1/translations/new
### /v1/languages/new
### /v1/images/new
### /v1/URIs/addURId
### /v1/align
### /v1/scholie/new
### /v1/text/new
### /v1/reference/new
