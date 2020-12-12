<?php

require_once "Controllers/TemplateController.php";
require_once "Controllers/UserController.php";
require_once "Controllers/employeeController.php";
require_once "Controllers/ProductoController.php";
require_once "Controllers/SimulacionController.php";

require_once "Models/EmployeeModel.php";
require_once "Models/UserModel.php";
require_once "Models/PruebaModel.php";
require_once "Models/ProductoModel.php";
require_once "Models/SimulacionModel.php";


$template = new TemplateController();
$template->template();