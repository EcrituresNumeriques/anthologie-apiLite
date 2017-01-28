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
        displayLoading('user login');
        $.post("/v1/user/login",{username:$("#loginInput").val(),password:$("#passwordInput").val()})
        .done(function(data){
          if(data.success != "1"){
            displayError('bad credentials');
          }
          else{
            displaySuccess('loged in as '+data.username);
            token = data.token;
            //Ask for URI reference
            askURI();
          }
        })
        .fail(function(){
          displayError('something network related went wrong');
        })
        .always(function(){
          hideLoading();
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
      displayLoading('URI checker');
      cleanMessages();
      $.get("/v1/entities/URIs/",{uri : $("#URI").val()})
      .done(function(data){

        if(data.entities.length > 0){
          //entity found
          displaySuccess('Entity using this URI has been found');
          loadEntity(data.entities[0].entity_id);
        }
        else{
          //create new entity via XML
          displaySuccess('No entity found, creating new one');
          newEntity(data.query);
        }
      })
      .fail(function(){
        displayError('something network related went wrong');
      })
      .always(function(){
        hideLoading();
      });
    });

  }


  function loadEntity(entity_id){
    $.get("/v1/entities/"+entity_id).done(showEntity);
  }

  function newEntity(uri){
    //get XML version of the text
    displayLoading('Getting XML from perseus');
    $.get(uri+"/xml")
    .done(function (xml){
      //getting all needed infos
      var psg = $(xml).find('psg').text();
      var title = $(xml).find('title').text();
      var text = $(xml).find('p').text();
      displaySuccess('New entity created : '+title+' '+psg);
      displaySuccess(text);
    })
    .fail(function(){
      displayError('something network related went wrong');
    })
    .always(function(){
      hideLoading();
    });
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

  function displayLoading(loading){
    $waiting.html('<p><i class="fa fa-spinner faa-spin animated"></i> loading : '+loading+'</p>');
  }
  function hideLoading(){
    $waiting.html("");
  }
  function displayError(error){
    $error.append('<p><i class="fa fa-exclamation-triangle" aria-hidden="true"></i> '+error+'</p>');
  }
  function hideError(){
    $error.html("");
  }
  function displaySuccess(success){
    $success.append('<p><i class="fa fa-check" aria-hidden="true"></i> '+success+'</p>');
  }
  function hideSuccess(){
    $success.html("");
  }
  function cleanMessages(){
    hideSuccess();
    hideError();
  }

});
