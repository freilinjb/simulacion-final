$(function () {
  let fasesServicio = [];
  let productosServicio = [];
  let fasesGrafico = [];
  let productosGrafico = [];

  /**
   * SIMULACION
   */

   function simulacion() {

    // let iteraciones = $("#")
    // for(let i = 0; i < )
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

      $.post(
        "ajax/SimulacionAjax.php",
        { exec: "getTandaTiempoServicio", idTanda: $("#tanda").val() },
        function (data) {
          // console.log(data);
          fasesServicio = [];
          fasesGrafico = [];
          data.forEach((key, index) => {
            // console.log(key['fase']);

            let grafico = {
              label: key["fase"],
              data: parseFloat(key["probabilidad"])
            };

            fasesGrafico.push(grafico);

            let temp = {
              fase: key["fase"],
              idFase: key["idFase"],
              idTanda: key["idTanda"],
              llegada: key["llegada"],
              probabilidad: key["probabilidad"],
              intervalo: key["probabilidad"],
              tanda: key["tanda"],
            };
            // console.log(index);
            // console.log('temp: ',temp);
            fasesServicio.push(temp);
          });
          
        },
        "json"
      );
      if(fasesGrafico.length > 0) {
        crearGrafico(fasesGrafico);
      }
      console.log("fasesServicio: ", fasesServicio);

      $.post(
        "ajax/SimulacionAjax.php",
        { exec: "getTiempoServicio", idTanda: $("#tanda").val() },
        function (data) {
          // console.log(data);
          productosServicio = [];
          data.forEach((key, index) => {
            // console.log(key['fase']);

            let temp = {
              idProducto: key["idProducto"],
              idTanda: key["idTanda"],
              llegadas: key["llegadas"],
              probabilidad: key["probabilidad"],
              producto: key["producto"],
              tanda: key["tanda"],
            };
            // console.log(index);
            // console.log('temp: ',temp);
            productosServicio.push(temp);
          });

          console.log(productosServicio);
        },
        "json"
      );
    },
  });

  function crearGrafico(data) {
    var donutData = [
      {
        label: 'Series2',
        data : 30,
        color: '#3c8dbc'
      },
      {
        label: 'Series3',
        data : 20,
        color: '#0073b7'
      },
      
      {
        label: 'Series4',
        data : 50,
        color: '#00c0ef'
      }
    ]
    $.plot('#donut-chart', data, {
      series: {
        pie: {
          show       : true,
          radius     : 1,
          innerRadius: 0.5,
          label      : {
            show     : true,
            radius   : 2 / 3,
            formatter: function(label, series){
              return '<div style="font-size:8pt;text-align:center;padding:2px;color:white;">'+label+'<br/>'+Math.round(series.percent)+'%</div>';
          },
          background: {
              opacity: 0.5,
              color: '#000'
          },
            threshold: 0.1
          }
  
        }
      },
      legend: {
        show: false
      }
    });

    $.plot('#donut', data, {
      series: {
        pie: {
          show       : true,
          radius     : 1,
          innerRadius: 0.5,
          label      : {
            show     : true,
            radius   : 2 / 3,
            formatter: function(label, series){
              return '<div style="font-size:8pt;text-align:center;padding:2px;color:white;">'+label+'<br/>'+Math.round(series.percent)+'%</div>';
          },
          background: {
              opacity: 0.5,
              color: '#000'
          },
            threshold: 0.1
          }
  
        }
      },
      legend: {
        show: false
      }
    });
  }

  function labelFormatter(label, series) {
    return '<div style="font-size:13px; text-align:center; padding:2px; color: #fff; font-weight: 600;">'
      + label
      + '<br>'
      + Math.round(series.percent) + '%</div>'
  }

});

