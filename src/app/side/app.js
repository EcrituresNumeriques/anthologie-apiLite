$(document).ready(function(){
  //feed left column
  $.get("/v1/entities").done(displayEntities);





//functions

//feed left column + actions
  function displayEntities(data){
    $("#entities > section").html('');
    for(i=0;i<data.entities.length;i++){
      $entity = $("<article/>");
      $entity.attr("id","entity"+data.entities[i].id).data("id",data.entities[i].id).addClass("entity");
      $entity.append('<p/>');
      $entity.children("p").html(data.entities[i].title);
      $("#entities > section").append($entity);
    }
    $("#findEntityInput").on("input",function(){
      $("#entities > section > article").addClass("hidden");
      $("#entities > section > article > p:contains("+$(this).val()+")").parent("article").removeClass("hidden");
    });
    $(".entity").on("click",loadEntity);
  }

//load entity in the second row
  function loadEntity(){
    $(this).css("background-color","red");
  }


});
