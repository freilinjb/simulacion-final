$(function () {
  let fasesServicio = [];
  let productosServicio = [];
  let EventosServicio = [];

  let fasesGrafico = [];
  let productosGrafico = [];
  let probabilidadSum = 0;

  /**
   * SIMULACION
   */

  $("#btnProcesar").click(function () {
    simulacion();
  });

  function simulacion() {
    let iteraciones = $("#numOrdenes").val();
    for (let i = 0; i < iteraciones; i++) {
      // console.log('i: ', i);
    }
  }

  $("#formProcesar").validate({
    rules: {
      tanda: {
        required: true,
      },
      numOrdenes: {
        required: true,
        max: 1000,
        min: 1,
      },
      numPromedioDuracion: {
        required: true,
        max: 8,
        min: 2,
      },
      tiempoObjetivo: {
        required: true,
        max: 8,
        min: 1,
      },
    },
    messages: {
      terms: "Please accept our terms",
    },
    errorElement: "span",
    errorPlacement: function (error, element) {
      error.addClass("invalid-feedback");
      element.closest(".form-group").append(error);
    },
    highlight: function (element, errorClass, validClass) {
      $(element).addClass("is-invalid");
    },
    unhighlight: function (element, errorClass, validClass) {
      $(element).removeClass("is-invalid");
    },

    submitHandler: function (e) {
      const dato = new FormData();

      /**
       * CONSULTAR LA INFORMACION DE LOS EVENTOS
       */
      $.post(
        "ajax/SimulacionAjax.php",
        { exec: "getEventos"},
        function (data) {
          EventosServicio = [];
          data.forEach((key, index) => {

            if (index == 0) {
              desde = 0;
              hasta = parseFloat(key["probabilidad"]);
            } else {
              desde += parseFloat(data[index - 1]["probabilidad"]);
              hasta += parseFloat(key["probabilidad"]);
            }

            let temp = {
              idEvento: key["idEvento"],
              evento: key["evento"],
              probabilidad: key["probabilidad"],
              idFase: key["idFase"],
              fase: key["fase"],
              tanda: key["tanda"],
              descripcion: key["descripcion"],
              distribucion: key["distribucion"],
              tipoDistribucion: key["tipo"],
              accionCorrectiva: key["accionCorrectiva"],
              t_servicio: key["t_servicio"],
              desde: desde,
              hasta: hasta,
            };
            EventosServicio.push(temp);
          });
        },
        "json"
      );

      console.log('EventosServicio:', EventosServicio);
      if(EventosServicio.length > 0) {
        generarTablaEventos(EventosServicio);

      }
      /**
       * CONSULTAR LA INFORMACION DE LAS TANDAS
       */
      $.post(
        "ajax/SimulacionAjax.php",
        { exec: "getTandaTiempoServicio", idTanda: $("#tanda").val() },
        function (data) {
          // console.log(data);

          fasesServicio = [];
          fasesGrafico = [];
          let desde = 0;
          let hasta = 0;

          data.forEach((key, index) => {
            probabilidadSum += parseFloat(key["llegada"]);

            // console.log(probabilidadSum);
            let grafico = {
              label: key["fase"],
              data: Math.round(parseFloat(key["probabilidad"]), 2),
            };

            if (index == 0) {
              desde = 0;
              hasta = parseFloat(key["probabilidad"]);
            } else {
              desde += parseFloat(data[index - 1]["probabilidad"]);
              hasta += parseFloat(key["probabilidad"]);
            }

            fasesGrafico.push(grafico);

            let temp = {
              fase: key["fase"],
              idFase: key["idFase"],
              idTanda: key["idTanda"],
              llegada: key["llegada"],
              probabilidad: key["probabilidad"],
              tanda: key["tanda"],
              desde: desde,
              hasta: hasta,
            };
            fasesServicio.push(temp);
          });
        },
        "json"
      );

      generarTablaFases(fasesServicio);

      if (fasesGrafico.length > 0) {
        crearGrafico("fase", fasesGrafico);
        $("#faseTiempo").html(
          `<strong>${Math.round(probabilidadSum / 60, 2)} horas</strong>`
        );
      }

      console.log("fasesServicio: ", fasesServicio);
      let desde = 0;
      let hasta = 0;

      $.post(
        "ajax/SimulacionAjax.php",
        { exec: "getTiempoServicio", idTanda: $("#tanda").val() },
        function (data) {
          // console.log(data);
          productosServicio = [];
          productosGrafico = [];
          data.forEach((key, index) => {
            // console.log(key['fase']);
            let grafico = {
              label: key["producto"],
              data: parseFloat(key["probabilidad"]),
            };

            if (index == 0) {
              desde = 0;
              hasta = parseFloat(key["probabilidad"]);
            } else {
              desde += parseFloat(data[index - 1]["probabilidad"]);
              hasta += parseFloat(key["probabilidad"]);
            }

            let temp = {
              idProducto: key["idProducto"],
              idTanda: key["idTanda"],
              llegadas: key["llegadas"],
              probabilidad: key["probabilidad"],
              producto: key["producto"],
              tanda: key["tanda"],
              desde: desde,
              hasta: hasta,
            };
            productosServicio.push(temp);
            productosGrafico.push(grafico);
          });
        },
        "json"
      );

      if (productosGrafico.length > 0) {
        crearGrafico("producto", productosGrafico);
      }
    },
  });

  /**
   * GENERAR TABLAS FASES
   */
  function generarTablaFases(arreglo) {
    let html = `
              <thead style="background-color:#6F747E; color:#FFFF">
                <tr>
                  <th colspan="6"><h3 class="text-center">INFORMACION DE LAS FASES DE PRODUCCION</h3></th>
                </tr>

                <tr>
                  <th>#</th>
                  <th>Fase</th>
                  <th>%</th>
                  <th>servicio(Min)</th>
                  <th>Tanda</th>
                  <th>Intervalo</th>
                <tr> 
              </thead>`;

    let tiempoServicio = 0;
    let probabilidad = 0;
    arreglo.forEach((key, index) => {
      tiempoServicio += parseFloat(key["llegada"]);
      probabilidad += parseFloat(key["probabilidad"]);
      html += `
                  <tr>
                  <td><strong>${index+1}</strong></td>
                  <td><strong>${key["fase"]}</strong></td>
                  <td><strong>${key["probabilidad"]} %</strong></td>
                  <td><strong>${key["llegada"]}</strong></td>
                  <td><strong>${key["tanda"]}</strong></td>
                  <td><strong>${key["desde"]} - ${key["hasta"]}</strong></td>
                </tr>
               `;
    });

    html += `<tr style="background-color:#6F747E; color:#FFFF">
              <th colspan="3">Tiempo total del servicio</th>
              <th colspan="3">${Math.round((tiempoServicio/60),2)} Horas</th>
            </tr>`;

    $("#tablaFases").empty();
    $("#tablaFases").html(html);

    // console.log(html);
  }

  function generarTablaEventos(arreglo) {
    

    let html = `
              <thead style="background-color:#6F747E; color:#FFFF">
                <tr>
                  <th colspan="8"><h3 class="text-center">INFORMACION DE LOS EVENTOS & CORRECCIONES</h3></th>
                </tr>

                <tr>
                  <th>#</th>
                  <th>Evento</th>
                  <th>%</th>
                  <th>Fase</th>
                  <th>Distribucion</th>
                  <th>Intervalo</th>
                  <th>Accion Correctiva</th>
                  <th>t. servicio</th>
                <tr> 
              </thead>`;

    let probabilidad = 0;
    arreglo.forEach((key, index) => {
      probabilidad += parseFloat(key["probabilidad"]);
      html += `
                  <tr>
                  <td><strong>${index+1}</strong></td>
                  <td><strong>${key["evento"]}</strong></td>
                  <td><strong>${key["probabilidad"]} %</strong></td>
                  <td><strong>${key["fase"]}</strong></td>
                  <td><strong>${key["distribucion"]}</strong></td>
                  <td><strong>${Math.round(key["desde"],2)} - ${Math.round(key["hasta"],2)}</strong></td>
                  <td><strong>${key["accionCorrectiva"]}</strong></td>
                  <td><strong>${key["t_servicio"]}%</strong></td>

                </tr>
               `;
    });

    $("#tablaEventos").empty();
    $("#tablaEventos").html(html);
    console.log(html);
  }
  function crearGrafico(clase, data) {
    $.plot(`#donut-chart-${clase}`, data, {
      series: {
        pie: {
          show: true,
          radius: 1,
          innerRadius: 0.5,
          label: {
            show: true,
            radius: 2 / 3,
            formatter: function (label, series) {
              return (
                '<div style="font-size:8pt;text-align:center;padding:2px;color:white;">' +
                label +
                "<br/>" +
                Math.round(series.percent) +
                "%</div>"
              );
            },
            background: {
              opacity: 0.5,
              color: "#000",
            },
            threshold: 0.1,
          },
        },
      },
      legend: {
        show: false,
      },
    });
  }
});
