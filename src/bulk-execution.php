<!DOCTYPE html>
<html>
<?php include("assets/includes/head.php"); ?>
<body>
  <?php include("assets/includes/header.php"); ?>
  <!-- Page content -->
  <div class="container-fluid mt--7">
    <!-- Table -->
    <div class="row">
      <div class="col">
        <div class="card shadow">
          <div class="card-header bg-transparent">
           <h2 class="mb-0">Bulk Execution</h2>
          </div>
          <div class="card-body">
            <center><span>Bulk execution means you choose the tools/commands that will be executed by Attack Simulator and just <b>play them all together</b> here.</span><br><br></center>
            <p class="card-text">Current tasks: <span id="bulk-exec-status"></span></p><br/></br>
            <div class="table-responsive pb-3">
              <table id='bulk-exec-table' class="table table-bordered table-striped table-td-text-break">
                <thead>
                  <tr class="bg-default">
                    <th><h5 style="color: white">Command</h5></th>
                    <th><h5 style="color: white">Repeat execution</h5></th>
                    <th><h5 style="color: white">Delay to start</h5></th>
                  </tr>
                </thead>
                <tbody id='bulk-exec-tbody'>
                </tbody>
              </table>
            </div>
            <button class="btn btn-primary" type="button" onclick="execute();"><i class="ni ni-bold-right"></i> Execute tasks</button>
            <button class="btn btn-warning" type="button" onclick="clearCommands();"><i class="ni ni-fat-remove"></i> Clear commands</button>
            <button class="btn btn-danger" type="button" onclick="cancelTasks();"><i class="ni ni-button-power"></i> Cancel tasks</button>
            <p class="card-text" id="bulk-exec-result"></p>
          </div>
        </div>
      </div>
    </div>
  </div>
  <?php include("assets/includes/footer.php") ?>

<script type="text/javascript">
  $(document).ready(function () {
    loadTable();
    setTimeout(listTasks, 2000);
  });
  function loadTable() {
    var benignStreams = localStorage.getItem('benignStreams');
    if (benignStreams) {
      benignStreams = JSON.parse(benignStreams);
    } else {
      benignStreams = {};
    }
    const tableData = Object.entries(benignStreams).map(([key,value]) => {
      if (!value.repeat) {
        value.repeat = "--";
      }
      var delayStr = "--";
      if (value.delay) {
        delayStr = `${value.delayStrategy}(${value.delay})`;
      }
      return (
        `<tr>
           <td>${value.command} ${value.arrayInputs.map(x => x.join(' ')).join(' ')} ${value.arrayParams.join(' ')} ${value.target}</td>
           <td>${value.repeat}</td>
           <td>${delayStr}</td>
         </tr>`
      );
    }).join('');
    const tableBody = document.querySelector("#bulk-exec-tbody");
    tableBody.innerHTML = tableData;
  }
  function execute() {
    var benignStreams = localStorage.getItem('benignStreams');
    if (benignStreams) {
      benignStreams = JSON.parse(benignStreams);
    } else {
      benignStreams = {};
    }
    $.post("runBulk.php", {
      "commands" : benignStreams,
    }).done(function (data) {
      document.getElementById("bulk-exec-result").innerHTML = data;
      setTimeout(listTasks, 2000);
    }).fail(function (xhr, status, error) {
      document.getElementById("bulk-exec-result").innerHTML = error;
    });
  }
  function clearCommands() {
    localStorage.removeItem('benignStreams');
    loadTable();
  }
  function listTasks() {
    $.post("runBulk.php", {
      "action" : "list",
    }).done(function (data) {
      document.getElementById("bulk-exec-status").innerHTML = data;
    }).fail(function (xhr, status, error) {
      document.getElementById("bulk-exec-status").innerHTML = error;
    });
  }
  function cancelTasks() {
    $.post("runBulk.php", {
      "action" : "stop",
    }).done(function (data) {
      document.getElementById("bulk-exec-result").innerHTML = data;
      setTimeout(listTasks, 2000);
    }).fail(function (xhr, status, error) {
      document.getElementById("bulk-exec-result").innerHTML = error;
    });
  }
</script>
</body>
</html>
