$(document).ready(function(){
  //default mode
  var token = {};

  //init script
  init(loadEntities);







//Init script
function init(callback){
  //event handler for each sections
  $("#loadEntities").on("click",loadEntities);
  $("#loadLangs").on("click",loadLangs);
  $("#loadAuthors").on("click",loadAuthors);
  $("#loadKeywords").on("click",loadKeywords);
  //login user
  $("#logMeInP").on("click",logMeIn);
  callback();
}

function loadEntities(){
//generate first column
  $header = $('<header />').append('<h1>Entities</h1>');
  $newEntity = $('<article/>').attr("id","newEntity").addClass("clickMe").append('<p/>').children("p").html('  <i class="fa fa-plus-circle" aria-hidden="true"></i> New entity').parent();
  $searchEntity = $('<article/>').append('<input type="text" name="entity" value="" id="findEntityInput" placeholder="find entity" class="clickMe" autocomplete="off">');
  $nav = $('<nav/>').append($newEntity).append($searchEntity);
  $sectionEntities = $('<section id="entities"/>').append($header).append($nav).append('<section/>');
//second column
  $sectionEntity = $('<section id="entity"/>').append("<header><h1>Entity</h1></header>").append("<section/>");
//third column
  $sectionAction = $('<section id="action"/>').append("<header><h1>Action</h1></header>").append("<section/>");
//display column
  $("body > main").html('').append($sectionEntities).append($sectionEntity).append($sectionAction);
//feed first column
  $.get("/v1/entities").done(displayEntities);
}

function loadLangs(){
//generate first column
  $header = $('<header />').append('<h1>Families</h1>');
  $newEntity = $('<article id="newLang" class="clickMe"/>').append('<p/>').children("p").html('  <i class="fa fa-plus-circle" aria-hidden="true"></i> New language').parent();
  $searchEntity = $('<article/>').append('<input type="text" name="family" value="" id="findFamilyInput" placeholder="find family" class="clickMe" autocomplete="off">');
  $nav = $('<nav/>').append($newEntity).append($searchEntity);
  $firstColumn = $('<section id="families"/>').append($header).append($nav).append('<section/>');
//second column
  $secondColumn = $('<section id="languages"/>').append("<header><h1>Languages</h1></header>").append("<section/>");
//third column
  $thirdColumn = $('<section id="action"/>').append("<header><h1>Language</h1></header>").append("<section/>");
//display column
  $("body > main").html('').append($firstColumn).append($secondColumn).append($thirdColumn);
//feed first column
  $.get("/v1/languages/families").done(displayFamilies);
}

function loadAuthors(){
//generate first column
  $header = $('<header />').append('<h1>Authors</h1>');
  $newEntity = $('<article id="newEntity" class="clickMe"/>').children("article").append('<p/>').children("p").html('  <i class="fa fa-plus-circle" aria-hidden="true"></i> New entity');
  $searchEntity = $('<article/>').append('<input type="text" name="entity" value="" id="findEntityInput" placeholder="find entity" class="clickMe" autocomplete="off">');
  $nav = $('<nav/>').append($newEntity).append($searchEntity);
  $sectionEntities = $('<section id="entities"/>').append($header).append($nav).append('<section/>');
//second column
  $sectionEntity = $('<section id="entity"/>').append("<header><h1>Author</h1></header>").append("<section/>");
//third column
  $sectionAction = $('<section id="action"/>').append("<header><h1>Action</h1></header>").append("<section/>");
//display column
  $("body > main").html('').append($sectionEntities).append($sectionEntity).append($sectionAction);
//feed first column
  //$.get("/v1/entities").done(displayEntities);
}

function loadKeywords(){
//generate first column
  $header = $('<header />').append('<h1>Keywords</h1>');
  $newEntity = $('<article id="newEntity" class="clickMe"/>').children("article").append('<p/>').children("p").html('  <i class="fa fa-plus-circle" aria-hidden="true"></i> New entity');
  $searchEntity = $('<article/>').append('<input type="text" name="entity" value="" id="findEntityInput" placeholder="find entity" class="clickMe" autocomplete="off">');
  $nav = $('<nav/>').append($newEntity).append($searchEntity);
  $sectionEntities = $('<section id="entities"/>').append($header).append($nav).append('<section/>');
//second column
  $sectionEntity = $('<section id="entity"/>').append("<header><h1>Keyword</h1></header>").append("<section/>");
//third column
  $sectionAction = $('<section id="action"/>').append("<header><h1>Action</h1></header>").append("<section/>");
//display column
  $("body > main").html('').append($sectionEntities).append($sectionEntity).append($sectionAction);
//feed first column
  //$.get("/v1/entities").done(displayEntities);
}


//functions
function logMeIn(){
  //check if $this has a child nav, if yes, remove it, else show it
  if($(this).parent("div").children("nav").length > 0){
    $(this).parent("div").children("nav").remove();
  }
  else{
    $menuLogin = $('<nav/>');
    $menuLogin.append('<input type="text" id="loginInput" value="" placeholder="Login">');
    $menuLogin.append('<input type="password" id="passwordInput" value="" placeholder="password">');
    $menuLogin.append('<input type="button" id="goLogIn" value="Go">');
    $(this).parent("div").append($menuLogin);
    $("#goLogIn").on("click",function(){
      if($("#loginInput").val() != "" && $("#passwordInput").val() != ""){
        $.post("/v1/user/login",{username:$("#loginInput").val(),password:$("#passwordInput").val()})
        .done(function(data){
          if(data.success != "1"){
            alert('something went wrong');
          }
          else{
            $("#logMeIn").children("nav").remove();
            $("#logMeIn").html('<p><i class="fa fa-user" aria-hidden="true"></i> '+data.username+'</p>');
            token = data.token;
          }
        });
      }
    });
  }
}


//feed left column + actions
function displayEntities(data){
  $("#entities > section").html('');
  for(i=0;i<data.entities.length;i++){
    $entity = $("<article/>");
    $entity.attr("id","entity"+data.entities[i].id_entity).data("id",data.entities[i].id_entity).addClass("entity").addClass("clickMe");
    $entity.append('<p/>');
    $entity.children("p").html(data.entities[i].title);
    $("#entities > section").append($entity);
  }
  $("#findEntityInput").on("input",function(){
    $("#entities > section > article").addClass("hidden");
    $("#entities > section > article > p:contains("+$(this).val()+")").parent("article").removeClass("hidden");
  });
  $(".entity").on("click",loadEntity);
  eventHandler();
}

//load entity in the second row
function loadEntity(){
  $.get("/v1/entities/"+$(this).data("id")).done(displayEntity);
}

//display Entity in the second column
function displayEntity(data){
  $("#entity > section").html('');
  $("#action > section").html("");
  for(i=0;i<data.entities.length;i++){
    $entity = $("<article/>");
    $entity.attr("id","entity"+data.entities[i].id_entity).data("id",data.entities[i].id_entity).addClass("entity");
    $entity.append('<h1/>');
    $entity.children("h1").html(data.entities[i].title);


    $("#entity > section").append($entity);

    //header Alternate Title
    $("#entity > section").append('<article class="shade"><h2>URI(s)</h2></article>');
    $addNewTitle = $('<article><p><i class="fa fa-plus-circle" aria-hidden="true"></i> Add URI</p></article>').addClass("newURI clickMe").data("entity",data.entities[i].id_entity);
    $("#entity > section").append($addNewTitle);
    for(j=0;j<data.entities[i].URI.length;j++){
      $URI = $("<article/>");
      $URI.addClass("clickMe");
      $URI.append('<p><a href="'+data.entities[i].URI[j].value+'" target="_blank"><span class="name">['+data.entities[i].URI[j].name+']<span> <span class="translation">'+data.entities[i].URI[j].URN+'</span></a></p>');
      $("#entity > section").append($URI);
    }

    //header Authors
    $("#entity > section").append('<article class="shade"><h2>Author(s)</h2></article>');
    $addNewAuthor = $('<article><p><i class="fa fa-plus-circle" aria-hidden="true"></i> Add Author</p></article>').addClass("newAuthor clickMe").data("entity",data.entities[i].id_entity);
    $("#entity > section").append($addNewAuthor);

    //display all authors + add new one
    for(j=0;j<data.entities[i].authors.length;j++){
      $author = $("<article/>");
      $author.addClass("clickMe").addClass("author").data("id",data.entities[i].authors[j].id);
      $author.append('<p class="date"><span class="born">'+data.entities[i].authors[j].born+' (± '+data.entities[i].authors[j].born_range+')</span><span class="died">'+data.entities[i].authors[j].died+' (± '+data.entities[i].authors[j].died_range+')</span></p>');
      for(k=0;k<data.entities[i].authors[j].name.length;k++){
        $author.append('<p><span class="lang">['+data.entities[i].authors[j].name[k].lang+']<span> <span class="translation">'+data.entities[i].authors[j].name[k].name+'</span></p>');
      }
      $("#entity > section").append($author);
    }

    //translations header
    $("#entity > section").append('<article class="shade"><h2>Translation(s)</h2></article>');
    $addNewTranslation = $('<article><p><i class="fa fa-plus-circle" aria-hidden="true"></i> Add translation</p></article>').addClass("clickMe newTranslation").data("entity",data.entities[i].id_entity);
    $("#entity > section").append($addNewTranslation);

    //display translation
    for(j=0;j<data.entities[i].translation.length;j++){
      $titleTranslation = $("<article/>");
      $titleTranslation.append("<p/>");
      $titleTranslation.children("p").append('<span class="lang">['+data.entities[i].translation[j].lang+'] </span>');
      $titleTranslation.children("p").append('<span class="translation">'+data.entities[i].translation[j].text_translated+'</span>');
      $("#entity > section").append($titleTranslation);
    }
    //display all translation + add new one

  }
  eventHandler();
}

//create new entity
function newEntity(){
  $("#entity > section").html("");
  $("#entity > section").append('<article class="shade"><h2>New entity</h2></article>');
  $("#entity > section").append('<article><input class="block full" type="text" value="" autocompletion="off" placeholder="Generic title" id="newEntityInputTitle"><input id="goNewEntity" type="button" class="block full right" value="Add"></article>');
  $("#goNewEntity").on("click",function(){
    $.post("/v1/entities/new",{time:token.time,user:token.user,token:token.token,title:$("#newEntityInputTitle").val()})
    .done(function(data){
      $.get("/v1/entities").done(displayEntities);
      $.get("/v1/entities/"+data.newEntityId).done(displayEntity);
    })
    .fail(function(data){
      alert('something went wrong, are you loged in and provided a title?');
    });
  });
}

//add new title to an entity
function newEntityTitle(){

}

function addNewTranslation(){
  $("#action > section").html("");
  $("#action > section").append('<article class="shade"><h2>Add a new Translation</h2></article>');
  $("#action > section").append('<article><input type="hidden" id="entityId" value="'+$(this).data("entity")+'"><select id="selectLanguages" name="language" placeholder="language"></select><textarea id="textTranslation" name="translation" placeholder="type in your translation" class="block full"></textarea><input type="button" class="block right" value="submit"></article>');
  $.get("/v1/languages",selectLanguages);
  $("#action > section > article > input[type=button]").off("click").on("click",sendNewTranslation);
}
function sendNewTranslation(){
  $.post("/v1/translations/new",{time:token.time,user:token.user,token:token.token,language:$("#selectLanguages").val(),text:$("#textTranslation").val(),entity:$("#entityId").val()})
  .done(function(data){
    $.get("/v1/entities/"+$("#entityId").val()).done(displayEntity);
  })
  .fail(function(data){
    alert('something went wrong, are you loged in and provided a family/name for the new language?');
  });
}

function selectLanguages(data){
  for (var i = 0; i < data.langs.length; i++) {
    $("#selectLanguages").append('<option value="'+data.langs[i].id_lang+'">'+data.langs[i].name+'</option>');
  }
}

function addURI(){
  $addURI = $("<article/>").append('<label>source : </label><br><select id="selectURI"/>').append('<input type="hidden" value="'+$(this).data('entity')+'" id="URIentity" name="entity"><br><label>URI : </label><br><input type="text" id="source"><input type="button" id="sendURI" class="block right" value="submit">');
  $("#action > section").html('').append($addURI);
  getURIs();
  $("#sendURI").off("click").on("click",sendURId);
}

function getURIs($appendTO){
  $.get("/v1/URIs",function(data){
    for (var i = 0; i < data.URIs.length; i++) {
      $("#selectURI").append('<option value="'+data.URIs[i].id_URI+'">'+data.URIs[i].name+'</option>');
    }
  });
}
function sendURId(){
  $.post("/v1/URIs/addURId",{time:token.time,user:token.user,token:token.token,URI:$("#selectURI").val(),entity:$("#URIentity").val(),destination:$("#source").val()})
  .done(function(data){
    $.get("/v1/entities/"+$("#URIentity").val()).done(displayEntity);
  })
  .fail(function(data){
    alert('something went wrong, are you loged in and provided a source/URI for this entity?');
  });
}

function displayFamilies(data){
  $("#families > section").html('');
  for(i=0;i<data.lang_families.length;i++){
    $entity = $("<article/>");
    $entity.attr("id","entity"+data.lang_families[i].family).data("family",data.lang_families[i].family).addClass("entity").addClass("clickMe");
    $entity.append('<p/>');
    $entity.children("p").html(data.lang_families[i].family);
    $("#families > section").append($entity);
  }
  $("#findFamilyInput").on("input",function(){
    $("#families > section > article").addClass("hidden");
    $("#families > section > article > p:contains("+$(this).val()+")").parent("article").removeClass("hidden");
  });
  $(".entity").on("click",loadFamily);
  eventHandler();
}
//load family in the second row
function loadFamily(){
  $.get("/v1/languages/families/"+$(this).data("family")).done(displayFamily);
}
function displayFamily(data){
  $("#languages > section").html('');
  $("#action > section").html("");
  //add header
  $("#languages > section").append('<article/>').children('article').append('<h1/>').children('h1').html(data.langs[0].family);

  //add new language
  $("#languages > section").append('<article/>').children('article').last().addClass("clickMe newLang").data("family",data.langs[0].family).append('<p/>').children('p').html('<i class="fa fa-plus-circle" aria-hidden="true"></i> Add language');


  //display languages
  for(i=0;i<data.langs.length;i++){
    $language = $("<article/>");
    $language.append('<p/>').children('p').html(data.langs[i].name);
    $language.attr("id","language"+data.langs[i].id_lang).data("id",data.langs[i].id_lang).addClass("entity lang clickMe");
    $("#languages > section").append($language);
  }
  $(".lang").off("click").on("click",function(){
    $.get("/v1/languages/"+$(this).data("id")).done(displayLanguage);
  });
  eventHandler();
}
  function addNewLanguage(){
    //console.log("adding new languages");
    $("#languages > section").html('');
    $("#languages > section").append('<article class="shade"><h2>Add a new Language</h2></article>');
    $("#languages > section").append('<datalist id="languageFamilies"/>');
    $("#families > section > article").each(function(){
      $("#languages > section > datalist").append('<option value="'+$(this).data("family")+'"/>');
    });
    $("#languages > section").append('<article><input id="newLanguageFamily" type="text" name="family" list="languageFamilies" value="" placeholder="family"><input id="newLanguageName" type="text" name="lang" value="" placeholder="name"><input type="button" class="block right" value="submit"></article>');
    $("#languages > section > article > input[type=button]").off("click").on("click",sendNewLanguage);
  }
  function addNewLanguageByFamily(){
    //console.log("adding new languages"+$(this).data("family"));
    var rememberFamily = $(this).data("family");
    $("#languages > section").html('');
    $("#languages > section").append('<article class="shade"><h2>Add a new Language</h2></article>');
    $("#languages > section").append('<datalist id="languageFamilies"/>');
    $("#families > section > article").each(function(){
      $("#languages > section > datalist").append('<option value="'+$(this).data("family")+'"/>');
    });
    $("#languages > section").append('<article><input id="newLanguageFamily" type="text" name="family" list="languageFamilies" value="'+rememberFamily+'" placeholder="family"><input id="newLanguageName" type="text" name="lang" value="" placeholder="name"><input type="button" class="block right" value="submit"></article>');
    $("#languages > section > article > input[type=button]").off("click").on("click",sendNewLanguage);
  }
  function sendNewLanguage(){
    $.post("v1/languages/new",{time:token.time,user:token.user,token:token.token,family:$("#newLanguageFamily").val(),name:$("#newLanguageName").val()})
    .done(function(data){
      $.get("/v1/languages/families").done(displayFamilies);
      $.get("/v1/languages/families/"+decodeURIComponent($("#newLanguageFamily").val())).done(displayFamily);
      $.get("/v1/languages/"+data.newLanguageId).done(displayLanguage);
    })
    .fail(function(data){
      alert('something went wrong, are you loged in and provided a family/name for the new language?');
    });
  }
  function displayLanguage(data){
    for (var i = 0; i < data.langs.length; i++) {
      $("#action > section").append("<article><h1>"+data.langs[i].name+"</h1></article>");
      $("#action > section").append("<article><p>created at : "+data.langs[i].created_at+"</p></article>");
      $("#action > section").append("<article><p>updated at : "+data.langs[i].updated_at+"</p></article>");
    }
  }


  function eventHandler(){
    //add new entity
    $("#newEntity").off("click").on("click",newEntity);

    //add new URI
    $(".newURI").off("click").on("click",addURI);

    //add new author

    //add new translation
    $(".newTranslation").off("click").on("click",addNewTranslation);

    //add new Language
    $("#newLang").off("click").on("click",addNewLanguage);
    $(".newLang").off("click").on("click",addNewLanguageByFamily);
  }

});
