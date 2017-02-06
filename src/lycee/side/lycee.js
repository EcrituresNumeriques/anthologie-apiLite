$(document).ready(function(){
  //default mode
  var token = {};
  $target = $("#container");
  $error = $("#error");
  $waiting = $("#waiting");
  $success = $("#success");
  $cta = $("#cta");
  $ctaSide = $("#ctaSide");
  $aside = $("#sideContainer");
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
        cleanDisplay();
        addNewTranslation(thisData.entities[0].id_entity);
      });
      $("#newImage").on("click",function(){
        cleanDisplay();
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
    cleanDisplay();
    resetSide("Align");
    $form = $('<nav>');
    $form.append('<h2>Align Translations</h2>');
    appendAlign($form,data.align.json);

    //$form.append('<p style="margin:2em 0">'+nl2br(data.translation[0].text_translated)+'</p>');
    //$form.append('<p style="margin:2em 0">'+nl2br(data.translation[1].text_translated)+'</p>');
    $form.append('<input type="button" class="block right" value="submit">');
    $aside.append($form);
    $form.children("input[type=button]").off("click").on("click",sendAlign);
    $ctaSide.append('<p id="goToEntity">Cancel</p>');
    $ctaSide.off("click").on("click",hideAside);
  }

  function appendAlign($form,data){
    //for each text, create a paragraphe
    for (var i = 0; i < data.length; i++) {
      $text = $('<p class="alignement" data-texte="'+i+'">');

      //for each line, start adding the words
      for (var j = 0; j < data[i].length; j++) {
        //for every word, append to $text
        for (var k = 0; k < array.length; k++) {
          if(typeof(data[t].text[s][v][w].t) !== "undefined" && data[t].text[s][v][w].t != "")  {
            $word = $('<span id="'+i+'-'+k+'">'+data[i][j][k].t+'</span>');
          }
          else{
            $word = $(data[i][j][k].p);
          }
          $text.append($word);
        }

        //then add a <br>
        $text.append('<br>');
      }
      $form.append($text);
    }

/*
    var t=0;
    while(t<data.length){
                    var wordid = 0;
                    var highlight = "";
                    $text = $("<div>");
                    var s = 0;
                    while(s<data[t].length){
                        $("#text"+t).append("<p class=\"strophe"+s+"\"></p>");
                        var v = 0;
                        while(v<data[t].text[s].length){
                            var w = 0;
                            while(w<data[t].text[s][v].length){
                                wordid++;
                                if(typeof(data[t].text[s][v][w].t) !== "undefined" && data[t].text[s][v][w].t != "")  {
                                    //console.log("word"+t);
                                    highlight = "";
                                    for(o=0;o<data[t].text[s][v][w].h.length;o++){
                                        for(m=0;m<data[t].text[s][v][w].h[o].length;m++){
                                            highlight = highlight+";"+o+"-"+data[t].text[s][v][w].h[o][m];
                                        }
                                    }

                                    $("div#text"+t+" p.strophe"+s).append("<span id=\""+t+"-"+wordid+"\" class=\"highlight\" data-vers=\""+v+"\" data-mot=\""+w+"\" data-texte=\""+t+"\" data-highlight=\""+highlight+"\" >"+data[t].text[s][v][w].t+"</span> ");
                                }
                                else if(data[t].text[s][v].t != ""){
                                    //console.log("ponctuation"+t);
                                    if(data[t].text[s][v][w].p == "'" || data[t].text[s][v][w].p == "-"){
                                        $("div#text"+t+" p.strophe"+s).html($("div#text"+t+" p.strophe"+s).html().substring(0,$("div#text"+t+" p.strophe"+s).html().length - 1));
                                        $("div#text"+t+" p.strophe"+s).append(data[t].text[s][v][w].p);
                                    }
                                    else if(data[t].text[s][v][w].p == ":" || data[t].text[s][v][w].p == ";" || data[t].text[s][v][w].p == "," || data[t].text[s][v][w].p == "!" || data[t].text[s][v][w].p == "?" || data[t].text[s][v][w].p == "."){
                                        $("div#text"+t+" p.strophe"+s).html($("div#text"+t+" p.strophe"+s).html().substring(0,$("div#text"+t+" p.strophe"+s).html().length - 1));
                                        $("div#text"+t+" p.strophe"+s).append(data[t].text[s][v][w].p+" ");
                                    }
                                    else{
                                        $("div#text"+t+" p.strophe"+s).append(data[t].text[s][v][w].p+" ");
                                    }


                                }
                                w++;
                            }
                            $("div#text"+t+" p.strophe"+s).append("<br>");
                            //console.log("line"+t);
                            v++;
                        }
                        s++;
                    }
                    t++;
                }

                var stropheHeight = 0;
                var nStrophe = 0;
                while(nStrophe<s){
                    var stropheHeight = 0;
                    $(".strophe"+nStrophe).each(function(){
                        if($(this).innerHeight() > stropheHeight){
                            stropheHeight = $(this).innerHeight();
                        }
                        $(".strophe"+nStrophe).css("height",stropheHeight);
                    });
                    nStrophe++;
                }

                console.log(s);


                $(".highlight").on("mouseenter",function(){
                    var toHighlight = $(this).data("highlight");
                    var hl = toHighlight.split(";");
                    var i = 1;
                    $(".highlighted").removeClass("highlighted");
                    while(i<hl.length){
                        $("#"+hl[i]).addClass("highlighted");
                        i++;
                    }

                });
                $(".highlight").on("mouseleave",function(){
                    $(".highlighted").removeClass("highlighted");
                });
                $(".highlight").on("click",function(){
                    //console.log(firstClick+" / "+firstText+" /" +otherText);
                    $(this).addClass("washighlighted");
                    if(firstClick){
                        firstClick = false;
                        firstText = $(this).data("texte");
                        otherText = false;
                        $(this).toggleClass("hardhighlighted");
                    }
                    else if(otherText == false && $(this).data("texte") == firstText){
                        $(this).toggleClass("hardhighlighted");
                    }
                    else if($(this).data("texte") != firstText){
                        otherText = true;
                        $(this).toggleClass("hardhighlighted");
                    }
                    else if(otherText == true && $(this).data("texte") == firstText){
                        firstText = $(this).data("texte");
                        otherText = false;
                        saveAlign();
                        $(".hardhighlighted").removeClass("hardhighlighted");
                        $(this).toggleClass("hardhighlighted");
                    }
                });
*/
  }

  function sendAlign(){
    console.log('sending');
  }

  function addNewImage(id_entity){
        resetSide("newTranslation");
        $form = $('<form id="newImage">');
        $form.append('<h2>Add a new Image</h2>');
        $form.append('<input type="hidden" name="entity" id="entityId" value="'+id_entity+'">');
        $form.append('<input type="text" name="url" id="URLImage" placeholder="URL of the image (ex : http://www.cliolamuse.com/IMG/jpg/grec_vase_red.jpg)">');
        $form.append('<input type="text" name="title" id="titleImage" placeholder="Title">');
        $form.append('<input type="text" name="credit" id="creditImage" placeholder="credits">');
        $form.append('<input type="button" class="block right" value="submit">');
        $form.children("input[type=button]").off("click").on("click",sendNewImage);
        $aside.append($form);
        $ctaSide.append('<p id="goToEntity">Cancel</p>');
        $ctaSide.off("click").on("click",hideAside);
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
      hideAside();
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
    resetSide("newTranslation");
    $form = $("<form>");
    $form.append('<h2>Add a new Translation</h2>');
    $form.append('<input type="hidden" id="entityId" value="'+id_entity+'">');
    $form.append('<select id="selectLanguages" name="language" placeholder="language"></select>');
    $form.append('<textarea id="textTranslation" name="translation" placeholder="type in your translation" class="block full"></textarea>');
    $form.append('<input type="button" class="block right" value="submit">');
    $form.children("input[type=button]").off("click").on("click",sendNewTranslation);

    $aside.append($form);
    displayLoading('loading languages');
    $.get("/v1/languages")
    .done(selectLanguages)
    .fail(function(){
      displayError('Unable to get languages');
    })
    .always(function(){
      hideLoading();
    });
    $ctaSide.append('<p id="goToEntity">Cancel</p>');
    $ctaSide.off("click").on("click",hideAside);
    $form.children("input[type=button]").off("click").on("click",sendNewTranslation);
  }

  function sendNewTranslation(){
    displayLoading('sending');
    $.post("/v1/translations/new",{time:token.time,user:token.user,token:token.token,language:$("#selectLanguages").val(),text:$("#textTranslation").val(),entity:$("#entityId").val()})
    .done(function(data){
      displaySuccess('New translation added');
      loadEntity($("#entityId").val());
      hideAside();
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
  function resetSide(newClass){
    $aside.html("").parent("aside").removeClass("newTranslation newImage Align City Keyword").addClass(newClass);
    $ctaSide.html("");
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
  function hideAside(){
      $aside.html("");
      $ctaSide.html("");
  }
  function cleanMessages(){
    hideSuccess();
    hideError();
    hideCTA();
    hideAside();
  }
  function cleanDisplay(){
    hideSuccess();
    hideError();
  }
  function nl2br (str) {
    var breakTag = '<br>';
    return (str + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1' + breakTag + '$2');
  }

});
