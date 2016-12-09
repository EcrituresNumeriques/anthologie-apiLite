$(document).ready(function(){
  //feed left column
  $.get("/v1/entities").done(displayEntities);





//functions

//feed left column + actions
function displayEntities(data){
  $("#entities > section").html('');
  for(i=0;i<data.entities.length;i++){
    $entity = $("<article/>");
    $entity.attr("id","entity"+data.entities[i].id_entity).data("id",data.entities[i].id_entity).addClass("entity");
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
  $.get("/v1/entities/"+$(this).data("id")).done(displayEntity);
}

//display Entity in the second column
function displayEntity(data){
  $("#entity > section").html('');
  for(i=0;i<data.entities.length;i++){
    $entity = $("<article/>");
    $entity.attr("id","entity"+data.entities[i].id_entity).data("id",data.entities[i].id_entity).addClass("entity");
    $entity.append('<h1/>');
    $entity.children("h1").html(data.entities[i].title);
    for(j=0;i<data.entities[i].titleTranslation.length;j++){
      $titleTranslation = $("<p/>");
      $titleTranslation.append('<span class="lang">['+data.entities[i].titleTranslation[j].lang+']</span>');
      $titleTranslation.append('<span class="translation">'+data.entities[i].titleTranslation[j].text_translated+'</span>');
      $entity.append($titleTranslation);
    }
    $("#entity > section").append($entity);
  }
}

});
