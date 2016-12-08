$(document).ready(function(){
  //feed left column
  $.get("/v1/entities").done(displayEntities);





//functions

//feed left column
  function displayEntities(data){
    $("#entities > section").html('<datalist id="findEntity"></datalist>');
    for(i=0;i<data.entities.length;i++){
      $entity = $("<article/>");
      $datalist = $("<option/>");
      $datalist.attr("value",data.entities[i].title).attr("label",data.entities[i].id);
      $("#findEntity").append($datalist);
      $entity.attr("id","entity"+data.entities[i].id).data("id",data.entities[i].id).addClass("entity");
      $entity.append('<p/>');
      $entity.children("p").html(data.entities[i].title);
      $("#entities > section").append($entity);
    }
    $("#findEntityInput").on("change",function(){
      $("#entities > section > article").addClass("hidden");
      $("#entities > section > article > p:contains("+$(this).val()+")").parent("article").removeClass("hidden");
    });
    $(".entity").on("click",function(){

    });
  }




});
