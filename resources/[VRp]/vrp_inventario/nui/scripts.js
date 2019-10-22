
var itemName = null;
var itemAmount = null;
var itemIdname = null;

$(document).ready(function () {
  
  $(".inventario").hide();
  $(".chest").hide();
  $(".loot").hide();
  window.addEventListener('message', function (event) {
    var item = event.data;
    if (item.show == true) {
      open();
      openHome();
      $( ".userItems" ).droppable( "disable" );
    }
    if (item.show == false) {
      close();
    }
    if (item.show == "chest") {
      openChest();
      $( ".userItems" ).droppable( "enable" );
    }
    if (item.show == "loot") {
      openLoot();
      $( ".userItems" ).droppable( "enable" );
    }    
    if (item.equipado) {
      // console.log(JSON.stringify(item.inventory, null, 2));
      $("#equips").empty();
      item.equipado.forEach(element => {
        $("#equips").append(`
          <div id="equip">
            <p class="name">${element.nome}</p>
            <div class="itemEquipado" style="background-image: url('assets/icons/${element.icon}'); background-size:cover;">
            </div>
            <p class="equipMunicao">Munição: ${element.municao}</p>
          </div>
        `);
      });
    }
    if (item.inventory) {
      $(".userItems").empty();
      item.inventory.forEach(element => {
        $(".userItems").append(`
          <div class="item" onclick="selectItem(this)" data-name="${element.name}" data-amount="${element.amount}" data-idname="${element.idname}" data-itemweight="${element.item_peso}" data-type="${element.type}" data-icon="${element.icon}" data-source="inventario" style="background-image: url('assets/icons/${element.icon}'); background-size: 80px 80px;">
            <p class="amount">${element.amount}x <span class="peso">${parseInt(element.item_peso*element.amount*100)/100}Kg</span></p>
            
            <p class="name">${element.name}</p>
          </div>
        `);
      });
    }
    if (item.chest) {
      $("#chestItems").empty();
      item.chest.forEach(element => {
        $("#chestItems").append(`
          <div class="item" onclick="selectItem(this)" data-name="${element.name}" data-amount="${element.amount}" data-idname="${element.idname}" data-itemWeight="${element.item_peso}" data-type="${element.type}" data-icon="${element.icon}" data-source="bau" style="background-image: url('assets/icons/${element.icon}'); background-size: 80px 80px;">
            <p class="amount">${element.amount}x <span class="peso">${parseInt(element.item_peso*element.amount*100)/100}Kg</span></p>
            <p class="name">${element.name}</p>
          </div>
        `);
      });
    }    
    if (item.notification == true) {
      Swal.fire(
        item.title,
        item.message,
        item.type
      )
    }


    $('.item').draggable({
      helper: 'clone',

      zIndex: 99999,
      revert: 'invalid',
      start: function (event, ui) {
      name = $(this).data("name");
      icon = $(this).data("icon");
      source = $(this).data("source");
        $(this).css('background-image', 'none');
      },
      stop: function () {
        $(this).css('background-image', 'url(\'assets/icons/' + icon +'\'');
      }
    });
   


    if(item.maxWeight) {
      $(".chestWeight").html(item.chestWeight+"/"+item.chestMaxWeight + " kg");
      $(".invWeight").html(item.weight +"/" + item.maxWeight + " kg");
      invweight = item.weight;
      invMaxWeight = item.maxWeight;
      chestMaxWeight = item.chestMaxWeight;
      chestWeight = item.chestWeight; 
     
      if (item.progressinv >= 100){
        $(".innerpiw").css('width','100%');
        $(".innerpiw").css('background-color','rgba(250,100,100,0.8)');
        $(".innerpiw").addClass('piscando');
      }else if(item.progressinv >= 50) {
        $(".innerpiw").css('width',(item.progressinv)+'%');
        $(".innerpiw").css('background-color','rgba(250,250,0,0.8)');
        $(".innerpiw").removeClass('piscando');
      }else if(item.progressinv < 50) {
        $(".innerpiw").css('width',(item.progressinv)+'%');
        $(".innerpiw").css('background-color','rgba(100,250,100,0.8)');
        $(".innerpiw").removeClass('piscando');
      }
      if (item.progresschest >= 100){
        $("#innerpcw").css('width','100%');
        $("#innerpcw").css('background-color','rgba(250,100,100,0.8)');
        $("#innerpcw").addClass('piscando');
      }else if(item.progresschest >= 50) {
        $("#innerpcw").css('width',(item.progresschest)+'%');
        $("#innerpcw").css('background-color','rgba(255,254,100,0.8)');
        $("#innerpcw").removeClass('piscando');
      }else if(item.progresschest < 50) {
        $("#innerpcw").css('width',(item.progresschest)+'%');
        $("#innerpcw").css('background-color','rgba(100,250,100,0.8)');
        $("#innerpcw").removeClass('piscando');
      }
    }
    
  });
  document.onkeyup = function (data) {
    if (data.which == 27) {
      $.post('http://vrp_inventario/close', JSON.stringify({}));
    }
  };
  $(".btnClose").click(function () {
    $.post('http://vrp_inventario/close', JSON.stringify({}));
  });
});

