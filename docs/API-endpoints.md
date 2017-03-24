# Lexicon

- user : 

# Objects :

- entities object :
  - book_id: array of books where this entity appears. ex: [1,5,6] (refers to Palatine anthology, Best of litterature and compilation of greek poetry)
  - date: estimated date of creation of the entity. ex -400
  - date_range: possible variation of the estimated date. ex: 50 (means this entity has been written between date-50 and date+50)
  - era_id: classification in specific era. ex: 1 (refers to: delos league)
  - genre_id: Genre of the entity. ex: 1 (refers to : Poetry)
  - id_entity: identifier of the entity. ex: 33
  - title: Title of the entity. ex: "Greek Anthology 5.6"

- extended entities object : (extends entities object)
  - URI : Array of URI object.
  - authors: Array of Authors object.
  - book_id : Array of book IDs where this entity appears in.
  - images : Array of Images associated with this entity
  - keywords : Array of Keyword object
  - refs : Array of Reference object
  - scholies: Array of Scolies object
  - texts: Array of text object
  - translation: Array of Translation object

- URI object:
- Authors object:
- Keyword object:
- Reference object:
- Scholies object:
- Text object:
- Translation object:


# API endpoints

## GET

Most GET requests don't need the user to provide an identification token

### /v1/entities
- response :
  -entities : array of entities object
    

### /v1/entities/([0-9]+)
- response :
  -entities : array of extended entities object (only the id specified in the ([0-9]+)
  
### /v1/entities/URIs/
### /v1/authors
### /v1/URIs
### /v1/languages
### /v1/languages/([0-9]+)
### /v1/languages/families
### /v1/languages/families/([a-zA-Zα-ωΑ-Ω]+)
### /v1/align/([0-9]+)/([0-9]+)
### /v1/export

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