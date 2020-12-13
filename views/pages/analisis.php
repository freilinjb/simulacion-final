<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>Simulacion</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="home">Home</a></li>
                    <li class="breadcrumb-item active">Simulacion</li>
                </ol>
            </div>
        </div>
    </div><!-- /.container-fluid -->
</section>

<section class="content">

    <div class="container-fluid">
        <div class="row">
            <div class="col-4">
                <div class="card card-primary card-outline">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-edit"></i>
                            Tabs Custom Content Examples
                        </h3>
                    </div>
                    <div class="card-body">
                        <form id="formProcesar">
                            <div class="form-group">
                                <label>Tanda</label>
                                <select class="form-control select2bs4" name="tanda" id="tanda">
                                    <!-- <option value="" disabled selected>Seleccione una tanda</option> -->
                                    <?php
                                    $sexo =  SimulacionController::getData('tanda', null, null);
                                    foreach ($sexo as $index => $valor) {
                                        echo "<option value=" . $valor["idTanda"] . ">" . $valor["tanda"] . "</option>";
                                    }
                                    ?>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Numero de ordenes entrantes</label>
                                <input type="number" class="form-control" name="numOrdenes" id="numOrdenes" placeholder="Ingrese los numeros de ordenes entrantes" min="0" autocomplete="off" value="100">
                            </div>
                            <div class="form-group">
                                <label>Promedio de duración de las ordenes (horas)</label>
                                <input type="number" class="form-control" name="numPromedioDuracion" id="numPromedioDuracion" placeholder="Ingrese los numeros de ordenes entrantes" min="0" autocomplete="off" value="5">
                            </div>
                            <div class="form-group">
                                <label>Tiempo objetivo de respuesta (horas)</label>
                                <input type="number" class="form-control" name="tiempoObjetivo" id="tiempoObjetivo" placeholder="Ingrese los numeros de ordenes entrantes" min="0" autocomplete="off" value="3">
                            </div>
                            <button type="submit" class="btn btn-primary float-right" id="btnProcesar">Procesar</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-8">
                <div class="card card-primary card-outline">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-edit"></i>
                            RESEUMEN
                        </h3>
                    </div>
                    <div class="card-body">
                        <ul class="nav nav-tabs" id="custom-content-above-tab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="custom-content-above-home-tab" data-toggle="pill" href="#custom-content-above-home" role="tab" aria-controls="custom-content-above-home" aria-selected="true">Fases</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="custom-content-above-profile-tab" data-toggle="pill" href="#custom-content-above-profile" role="tab" aria-controls="custom-content-above-profile" aria-selected="false">Profile</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="custom-content-above-messages-tab" data-toggle="pill" href="#custom-content-above-messages" role="tab" aria-controls="custom-content-above-messages" aria-selected="false">Messages</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="custom-content-above-settings-tab" data-toggle="pill" href="#custom-content-above-settings" role="tab" aria-controls="custom-content-above-settings" aria-selected="false">Settings</a>
                            </li>
                        </ul>
                        <div class="tab-custom-content">
                            <p class="lead mb-0">Calidad del servicio</p>
                        </div>
                        <div class="tab-content" id="custom-content-above-tabContent">
                            <div class="tab-pane fade show active" id="custom-content-above-home" role="tabpanel" aria-labelledby="custom-content-above-home-tab">
                                <div class="container">
                                <div class="row justify-content-center">
                                    <div class="col-6">
                                        <!-- GRAFICO -->
                                        <h4>Fases del sistema de produccion</h4>
                                        <div id="donut-chart" style="height: 300px;"></div>
                                        <hr>
                                        <p>Tiempo del servicio: <span id="faseTiempo"></span></p>
                                        <!-- GRAFICO -->
                                    </div>
                                    <div class="col-6">
                                        <!-- GRAFICO -->
                                        <h4>Productos del sistema</h4>
                                        <div id="donut" style="height: 300px;"></div>
                                        <hr>
                                        <p>Tiempo del servicio: <span id="faseTiempo"></span></p>
                                        <!-- GRAFICO -->
                                </div>
                                </div>
                            </div>

                            </div>
                            <div class="tab-pane fade" id="custom-content-above-profile" role="tabpanel" aria-labelledby="custom-content-above-profile-tab">
                                Mauris tincidunt mi at erat gravida, eget tristique urna bibendum. Mauris pharetra purus ut ligula tempor, et vulputate metus facilisis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Maecenas sollicitudin, nisi a luctus interdum, nisl ligula placerat mi, quis posuere purus ligula eu lectus. Donec nunc tellus, elementum sit amet ultricies at, posuere nec nunc. Nunc euismod pellentesque diam.
                            </div>
                            <div class="tab-pane fade" id="custom-content-above-messages" role="tabpanel" aria-labelledby="custom-content-above-messages-tab">
                                Morbi turpis dolor, vulputate vitae felis non, tincidunt congue mauris. Phasellus volutpat augue id mi placerat mollis. Vivamus faucibus eu massa eget condimentum. Fusce nec hendrerit sem, ac tristique nulla. Integer vestibulum orci odio. Cras nec augue ipsum. Suspendisse ut velit condimentum, mattis urna a, malesuada nunc. Curabitur eleifend facilisis velit finibus tristique. Nam vulputate, eros non luctus efficitur, ipsum odio volutpat massa, sit amet sollicitudin est libero sed ipsum. Nulla lacinia, ex vitae gravida fermentum, lectus ipsum gravida arcu, id fermentum metus arcu vel metus. Curabitur eget sem eu risus tincidunt eleifend ac ornare magna.
                            </div>
                            <div class="tab-pane fade" id="custom-content-above-settings" role="tabpanel" aria-labelledby="custom-content-above-settings-tab">
                                Pellentesque vestibulum commodo nibh nec blandit. Maecenas neque magna, iaculis tempus turpis ac, ornare sodales tellus. Mauris eget blandit dolor. Quisque tincidunt venenatis vulputate. Morbi euismod molestie tristique. Vestibulum consectetur dolor a vestibulum pharetra. Donec interdum placerat urna nec pharetra. Etiam eget dapibus orci, eget aliquet urna. Nunc at consequat diam. Nunc et felis ut nisl commodo dignissim. In hac habitasse platea dictumst. Praesent imperdiet accumsan ex sit amet facilisis.
                            </div>
                        </div>
                    </div>
                    <!-- /.card -->
                </div>
            </div>
        </div>
    </div>