function open() {
  $(".overlay").fadeIn();
  $(".inventario").fadeIn();
  clearSelectedItem();
}
function close() {
  $(".overlay").fadeOut();
  $(".inventario").fadeOut();
  $(".chest").fadeOut();
  $(".loot").fadeOut();  
  $("#home").css("display", "none");
  clearSelectedItem();
}
function openHome() {
  $(".overlay").css("display", "block");
  $("#home").css("display", "block");
}
function openChest() {
  $(".overlay").css("display", "block");
  $(".overlay").fadeIn();
  $(".chest").fadeIn();
}
function openLoot() {
  $(".overlay").css("display", "block");
  $(".overlay").fadeIn();
  $(".loot").fadeIn();
}
function selectItem(element) {
  clearSelectedItem();
  itemName = element.dataset.name;
  itemAmount = element.dataset.amount;
  itemIdname = element.dataset.idname;
  itemPeso = element.dataset.itemweight;
  origem = element.dataset.source;
  $("#items div").css("background-color", "rgba(0,0,0,0.3)");
  $(element).css("background-color", "#000000");
  $("#actionbtt").html(element.dataset.type);
}
function clearSelectedItem() {
  itemName = null;
  itemAmount = null;
  itemIdname = null;
  itemPeso = null;
  origem = null;
  $(".items div").css("background-color", "rgba(0,0,0,0.3)");
  $("#actionbtt").html("Usar");
}

function garmas() {
  $.post('http://vrp_inventario/garmas', JSON.stringify({}))
}

function useItem() {
  let amount = $("#amount").val();
  if (amount == "0" || amount == "" || amount == null) {
    Swal.fire( 
      'Atenção',
      'Insira uma quantidade válida!',
      'warning'
    )
  } else if (parseInt(amount) > parseInt(itemAmount)) {
    Swal.fire(
      'Atenção',
      'Você não possui a quantidade selecionada em seu inventário.',
      'warning'
    )
  } else {
    if(itemIdname) {
      $.post('http://vrp_inventario/useItem', JSON.stringify({
        idname: itemIdname,
        amount: amount
      }))
      .then(() => {
        clearSelectedItem();
      });
    } else {
      Swal.fire(
        'Atenção',
        'Selecione um item',
        'warning'
      )
    }
  }
}
function mais(type) {
 
  if(type === "bau"){
    if($("#amount").val() > 0){
      $("#amount").val(Number($("#amount").val())+1);
    }
  }else if(type === "chest"){
    if($("#chestAmount").val() > 0){
       $("#chestAmount").val(Number($("#chestAmount").val())+1);
    }
  }
}
function menos(type) {
  if(type === "bau"){
    if($("#amount").val() > 0){
      $("#amount").val($("#amount").val()-1);
    }
  }else if(type === "chest"){
    if($("#chestAmount").val() > 0){
      $("#chestAmount").val($("#chestAmount").val()-1);
    }
  }
}
function dropItem() {
  let amount = $("#amount").val();
  if (amount == "0" || amount == "" || amount == null) {
    Swal.fire(
      'Atenção',
      'Insira uma quantidade válida.',
      'warning'
    )
  } else if (parseInt(amount) > parseInt(itemAmount)) {
    Swal.fire(
      'Atenção',
      'Você não possui a quantidade selecionada em seu inventário.',
      'warning'
    )
  } else {
    if(itemIdname !== null) {
      $.post('http://vrp_inventario/dropItem', JSON.stringify({
        idname: itemIdname,
        amount: amount
      }))
      .then(() => {
        clearSelectedItem();
      });
    } else {
      Swal.fire(
        'Atenção',
        'Selecione um item',
        'warning'
      )
    }
  }
}

function giveItem() {
  let amount = $("#amount").val();
  if (amount == "0" || amount == "" || amount == null) {
    Swal.fire(
      'Atenção',
      'Insira uma quantidade válida.',
      'warning'
    )
  } else if (parseInt(amount) > parseInt(itemAmount)) {
    Swal.fire(
      'Atenção',
      'Você não possui a quantidade selecionada em seu inventário.',
      'warning'
    )
  } else {
    if(itemIdname) {
      $.post('http://vrp_inventario/giveItem', JSON.stringify({
        idname: itemIdname,
        amount: amount,
        chestMax: chestMaxWeight
      }))
      .then(() => {
        clearSelectedItem();
      });
    } else {
      Swal.fire(
        'Atenção',
        'Selecione um item',
        'warning'
      )
    }
  }
}

