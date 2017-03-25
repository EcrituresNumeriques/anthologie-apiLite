# Objects :

## entities object :
  - book_id: array of books where this entity appears. ex: [1,5,6] (refers to Palatine anthology, Best of litterature and compilation of greek poetry)
  - date: estimated date of creation of the entity. ex -400
  - date_range: possible variation of the estimated date. ex: 50 (means this entity has been written between date-50 and date+50)
  - era_id: classification in specific era. ex: 1 (refers to: delos league)
  - genre_id: Genre of the entity. ex: 1 (refers to : Poetry)
  - id_entity: identifier of the entity. ex: 33
  - title: Title of the entity. ex: "Greek Anthology 5.6"

## extended entities object : (extends entities object)
  - URI : Array of URI object.
  - authors: Array of Authors object.
  - book_id : Array of book IDs where this entity appears in.
  - images : Array of Images associated with this entity
  - keywords : Array of Keyword object
  - refs : Array of Reference object
  - scholies: Array of Scolies object
  - texts: Array of text object
  - translation: Array of Translation object

## URI link object:
  - URN : URN of the ressource (usually URI with the domain name removed) (ex. urn:cts:greekLit:tlg7000.tlg001.perseus-grc1:5.6 )
  - created_at : date of the creation of the ressource (ex. "2017-02-07 12:04:08")
  - deleted_at : date of removal of the ressource (ex. null)
  - entity_id : Entity id linked to the URI (ex. 33)
  - group_id : Group id that has right to manage this URI link (ex. null)
  - id : id of the URI link (ex. 1)
  - updated_at : last modification of the link (ex. 2017-02-07 12:04:08)
  - urid_category_id : (ex. null)
  - urid_source_id : id of the source of the URI (ex. 1 [for perseus])
  - user_id: user id that created the URI link (ex. 2)
  - value : actual URI (ex. http://data.perseus.org/citations/urn:cts:greekLit:tlg7000.tlg001.perseus-grc1:5.6)

## URI object:
## Authors object:
## Keyword object:
## Reference object:
## Scholies object:
## Text object:
## Translation object:
