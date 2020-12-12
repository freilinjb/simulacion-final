<?php

require_once "../Controllers/SimulacionController.php";
require_once "../Models/SimulacionModel.php";

class SimulacionAjax {
    public $idEvento;
    public $idProducto;

    public function registrarEvento()
    {
        $datos = array(
            "evento" => $_POST["evento"],
            "idFase" => $_POST["fase"],
            "idDistribucion" => $_POST["distribucion"],
            "descripcion" => $_POST["descripcion"],
            "estado" => $_POST["estado"]);

        // print_r($datos);
        // die;
        $respuesta  = SimulacionModel::registrarEvento($datos);
        
        echo json_encode($respuesta);
    }

    public function eliminarEvento() {
        $dato = $this->idEvento;
        $respuesta = SimulacionModel::eliminarEvento($dato);

        echo json_encode($respuesta);
    }

    public function registrarProducto() {
        $datos = array(
            "producto" => $_POST["producto"],
            "probabilidad" => $_POST["probabilidad"],
            "estado" => $_POST["estado"]);

        // print_r($datos);
        // die;
        $respuesta  = SimulacionModel::registrarProducto($datos);
        
        echo json_encode($respuesta);
    }

    public function eliminarProducto() {
        $dato = $this->idEvento;
        $respuesta = SimulacionModel::eliminarProducto($dato);

        echo json_encode($respuesta);
    }
}

/*=============================================
Comprobamos que el valor no venga vacío
=============================================*/	
// print_r($_POST);
if(isset($_POST['exec']) && !empty($_POST['exec'])) {
    $funcion = $_POST['exec'];
    $ejecutar = new SimulacionAjax();
    //En función del parámetro que nos llegue ejecutamos una función u otra
    switch($funcion) {

        case 'registrarEvento': 
            $ejecutar -> registrarEvento();
            break;
        case 'registrarProducto': 
            $ejecutar -> registrarProducto();
            break;
        case 'eliminarEvento':
            $ejecutar->idEvento = $_POST["idEvento"];
            $ejecutar -> eliminarEvento();
            break;
        case 'eliminarProducto':
            $ejecutar->idEvento = $_POST["idProducto"];
            $ejecutar -> eliminarProducto();
            break;
    }
}
