$(document).ready(function(){
  //get entities
  $.get("/v1/entities").done(function(data){
    $("#entities > section").html();
    for each(entity in data.entities){
      $entity = $("<article/>");
      $entity.attr("id","entity"+entity.id);
      $("#entities > section").append($entity);
    }
  });
});
