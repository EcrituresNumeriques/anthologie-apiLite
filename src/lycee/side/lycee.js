$(document).ready(function(){
  //default mode
  var token = {};
  $target = $("#container");
  init();



  function init(){
    //prompt for login
    resetTarget("login");
    $menuLogin = $("<nav>");
    $menuLogin.append('<input type="text" id="loginInput" value="" placeholder="Login">');
    $menuLogin.append('<input type="password" id="passwordInput" value="" placeholder="password">');
    $menuLogin.append('<input type="button" id="goLogIn" value="Go">');
    $target.append($menuLogin);
    $("#goLogIn").on("click",function(){
      if($("#loginInput").val() != "" && $("#passwordInput").val() != ""){
        $.post("/v1/user/login",{username:$("#loginInput").val(),password:$("#passwordInput").val()})
        .done(function(data){
          if(data.success != "1"){
            alert('something went wrong');
          }
          else{
            token = data.token;
            //Ask for URI reference
            askURI();
          }
        });
      }
    });
  }

  function askURI(){
    //prompt for login
    resetTarget("URI");
    $menuURI = $("<nav>");
    $menuURI.append('<p>Perseus URI : </p>');
    $menuURI.append('<input type="text" id="URI" value="" placeholder="http://data.perseus.org/citations/urn:cts:greekLit:tlg7000.tlg001.perseus-grc1:5.6">');
    $menuURI.append('<input type="button" id="goURI" value="Go">');
    $target.append($menuURI);
    $("#goURI").on("click",function(){
      $.get("/v1/entities/URIs/",{uri : $("#URI").val()})
      .done(function(data){

        if(data.entities.length > 0){
          //entity found
          loadEntity(data.entities[0].entity_id);
        }
        else{
          //create new entity via XML
          newEntity(data.query);
        }
      });
    });

  }


  function loadEntity(entity_id){
    console.log("loading entity : "+entity_id);
    $.get("/v1/entities/"+entity_id).done(showEntity);
  }

  function newEntity(uri){
    console.log("creating new entity : "+uri);
  }

  function showEntity(data){
    resetTarget("entity");
    for(i=0;i<data.entities.length;i++){
      $entity = $("<nav>");
      $entity.append("<p>Title : "+data.entities[i].title+"</p>");
      $entity.append("<p>Author(s) : </p>");
      $entity.append("<ul>");
      for (var j = 0; j < data.entities[i].authors.length; j++) {
        var names = [];
        for (var k = 0; k < data.entities[i].authors[j].name.length; k++) {
          names.push(data.entities[i].authors[j].name[k].name);
        }
        $entity.children("ul").append("<li>"+names.join(" / ")+"</li>");
      }
      $target.append($entity);
    }
  }



  function resetTarget(newClass){
    $target.html("").removeClass("login URI entity").addClass(newClass);
  }

});
