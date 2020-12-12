<div class="login-page" style="min-height: 512.391px;">
    <div class="login-box">
        <div class="login-logo">
            <img src="views/assets/img/logo.png" width="50px">
            <a href="../../index2.html"><b>SIMU</b>- PRO</a>
        </div>
        <div class="card">
            <div class="card-body login-card-body">
                <p class="login-box-msg">Regístrese para iniciar sesión</p>

                <form method="post">
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" name="user" placeholder="User" required>
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-envelope"></span>
                            </div>
                        </div>
                    </div>
                    <div class="input-group mb-3">
                        <input type="password" class="form-control" name="password" placeholder="Password" required>
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-lock"></span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6 float-right">
                            <div class="icheck-primary">
                                <input type="checkbox" id="remember">
                                <label for="remember">
                                    Recuérdame
                                </label>
                            </div>
                        </div>
                        <!-- /.col -->
                        <div class="col-12">
                            <button type="submit" class="btn btn-primary btn-block">Iniciar sesion</button>
                        </div>
                        <!-- /.col -->
                    </div>
                    <?php 
                        $login = new UserController();
                        $login->login();
                    ?>
                </form>
                <p class="mb-1 mt-1">
                    <a href="forgot-password.html">Olvidé mi contraseña</a>
                </p>
            </div>
        </div>
    </div>
</div>