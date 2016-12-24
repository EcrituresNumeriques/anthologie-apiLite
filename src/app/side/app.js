$(document).ready(function(){
  //default mode
  var token = {};

  //init script
  init(loadEntities);







//Init script
function init(callback){
  //event handler for each sections
  $("loadEntities").on("click",loadEntities);
  $("loadAuthors").on("click",loadAuthors);
  $("loadKeywords").on("click",loadKeywords);
  //login user
  $("#logMeInP").on("click",logMeIn);
  callback();
}

function loadEntities(){
//generate first column
  $header = $('<header />').append('<h1/>').children('h1').html("Entities");
  $newEntity = $('<article id="newEntity" class="clickMe"/>').children("article").append('<p/>').children("p").html('  <i class="fa fa-plus-circle" aria-hidden="true"></i> New entity');
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

function loadAuthors(){
//generate first column
  $header = $('<header />').append('<h1/>').children('h1').html("Authors");
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
  $.get("/v1/entities").done(displayEntities);
}

function loadKeywords(){
//generate first column
  $header = $('<header />').append('<h1/>').children('h1').html("Keywords");
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
  $.get("/v1/entities").done(displayEntities);
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
  eventHandler()
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
    $("#entity > section").append('<article class="shade"><h2>Alternate title(s)</h2></article>');
    $addNewTitle = $('<article><p><i class="fa fa-plus-circle" aria-hidden="true"></i> Add title</p></article>').addClass("newTitle clickMe").data("entity",data.entities[i].id_entity);
    $("#entity > section").append($addNewTitle);

    //display translated titles
    for(j=0;j<data.entities[i].titleTranslation.length;j++){
      $titleTranslation = $("<article/>");
      $titleTranslation.append("<p/>");
      $titleTranslation.children("p").append('<span class="lang">['+data.entities[i].titleTranslation[j].lang+']</span>');
      $titleTranslation.children("p").append('<span class="translation">'+data.entities[i].titleTranslation[j].text_translated+'</span>');
      $("#entity > section").append($titleTranslation);
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
    $.post("v1/entities/new",{time:token.time,user:token.user,token:token.token,title:$("#newEntityInputTitle").val()})
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
  $("#action > section").append('<article><input name="language" placeholder="language" class="block full"><textarea name="translation" placeholder="type in your translation" class="block full"></textarea><input type="button" class="block right" value="submit"></article>');
}


  function eventHandler(){
    //add new entity
    $("#newEntity").off("click").on("click",newEntity);

    //add new title
    $(".newTitle").off("click").on("click",newEntityTitle);

    //add new author

    //add new translation
    $(".newTranslation").on("click",addNewTranslation);
  }

});