function takeItem() {
  let amount = $("#chestAmount").val();
  if (origem == "bau"){
    if (amount == "0" || amount == "" || amount == null) {
      Swal.fire( 
        'Atenção',
        'Insira uma quantidade válida!',
        'warning'
      )
    } else if (parseInt(amount) > parseInt(itemAmount)) {
      Swal.fire(
        'Atenção',
        'Você não possui a quantidade selecionada.',
        'warning'
      )
    } else {
      if(itemIdname) {
        if((itemPeso*amount)>(invMaxWeight-invweight)) {
          Swal.fire(
            'Atenção',
            'O item não cabe na sua mochila!',
            'warning'
          )
        }else{
          $.post('http://vrp_inventario/takeItem', JSON.stringify({
            idname: itemIdname,
            amount: amount
          }))
          clearSelectedItem();
        }
      } else {
        Swal.fire(
          'Atenção',
          'Selecione um item',
          'warning'
        )
      }
    }
  }else{
    Swal.fire(
    'Atenção',
    'Selecione um item do baú para pegar',
    'warning'
    )
  }
}

function putItem() {
  let amount = $("#chestAmount").val();
  if (origem == "inventario"){
    if (amount == "0" || amount == "" || amount == null) {
      Swal.fire( 
        'Atenção',
        'Insira uma quantidade válida!',
        'warning'
      )
    } else if (parseInt(amount) > parseInt(itemAmount)) {
      Swal.fire(
        'Atenção',
        'Você não possui a quantidade selecionada.',
        'warning'
      )
    } else {
      if(itemIdname) {
        if((itemPeso*amount)>(chestMaxWeight-chestWeight)){
            Swal.fire(
            'Atenção',
            'Baú Cheio!',
            'warning'
        )
        }else{
          $.post('http://vrp_inventario/putItem', JSON.stringify({
            idname: itemIdname,
            amount: amount
          }) )
          clearSelectedItem();
        }
      } else {
        Swal.fire(
          'Atenção',
          'Selecione um item',
          'warning'
        )
      }
    }
  }else{
    Swal.fire(
    'Atenção',
    'Selecione um item da sua mochila para colocar no baú!',
    'warning'
    )
  }
}

$(document).ready(function () {
    $( ".userItems" ).droppable({
      drop: function( event, ui ) {
        itemIdname = ui.draggable.data("idname");
        origem = ui.draggable.data("source");
        itemPeso = ui.draggable.data("itemweight");
        itemAmount = ui.draggable.data("amount");
        let amount = $("#chestAmount").val();
        if (origem == "bau"){
          if (amount == "0" || amount == "" || amount == null) {
            Swal.fire( 
              'Atenção',
              'Insira uma quantidade válida!',
              'warning'
            )
          } else if (parseInt(amount) > parseInt(itemAmount)) {
            Swal.fire(
              'Atenção',
              'Você não possui a quantidade selecionada.',
              'warning'
            )
          } else {
            if(itemIdname) {
              if((itemPeso*amount)>(invMaxWeight-invweight)) {
                Swal.fire(
                  'Atenção',
                  'O item não cabe na sua mochila!',
                  'warning'
                )
              }else{
                $.post('http://vrp_inventario/takeItem', JSON.stringify({
                  idname: itemIdname,
                  amount: amount
                }))
                clearSelectedItem();
              }
            } else {
              Swal.fire(
                'Atenção',
                'Selecione um item',
                'warning'
              )
            }
          }
        }
      }
    });
    $('#chestItems').droppable({
        drop: function (event, ui) {
          itemIdname = ui.draggable.data("idname");
          origem = ui.draggable.data("source");
          itemPeso = ui.draggable.data("itemweight");
          itemAmount = ui.draggable.data("amount");
          let amount = $("#chestAmount").val();
          if (origem == "inventario"){
            if (amount == "0" || amount == "" || amount == null) {
              Swal.fire( 
                'Atenção',
                'Insira uma quantidade válida!',
                'warning'
              )
            } else if (parseInt(amount) > parseInt(itemAmount)) {
              Swal.fire(
                'Atenção',
                'Você não possui a quantidade selecionada.',
                'warning'
              )
            } else {
              if(itemIdname) {
                if((itemPeso*amount)>(chestMaxWeight-chestWeight)) {  
                    Swal.fire(
                    'Atenção',
                    'Baú Cheio!',
                    'warning'
                  )
                }else{
                  $.post('http://vrp_inventario/putItem', JSON.stringify({
                    idname: itemIdname,
                    amount: amount
                  }) )
                  clearSelectedItem();
                }
              } else {
                Swal.fire(
                  'Atenção',
                  'Selecione um item',
                  'warning'
                )
              }
            }
          }
        }
    });    
});
