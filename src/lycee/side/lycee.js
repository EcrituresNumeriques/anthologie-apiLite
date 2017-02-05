$(document).ready(function(){
  //default mode
  var token = {};
  $target = $("#container");
  $error = $("#error");
  $waiting = $("#waiting");
  $success = $("#success");
  $cta = $("#cta");
  init();



  function init(){
    //prompt for login
    resetTarget("login");
    $menuLogin = $("<nav>");
    $menuLogin.append('<input type="text" id="loginInput" value="" placeholder="Login">');
    $menuLogin.append('<input type="password" id="passwordInput" value="" placeholder="password">');
    $menuLogin.append('<input type="button" id="goLogIn" value="Go">');
    $menuLogin.append('<p><a id="orRegister">Or register</a></p>');
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
            cleanMessages();
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
    $("#orRegister").on("click",register);
  }

  function register(){
    resetTarget('register');
    $register = $('<nav>');
    $register.append('<input type="text" id="username" name="username" value="" placeholder="Login*">');
    $register.append('<input type="password" id="password" name="password" value="" placeholder="Password*">');
    $register.append('<input type="text" id="email" name="email" value="" placeholder="Email*">');
    $register.append('<input type="text" id="firstName" name="firstName" value="" placeholder="First name">');
    $register.append('<input type="text" id="lastName" name="lastName" value="" placeholder="Last name">');
    $register.append('<input type="text" id="institution" name="institution" value="" placeholder="Institution">');
    $register.append('<input type="button" id="goRegister" value="Go">');
    $target.append($register);
    $cta.append('<p id="goToLogin">Go back to login</p>');
    $("#goToLogin").on('click',function(){
      hideCTA();
      init();
    });
    $("#goRegister").on("click",function(){
      cleanMessages();
      displayLoading('Registering');
      $.post("/v1/user/register",{username:$("#username").val(),password:$("#password").val(),email:$("#email").val(),firstName:$("#firstName").val(),lastName:$("#lastName").val(),institution:$("#institution").val()})
      .done(function(data){
        displaySuccess('Account created');
        init();
      })
      .fail(function(xhr){
        var data = JSON.parse(xhr.responseText);
        console.log(data);
        $cta.append('<p id="goToLogin">Go back to login</p>');
        $("#goToLogin").on('click',function(){
          hideCTA();
          init();
        });
        displayError(data.why);
      })
      .always(function(){
        hideLoading();
      });
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
    var authors = [];
    $(xml).find('persName').each(function(){
      authors.push({uri:'http://catalog.perseus.org/catalog/urn:cts:greekLit:'+$(this).attr("key"),name:$(this).children("foreign").first().text()});
    });
    if(title && title.length > 0 && text && text.length > 0){
      displayLoading('Creating new entity');
      $.post("/v1/entities/new",{time:token.time,user:token.user,token:token.token,title:title})
      .done(function(data){
        var newEntityId = data.newEntityId;
        displaySuccess('New entity created : '+title);

        //adding URI
        displayLoading('Adding URI to newly created entity');
        $.post("/v1/URIs/addURId",{time:token.time,user:token.user,token:token.token,URI:1,entity:newEntityId,destination:uri,authors:authors})
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
      $entity.append("<h1>"+data.entities[i].title+"</h1>");
      $entity.append("<h2>Author(s)</h2>");
      $entity.append('<ul class="authors">');
      for (var j = 0; j < data.entities[i].authors.length; j++) {
        var names = [];
        if(data.entities[i].authors[j].name[0].name == null){
          names = [data.entities[i].authors[j].defaultName];
        }
        else{
          for (var k = 0; k < data.entities[i].authors[j].name.length; k++) {
            names.push(data.entities[i].authors[j].name[k].name);
          }
        }
        $entity.children("ul.authors").append("<li>"+names.join(" / ")+"</li>");
      }
      $entity.append('<h2>Translation(s)</h2>');
      $entity.append('<ul class="translation">');
      $entity.children("ul.translation").append('<li class="newStuff" id="newTranslation"><i class="fa fa-plus-circle" aria-hidden="true"></i> Add new Translation</li>');
      for (var j = 0; j < data.entities[i].translation.length; j++) {
        $entity.children("ul.translation").append('<li class="lang">['+data.entities[i].translation[j].family+' / '+data.entities[i].translation[j].lang+']</li><li class="text" data-id="'+data.entities[i].translation[j].id+'">'+nl2br(data.entities[i].translation[j].text_translated)+'</li>');
      }

      $entity.append('<h2>Image(s)</h2>');
      $entity.append('<ul class="images">');
      $entity.children("ul.images").append('<li class="newStuff" id="newImage"><i class="fa fa-plus-circle" aria-hidden="true"></i> Add new Image</li>');
      for (var j = 0; j < data.entities[i].images.length; j++) {
        $entity.children("ul.images").append('<li class="img"><a href="'+data.entities[i].images[j].URL+'" target="_blank"><img src="'+data.entities[i].images[j].URL+'"></a</li>');
      }

      $target.append($entity);
      hideCTA();
      $cta.append('<p>Back to URI input</p>');

      var thisData = data;
      $("#newTranslation").on("click",function(){
        cleanMessages();
        addNewTranslation(thisData.entities[0].id_entity);
      });
      $("#newImage").on("click",function(){
        cleanMessages();
        addNewImage(thisData.entities[0].id_entity);
      });
      $(".lang").on("click",function(){
        $(this).next(".text").slideToggle().toggleClass("opened");
        if($(".opened").length == 2){
            $(".opened").addClass("align");
            $(".align").append('<i class="fa fa-link alignThose" aria-hidden="true"></i>');
        }
        else{
          $(".align").removeClass("align");
          $(".alignThose").remove();
        }
        $(".alignThose").off("click").on("click",function(){
          var idAlign = [];
          $(".alignThose").parent(".text").each(function(){
            idAlign.push($(this).data("id"));
          });
          $.get("/v1/translation/"+idAlign[0]+"/"+idAlign[1]).done(alignTranslations);
          console.log(idAlign);
        });
      });
      $cta.off("click").on("click",function(){
        cleanMessages();
        askURI();
      });
    }
  }

  function alignTranslations(data){
    cleanMessages();
    resetTarget("alignTranslations");
    $form = $('<nav>');
    $form.append('<h2>Align Translations</h2>');
    $form.append('<p style="margin-top:3em">'+nl2br(data.translation[0].text_translated)+'</p>');
    $form.append('<p style="margin-top:3em">'+nl2br(data.translation[1].text_translated)+'</p>');
    $target.append($form);
  }

  function addNewImage(id_entity){
        resetTarget("newImage");
        $form = $('<form id="newImage">');
        $form.append('<h2>Add a new Image</h2>');
        $form.append('<input type="hidden" name="entity" id="entityId" value="'+id_entity+'">');
        $form.append('<input type="text" name="url" id="URLImage" placeholder="URL of the image (ex : http://www.cliolamuse.com/IMG/jpg/grec_vase_red.jpg)">');
        $form.append('<input type="text" name="title" id="titleImage" placeholder="Title">');
        $form.append('<input type="text" name="credit" id="creditImage" placeholder="credits">');
        $form.append('<input type="button" class="block right" value="submit">');
        $form.children("input[type=button]").off("click").on("click",sendNewImage);
        $target.append($form);
        $cta.append('<p id="goToEntity" data-id="'+id_entity+'">Go back to entity</p>');
        $cta.off("click").on("click",function(){
          loadEntity($(this).children("#goToEntity").data("id"));
        });
  }
  function sendNewImage(){
    var formData = new FormData($("#newImage")[0]);
    formData.append("time",token.time);
    formData.append("user",token.user);
    formData.append("token",token.token);

    $.post("/v1/images/new",{time:token.time,user:token.user,token:token.token,url:$("#URLImage").val(),title:$("#titleImage").val(),credit:$("#creditImage").val(),entity:$("#entityId").val()})
    .done(function(data){
      displaySuccess('New Image was added');
      loadEntity($("#entityId").val());
    })
    .fail(function(data){
      displayError('Unable to add new Image');
      loadEntity($("#entityId").val());
    })
    .always(function(data){
      hideLoading();
    });
  }

  function addNewTranslation(id_entity){
    resetTarget("newTranslation");
    $form = $("<form>");
    $form.append('<h2>Add a new Translation</h2>');
    $form.append('<input type="hidden" id="entityId" value="'+id_entity+'">');
    $form.append('<select id="selectLanguages" name="language" placeholder="language"></select>');
    $form.append('<textarea id="textTranslation" name="translation" placeholder="type in your translation" class="block full"></textarea>');
    $form.append('<input type="button" class="block right" value="submit">');
    $form.children("input[type=button]").off("click").on("click",sendNewTranslation);

    $target.append($form);
    displayLoading('loading languages');
    $.get("/v1/languages")
    .done(selectLanguages)
    .fail(function(){
      displayError('Unable to get languages');
    })
    .always(function(){
      hideLoading();
    });
    $cta.append('<p id="goToEntity" data-id="'+id_entity+'">Go back to entity</p>');
    $cta.off("click").on("click",function(){
      loadEntity($(this).children("#goToEntity").data("id"));
    });
    $form.children("input[type=button]").off("click").on("click",sendNewTranslation);
  }

  function sendNewTranslation(){
    displayLoading('sending');
    $.post("/v1/translations/new",{time:token.time,user:token.user,token:token.token,language:$("#selectLanguages").val(),text:$("#textTranslation").val(),entity:$("#entityId").val()})
    .done(function(data){
      displaySuccess('New translation added');
      loadEntity($("#entityId").val());
    })
    .fail(function(data){
      displayError('Unable to add new translation');
      loadEntity($("#entityId").val());
    })
    .always(function(data){
      hideLoading();
    });
  }

  function selectLanguages(data){
    for (var i = 0; i < data.langs.length; i++) {
      $("#selectLanguages").append('<option value="'+data.langs[i].id_lang+'">'+data.langs[i].name+'</option>');
    }
  }


  function resetTarget(newClass){
    $target.html("").removeClass("login URI entity newTranslation newImage register").addClass(newClass);
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
  function hideCTA(){
      $cta.html("");
  }
  function cleanMessages(){
    hideSuccess();
    hideError();
    hideCTA();
  }
  function nl2br (str) {
    var breakTag = '<br>';
    return (str + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1' + breakTag + '$2');
  }

});
