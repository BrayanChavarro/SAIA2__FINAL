<?php
include_once '../bd/conexion.php';
$objeto = new Conexion();
$conexion = $objeto->Conectar();

// Recepción de los datos enviados mediante POST desde el JS   

$documento = (isset($_POST['documento'])) ? $_POST['documento'] : '';
$apellidos = (isset($_POST['apellidos'])) ? $_POST['apellidos'] : '';
$nombres = (isset($_POST['nombres'])) ? $_POST['nombres'] : '';
$email = (isset($_POST['email'])) ? $_POST['email'] : '';
$contraseña = (isset($_POST['contraseña'])) ? $_POST['contraseña'] : '';
$telefono = (isset($_POST['telefono'])) ? $_POST['telefono'] : '';
$opcion = (isset($_POST['opcion'])) ? $_POST['opcion'] : '';

switch($opcion){
    case 1: //alta
        $consulta = "INSERT INTO Usuarios (documento, nombres, apellidos, email, contraseña, telefono) VALUES('$documento', '$nombres', '$apellidos', '$email', '$contraseña', '$telefono') ";			
        $resultado = $conexion->prepare($consulta);
        $resultado->execute(); 

        $consulta = "SELECT documento, nombres, apellidos, email, contraseña, telefono FROM Usuarios ORDER BY Apellidos ASC";
        $resultado = $conexion->prepare($consulta);
        $resultado->execute();
        $data=$resultado->fetchAll(PDO::FETCH_ASSOC);
        break;
    case 2: //modificación
        $consulta = "UPDATE Usuarios SET documento='$documento', apellidos='$apellidos', nombres='$nombres', email='$email', contraseña='$contraseña', telefono='$telefono' WHERE documento='$documento' ";		
        $resultado = $conexion->prepare($consulta);
        $resultado->execute();        
        
        $consulta = "SELECT documento, nombres, apellidos, email, contraseña, telefono FROM Usuarios WHERE documento='$documento' ";       
        $resultado = $conexion->prepare($consulta);
        $resultado->execute();
        $data=$resultado->fetchAll(PDO::FETCH_ASSOC);
        break;        
    case 3://baja
        $consulta = "DELETE FROM Usuarios WHERE documento='$documento' ";		
        $resultado = $conexion->prepare($consulta);
        $resultado->execute();                           
        break;        
        
    }

print json_encode($data, JSON_UNESCAPED_UNICODE); //enviar el array final en formato json a JS
$conexion = NULL;