</section>




<!-- SCRIPT PERSONAL -->
<script src="views/assets/js/analisis.js"></script>
<!-- DataTables  & Plugins -->

<link rel="stylesheet" href="views/assets/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" href="views/assets/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
<link rel="stylesheet" href="views/assets/plugins/datatables-buttons/css/buttons.bootstrap4.min.css">

<script src="views/assets/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="views/assets/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="views/assets/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="views/assets/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
<script src="views/assets/plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
<script src="views/assets/plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
<script src="views/assets/plugins/jszip/jszip.min.js"></script>
<script src="views/assets/plugins/pdfmake/pdfmake.min.js"></script>
<script src="views/assets/plugins/pdfmake/vfs_fonts.js"></script>
<script src="views/assets/plugins/datatables-buttons/js/buttons.html5.min.js"></script>
<script src="views/assets/plugins/datatables-buttons/js/buttons.print.min.js"></script>
<script src="views/assets/plugins/datatables-buttons/js/buttons.colVis.min.js"></script>
<!-- AdminLTE App -->
<script src="views/assets/plugins/inputmask/jquery.inputmask.min.js"></script>
<!-- jquery-validation -->
<script src="views/assets/plugins/jquery-validation/jquery.validate.min.js"></script>
<script src="views/assets/plugins/jquery-validation/additional-methods.min.js"></script>
<!-- sweetalert2 -->

<script src="views/assets/plugins/sweetalert2/sweetalert2.min.js"></script>
<!-- sweetalert2-theme-bootstrap-4 -->
<link rel="stylesheet" href="views/assets/plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
<!-- SELECT -->
<link rel="stylesheet" href="views/assets/plugins/select2/css/select2.min.css">
<link rel="stylesheet" href="views/assets/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
<!-- Select2 -->
<script src="views/assets/plugins/select2/js/select2.full.min.js"></script>
<!-- Page specific script -->


<!-- FLOT CHARTS -->
<script src="views/assets/plugins/flot/jquery.flot.js"></script>
<!-- FLOT RESIZE PLUGIN - allows the chart to redraw when the window is resized -->
<script src="views/assets/plugins/flot/plugins/jquery.flot.resize.js"></script>
<!-- FLOT PIE PLUGIN - also used to draw donut charts -->
<script src="views/assets/plugins/flot/plugins/jquery.flot.pie.js"></script>

<script>
    $(function() {
                //     $("#empleados").DataTable({
                //         "responsive": true,
                //         "lengthChange": false,
                //         "autoWidth": false,
                //         "info": true,
                //         "paging": true,
                //         "pageLength": 7,
                //     }).buttons().container().appendTo('#empleados_wrapper  .col-md-6:eq(0)');

                //     $("#faseTiempo").DataTable({
                //         "responsive": true,
                //         "lengthChange": false,
                //         "autoWidth": false,
                //         "info": true,
                //         "paging": true,
                //         "pageLength": 7,
                //     }).buttons().container().appendTo('#empleados_wrapper  .col-md-6:eq(7)');

                //Initialize Select2 Elements
                $('.select2bs4').select2({
                    theme: 'bootstrap4'
                });
            });

</script>