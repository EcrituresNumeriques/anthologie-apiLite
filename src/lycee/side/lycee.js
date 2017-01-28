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
          displaySuccess('No entity found');
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
    displayLoading('Loading entity');
    $.get("/v1/entities/"+entity_id).done(showEntity)
    .fail(function(){
      displayError('something network related went wrong');
    })
    .always(function(){
      hideLoading();
    });;
  }

  function newEntity(uri){
    //get XML version of the text
    displayLoading('Getting XML from perseus');
    var uriSave = uri;
    $.get(uri+"/xml")
    .done(function(xml){
      parsePerseus(xml,uriSave);
    })
    .fail(function(){
      displayError('something network related went wrong');
    })
    .always(function(){
      hideLoading();
    });
  }


  function parsePerseus(xml,uri){
    displayLoading('Creating new entity...');
    //getting all needed infos
    var title = $(xml).find('title').text() +' '+$(xml).find('psg').text();
    var text = $(xml).find('p').text();
    if(title && title.length > 0 && text && text.length > 0){
      displayLoading('Creating new entity');
      $.post("/v1/entities/new",{time:token.time,user:token.user,token:token.token,title:title})
      .done(function(data){
        var newEntityId = data.newEntityId;
        displaySuccess('New entity created : '+title);

        //adding URI
        displayLoading('Adding URI to newly created entity');
        $.post("/v1/URIs/addURId",{time:token.time,user:token.user,token:token.token,URI:1,entity:newEntityId,destination:uri})
        .done(function(data){
          displaySuccess('URI linked to newly created entity');

          //adding text translation
          displayLoading('Adding greek text to newly created entity');
          $.post("/v1/translations/new",{time:token.time,user:token.user,token:token.token,language:12,text:text,entity:newEntityId})
          .done(function(data){
            displaySuccess('Greek text added to the newly created entity');

            //display entity
            loadEntity(newEntityId);
          })
          .fail(function(){
            displayError('something network related went wrong');
          })
          .always(function(){
            hideLoading();
          });

        })
        .fail(function(){
          displayError('something network related went wrong');
        })
        .always(function(){
          hideLoading();
        });

        //display entity
        $.get("/v1/entities/"+data.newEntityId).done(showEntity);
      })
      .fail(function(){
        displayError('something network related went wrong');
      })
      .always(function(){
        hideLoading();
      });
    }
    else{
      displayError('Unable to parse URI provided');
    }
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
      $target.append('<nav id="backToUri"><p>Back to URI input</p></nav>');
      $("#backToUri").on("click",function(){
        cleanMessages();
        askURI();
      });
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
