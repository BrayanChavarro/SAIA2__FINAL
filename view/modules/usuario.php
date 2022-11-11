<?php
include_once '../../bd/conexion.php';
$objeto = new Conexion();
$conexion = $objeto->Conectar();

$consulta = "SELECT documento, nombres, apellidos, email, telefono FROM Usuarios";
$resultado = $conexion->prepare($consulta);
$resultado->execute();
$data=$resultado->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../../assets/css/normalize.css">
    <link rel="stylesheet" href="../../assets/webfonts/fonts.css">
    <title>Usuarios</title>
      
    <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="../../assets/bootstrap/css/bootstrap.min.css">
    <!-- CSS personalizado --> 
        <link rel="stylesheet" href="../../assets/css/normalize.css">
        <link rel="stylesheet" href="../../assets/webfonts/fonts.css">
    <!--datables CSS básico-->
        <link rel="stylesheet" type="text/css" href="../../assets/datatables/datatables.min.js"/>
    <!--datables estilo bootstrap 4 CSS-->  
        <link rel="stylesheet"  type="text/css" href="../../datatables/DataTables-1.10.18/css/dataTables.bootstrap4.min.css">       
    <!-- sweetalert2 css -->
    <link rel="stylesheet" href="../../plugins/sweetalert2/sweetalert2.min.css">
    </head>
    
  <body>
    <div class="container">     
    <div class="container">
        <div class="row">
            <div class="col-lg-12">            
            <button id="btnNuevo" type="button" class="btn btn-outline-primary" data-toggle="modal">Nuevo</button>    
            </div>    
        </div>    
    </div>    
    <br>  
    <div class="container">
        <div class="row">
                <div class="col-lg-12">
                    <div class="table-responsive">        
                        <table id="tablaPersonas" class="table table-striped" style="width:100%">
                        <thead class="text-center">
                            <tr class="bg-primary text-light">
                                <th>Documento</th>
                                <th>Apellidos</th>
                                <th>Nombres</th>                                
                                <th>Email</th>  
                                <th>Contraseña</th>  
                                <th>Telefono</th>  
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php                            
                            foreach($data as $dat) {                                                        
                            ?>
                            <tr>
                                <td><?php echo $dat['documento'] ?></td>
                                <td><?php echo $dat['apellidos'] ?></td>
                                <td><?php echo $dat['nombres'] ?></td>
                                <td><?php echo $dat['email'] ?></td>    
                                <td><?php echo $dat['contraseña'] ?></td>    
                                <td><?php echo $dat['telefono'] ?></td>

                                <td></td>
                            </tr>
                            <?php
                                }
                            ?>                                
                        </tbody>        
                       </table>                    
                    </div>
                </div>
        </div>  
    </div>    
      
<!--Modal para CRUD-->
<div class="modal fade" id="modalCRUD" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title1" id="exampleModalLabel">Nuevo Usuario</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
            </div>
        <form action="../../bd/crud.php" method="post">    
            <div class="modal-body">
                <div class="form-group">
                    <label for="Documento" class="col-form-label">Documento:</label>
                    <input type="text" class="form-control" id="documento">
                    <label for="Apellidos" class="col-form-label">Apellidos:</label>
                    <input type="text" class="form-control" id="apellidos">
                    <label for="Nombres" class="col-form-label">Nombres:</label>
                    <input type="text" class="form-control" id="nombres">
                    <label for="email" class="col-form-label">Email:</label>
                    <input type="text" class="form-control" id="email">
                    <label for="Contraseña" class="col-form-label">Contraseña:</label>
                    <input type="password" class="form-control" id="contraseña">
                    <label for="Telefono" class="col-form-label">Telefono:</label>
                    <input type="number" class="form-control" id="telefono">
                </div>            
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-dismiss="modal">Cancelar</button>
                <button type="submit" id="btnGuardar" class="btn btn-primary">Guardar</button>
            </div>
        </form>    
        </div>
    </div>
</div>  
      
    <!-- jQuery, Popper.js, Bootstrap JS -->
    <script src="../../jquery/jquery-3.3.1.min.js"></script>
    <script src="../../popper/popper.min.js"></script>
    <script src="../../assets/bootstrap/js/bootstrap.min.js"></script>
      
    <!-- datatables JS -->
    <script type="text/javascript" src="../../assets/datatables/datatables.min.js"></script>    
     
    <script type="text/javascript" src="../../assets/js/main.js"></script>  
    <!-- sweetalert2 js -->
    <script src="../../plugins/sweetalert2/sweetalert2.all.min.js"></script>
</div>   
  </body>
</html>