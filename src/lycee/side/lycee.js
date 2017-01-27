$(document).ready(function(){
  //default mode
  var token = {};
  $target = $("#container");
  init();



  function init(){
    //prompt for login
    $target.html("").addClass("login");
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
    $target.html("").removeClass("login").addClass("URI");
    $menuURI = $("<nav>");
    $menuURI.append('<p>Perseus URI : </p>');
    $menuURI.append('<input type="text" id="URI" value="" placeholder="http://data.perseus.org/citations/urn:cts:greekLit:tlg7000.tlg001.perseus-grc1:5.6">');
    $menuURI.append('<input type="button" id="goURI" value="Go">');
    $target.append($menuURI);
    $("#goURI").on("click",function(){
      $.get("/v1/entities/URIs/"+encodeURIComponent($("#URI").val()))
      .done(function(data){
        console.log(data)
      });
    });

  }


});
