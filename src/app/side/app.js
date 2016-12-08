$(document).ready(function(){
  //get entities
  $.get("/v1/entities").done(function(data){
    $("#entities > section").html();
    for(i=0;i<data.entities.length;i++){
      $entity = $("<article/>");
      $entity.attr("id","entity"+data.entities[i].id);
      $entity.append('<p/>');
      $entity.children("p").html(data.entities[i].title);
      $("#entities > section").append($entity);
    }
  });
});
