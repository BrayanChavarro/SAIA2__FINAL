$(document).ready(function(){
    tablaPersonas = $("#tablaPersonas").DataTable({
       "columnDefs":[{
        "targets": -1,
        "data":null,
        "defaultContent": "<div class='text-center'><div class='btn-group'><button class='btn btn-primary btnEditar'>Editar</button><button class='btn btn-danger btnBorrar'>Borrar</button></div></div>"  
       }],
        
        //Para cambiar el lenguaje a español
    "language": {
            "lengthMenu": "Mostrar _MENU_ registros",
            "zeroRecords": "No se encontraron resultados",
            "info": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
            "infoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
            "infoFiltered": "(filtrado de un total de _MAX_ registros)",
            "sSearch": "Buscar:",
            "oPaginate": {
                "sFirst": "Primero",
                "sLast":"Último",
                "sNext":"Siguiente",
                "sPrevious": "Anterior"
             },
             "sProcessing":"Procesando...",
        }
    });
    
$("#btnNuevo").click(function(){
    $("#formPersonas").trigger("reset");
    $(".modal-header").css("background-color", "#03A9F4");
    $(".modal-header").css("color", "white");
    $(".modal-title").text("Nueva Persona");            
    $("#modalCRUD").modal("show");        
    id=null;
    opcion = 1; //alta
});    
    
var fila; //capturar la fila para editar o borrar el registro
    
//botón EDITAR    
 $(document).on("click", ".btnEditar", function(){
    fila = $(this).closest("tr");
    id = parseInt(fila.find('td:eq(0)').text());
    nombre = fila.find('td:eq(1)').text();
    apellidos = fila.find('td:eq(2)').text();
    documento = parseInt(fila.find('td:eq(3)').text());
    email = fila.find('td:eq(2)').text();
    
    $("#documento").val(documento);
    $("#apellidos").val(apellidos);
    $("#nombre").val(nombre);
    $("#email").val(email);
    $("#contraseña").val(contraseña);
    $("#telefono").val(telefono);
    opcion = 2; //editar
    
    $(".modal-header").css("background-color", "#007bff");
    $(".modal-header").css("color", "white");
    $(".modal-title").text("Editar Persona");            
    $("#modalCRUD").modal("show");  
    
});

//botón BORRAR
$(document).on("click", ".btnBorrar", function(){    
    fila = $(this);
    id = parseInt($(this).closest("tr").find('td:eq(0)').text());
    opcion = 3 //borrar
    var respuesta = confirm("¿Está seguro de eliminar el registro: "+id+"?");
    if(respuesta){
        $.ajax({
            url: "../../bd/crud.php",
            type: "POST",
            dataType: "json",
            data: {opcion:opcion, id:id},
            success: function(){
                tablaPersonas.row(fila.parents('tr')).remove().draw();
            }
        });
    }   
}); 
  
$("#formPersonas").submit(function(e){
    e.preventDefault();    
    documento = $.trim($("#documento").val());    
    apellidos = $.trim($("#apellidos").val());
    nombre = $.trim($("#nombre").val());
    email = $.trim($("#email").val());    
    contraseña = $.trim($("#contraseña").val());    
    telefono = $.trim($("#telefono").val());
    $.ajax({
        url: "../../bd/crud.php",
        type: "POST",
        dataType: "json",
        data: {documento:documento, apellidos:apellidos, nombre:nombre, id:id, email:email, contraseña:contraseña, telefono:telefono, opcion:opcion},
        success: function(data){  
            var datos = JSON.parse(data);
            id = data[0].id;            
            documento = data[0].documento;
            apellidos = data[0].apellidos;
            nombre = data[0].nombre;
            email = data[0].email;
            contraseña = data[0].contraseña;
            telefono = data[0].telefono;
            if(opcion == 1){tablaPersonas.row.add([id,documento,apellidos,nombre,email,contraseña,telefono]).draw();}
            else{tablaPersonas.row(fila).data([id,documento,apellidos,nombre,email,contraseña,telefono]).draw();}            
        }        
    });
    $("#modalCRUD").modal("hide");    
    
});    
    
});