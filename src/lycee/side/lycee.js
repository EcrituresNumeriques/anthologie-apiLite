$(document).ready(function(){
  //default mode
  var token = {};
  $target = $("#container");
  $error = $("#error");
  $waiting = $("#waiting");
  $success = $("#success");
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
        loadAPI();
        $.post("/v1/user/login",{username:$("#loginInput").val(),password:$("#passwordInput").val()})
        .done(function(data){
          if(data.success != "1"){
            displayError('something went wrong');
          }
          else{
            showSuccess(success)
            token = data.token;
            //Ask for URI reference
            askURI();
          }
        })
        .always(function(){
          receivedAPI();
        });
      }
    });
  }

  function askURI(){
    //prompt for login
    resetTarget("URI");
    $menuURI = $("<nav>");
    $menuURI.append('<p>Perseus URI : </p>');
    $menuURI.append('<input type="text" id="URI" value="http://data.perseus.org/citations/urn:cts:greekLit:tlg7000.tlg001.perseus-grc1:5.6" placeholder="http://data.perseus.org/citations/urn:cts:greekLit:tlg7000.tlg001.perseus-grc1:5.6">');
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
      $entity.append('<ul class="authors">');
      for (var j = 0; j < data.entities[i].authors.length; j++) {
        var names = [];
        for (var k = 0; k < data.entities[i].authors[j].name.length; k++) {
          names.push(data.entities[i].authors[j].name[k].name);
        }
        $entity.children("ul.authors").append("<li>"+names.join(" / ")+"</li>");
      }


      $target.append($entity);
    }
  }



  function resetTarget(newClass){
    $target.html("").removeClass("login URI entity").addClass(newClass);
  }

  function loadAPI(){
    $waiting.html("<p><i class="fa fa-spinner faa-spin animated"></i> loading</p>")
  }
  function receivedAPI(){
    $waiting.html("");
  }
  function displayError(error){
    $error.slideDown().html('<i class="fa fa-exclamation-triangle" aria-hidden="true"></i> '+error).delay(2000).slideUp();
  }
  function hideError(){
    $error.html("");
  }
  function showSuccess(success){
    $success.slideDown().html('<i class="fa fa-check" aria-hidden="true"></i> '+success).delay(2000).slideUp();
  }
  function hideSuccess(){
    $success.html("");
  }

});
