<?php 

class UserController {

    static public function login() {

        if(isset($_POST["user"]) && !empty($_POST["user"])) {

			if(preg_match('/^[a-zA-Z0-9]+$/', $_POST["user"]) &&
			   preg_match('/^[a-zA-Z0-9]+$/', $_POST["password"])){
                
                $table = "usuario";
                $item = "usuario";
                $value = $_POST["user"];

                $resquest = UserModel::showUsers($table, $item, $value);

                // print_r($resquest);

                if($resquest["usuario"] == $_POST["user"] && $resquest["clave"] == $_POST["password"]) {

                    $_SESSION['iniciarSesion'] = true;
                    $_SESSION['idUsuario'] = $resquest["idUsuario"];
                    $_SESSION['nombre'] =  $resquest["nombre"];;
                    $_SESSION['usuario'] = $_POST["user"];
                    $_SESSION['foto_url'] = $resquest["foto_url"];
                    $_SESSION['Departamento'] = $resquest["departamento"];
                    $_SESSION['PuestoTrabajo'] = $resquest["puestoTrabajo"];
                    $_SESSION['ultimoAcceso'] = $resquest["ultimoAcceso"];
                    echo '<script>

								window.location = "home";

						</script>';
                    
                } else {
					echo '<br><div class="alert alert-danger">Error al ingresar, vuelve a intentarlo</div>';
                }
            }
        }
    }

    static public function mostrarUsuarios($item, $value) {
        $table = "usuarios_v";
        $request = UserModel::showUsers($table, $item, $value);

        return $request;
    }

    static public function registrarUsuario() {

        if(isset($_POST["usuario"])) {

            if(
                preg_match('/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ ]+$/', $_POST["usuario"]) &&
                preg_match('/^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ ]+$/', $_POST["clave"]) &&
                preg_match('/^[0-9]+$/', $_POST["idEmpleado"]) &&
                preg_match('/^[0-9]+$/', $_POST["idEstado"])) {
    
                $datos = array("usuario"=>$_POST["usuario"],
                                "clave"=>$_POST["clave"],
                                "idEmpleado"=>$_POST["idEmpleado"],
                                "idEstado"=>$_POST["idEstado"]);
                
                $respuesta = UserModel::registrarUsuario($datos);

                if($respuesta == "ok"){
                    echo'<script>
                        swal({
                            type: "success",
                            title: "La categoría ha sido guardada correctamente",
                            showConfirmButton: true,
                            confirmButtonText: "Cerrar"

                            }).then(function(result){
                                if (result.value) {
                                    window.location = "categorias";
                                }
                            })
                        </script>';
                } 
                else {
                    echo'<script>
                        swal({
                                type: "error",
                                title: "¡La categoría no puede ir vacía o llevar caracteres especiales!",
                                showConfirmButton: true,
                                confirmButtonText: "Cerrar"

                            }).then(function(result){
                                if (result.value) {
                                    window.location = "categorias";
                                } 
                        })
                            </script>';
                    }
            }
        }
    }
}
