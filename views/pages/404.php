<section class="content">
      <div class="error-page">
        <h2 class="headline text-warning"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"> 404</font></font></h2>

        <div class="error-content">
          <h3><i class="fas fa-exclamation-triangle text-warning"></i><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">¡Ups! </font><font style="vertical-align: inherit;">Página no encontrada.</font></font></h3>

          <p><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">
            No pudimos encontrar la página que buscaba. </font><font style="vertical-align: inherit;">Mientras tanto, puede </font></font><a href="../../index.html"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">volver al panel de control</font></font></a><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"> o intentar utilizar el formulario de búsqueda.
          </font></font></p>

          <form class="search-form">
            <div class="input-group">
              <input type="text" name="search" class="form-control" placeholder="Buscar">

              <div class="input-group-append">
                <button type="submit" name="submit" class="btn btn-warning"><i class="fas fa-search"></i>
                </button>
              </div>
            </div>
            <!-- /.input-group -->
          </form>
        </div>
        <!-- /.error-content -->
      </div>
      <!-- /.error-page -->
    </section>
    <?php 
                        $login = new UserController();
                        $login->login();
                    ?>