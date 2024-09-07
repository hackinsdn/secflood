<?php
$dataPointsIni = array();
$updateInterval = 2000; //in millisecond
$initialNumberOfDataPoints = 15*60*1000/$updateInterval;  # 1 hour
$x = time() * 1000 - $updateInterval * $initialNumberOfDataPoints;
// generates first set of dataPoints 
for($i = 0; $i < $initialNumberOfDataPoints; $i++){
  array_push($dataPointsIni, array("x" => $x, "y" => 0));
  $x += $updateInterval;
}
?>
<script>
function formatBps(a,b=2){if(!+a)return"0 bps";const c=0>b?0:b,d=Math.floor(Math.log(a)/Math.log(1024));return`${parseFloat((a/Math.pow(1024,d)).toFixed(c))} ${["bps","Kbps","Mbps","Gbps","Tbps","Pbps","Ebps","Zbps","Ybps"][d]}`}

window.onload = function() {
 
var updateInterval = <?php echo $updateInterval ?>;
var dataPoints1 = <?php echo json_encode($dataPointsIni, JSON_NUMERIC_CHECK); ?>;
var dataPoints2 = <?php echo json_encode($dataPointsIni, JSON_NUMERIC_CHECK); ?>;
var dataPoints3 = <?php echo json_encode($dataPointsIni, JSON_NUMERIC_CHECK); ?>;
var dataPoints4 = <?php echo json_encode($dataPointsIni, JSON_NUMERIC_CHECK); ?>;
 
var chart = new CanvasJS.Chart("chartContainerBenign", {
  zoomEnabled: true,
  title: {
    text: "Benign Network Traffic"
  },
  axisX: {
    title: "chart updates every " + updateInterval / 1000 + " secs"
  },
  axisY: {
  //suffix: " Mbps"
    labelFormatter: function(e){
      return formatBps(e.value);
    }
  }, 
  toolTip: {
    shared: true,
    contentFormatter: function (e) {
      var content = " ";
      for (var i = 0; i < e.entries.length; i++) {
        content += e.entries[i].dataSeries.name + ": " + "<strong>" + formatBps(e.entries[i].dataPoint.y) + "</strong>";
        content += "<br/>";
      }
      return content;
    }
  },
  legend: {
    cursor:"pointer",
    verticalAlign: "top",
    fontSize: 22,
    fontColor: "dimGrey",
    itemclick : toggleDataSeries
  },
  data: [{ 
      type: "line",
      name: "RX",
      xValueType: "dateTime",
      yValueFormatString: "#,###",
      xValueFormatString: "hh:mm:ss TT",
      showInLegend: true,
      legendText: "RX",
      dataPoints: dataPoints1
    },
    {        
      type: "line",
      name: "TX" ,
      xValueType: "dateTime",
      yValueFormatString: "#,###",
      showInLegend: true,
      legendText: "TX",
      dataPoints: dataPoints2
  }]
});

var chart2 = new CanvasJS.Chart("chartContainerMalicious", {
  zoomEnabled: true,
  title: {
    text: "Malicious Network Traffic"
  },
  axisX: {
    title: "chart updates every " + updateInterval / 1000 + " secs"
  },
  axisY:{
    //suffix: " Mbps"
    labelFormatter: function(e){
      return formatBps(e.value);
    }
  }, 
  toolTip: {
    shared: true,
    contentFormatter: function (e) {
      var content = " ";
      for (var i = 0; i < e.entries.length; i++) {
        content += e.entries[i].dataSeries.name + ": " + "<strong>" + formatBps(e.entries[i].dataPoint.y) + "</strong>";
        content += "<br/>";
      }
      return content;
    }
  },
  legend: {
    cursor:"pointer",
    verticalAlign: "top",
    fontSize: 22,
    fontColor: "dimGrey",
    itemclick : toggleDataSeries
  },
  data: [{ 
      type: "line",
      name: "RX",
      xValueType: "dateTime",
      yValueFormatString: "#,###",
      xValueFormatString: "hh:mm:ss TT",
      showInLegend: true,
      legendText: "RX",
      dataPoints: dataPoints3
    },
    {        
      type: "line",
      name: "TX" ,
      xValueType: "dateTime",
      yValueFormatString: "#,###",
      showInLegend: true,
      legendText: "TX",
      dataPoints: dataPoints4
  }]
});
 
chart.render();
chart2.render();
 
function toggleDataSeries(e) {
  if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
    e.dataSeries.visible = false;
  }
  else {
    e.dataSeries.visible = true;
  }
  chart.render();
  chart2.render();
}

if(typeof(EventSource) !== "undefined") {
  var stat_source = new EventSource("ifstat.php");
  var rate_rec = 0;
  var rate_snd = 0;
  stat_source.onmessage = function(e)
  {
    var data = JSON.parse(e.data);
    var new_rec = data.rec;
    var new_snd = data.snd;
    var new_rec2 = data.rec2;
    var new_snd2 = data.snd2;
    var new_time = data.time;
  
    if ( typeof(old_time) != "undefined")
    { 
      var bytes_rec = new_rec - old_rec;
      var bytes_snd = new_snd - old_snd;
      var bytes_rec2 = new_rec2 - old_rec2;
      var bytes_snd2 = new_snd2 - old_snd2;
      var seconds = (new_time - old_time) / 1000;
  
      rate_rec  = bytes_rec  * 8 / seconds;
      rate_snd  = bytes_snd  * 8 / seconds;
      rate_rec2 = bytes_rec2 * 8 / seconds;
      rate_snd2 = bytes_snd2 * 8 / seconds;
  
      dataPoints1.shift();
      dataPoints1.push({
        x: new_time,
        y: Math.round(rate_rec*100)/100
      });
      dataPoints2.shift();
      dataPoints2.push({
        x: new_time,
        y: Math.round(rate_snd*100)/100
      });
      dataPoints3.shift();
      dataPoints3.push({
        x: new_time,
        y: Math.round(rate_rec2*100)/100
      });
      dataPoints4.shift();
      dataPoints4.push({
        x: new_time,
        y: Math.round(rate_snd2*100)/100
      });
      chart.render();
      chart2.render();
    }
    old_rec = new_rec;
    old_snd = new_snd;
    old_rec2 = new_rec2;
    old_snd2 = new_snd2;
    old_time = new_time;
  };
} else {
  document.getElementById("chartContainer").innerHTML="Sorry, your browser does not support server-sent events...";
}
}
</script>
<div id="chartContainer" style="height: 370px; width: 100%;">
  <div id="chartContainerBenign" style="width: 48%; float: left;"></div>
  <div id="chartContainerMalicious" style="width: 48%; float: right;"></div>
</div>
