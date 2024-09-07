<?php
set_include_path('assets/libraries/phpseclib/');
include('Net/SSH2.php');
include('assets/includes/config.php');

$host = $_SESSION["host"];
$user = $_SESSION["user"];
$password = $_SESSION["password"];
$cur_dir = getcwd();

// Set time limit to PHP(seconds)
set_time_limit(99999);

$action = $_POST['action'] ?? "exec";
$commands = $_POST['commands'] ?? [];

if ($action == "exec" && (!isset($commands) || empty($commands))) {
  echo "
    <div class='alert alert-danger alert-dismissible fade fade.in show' role='alert' style='position: fixed; z-index: 2; bottom: 0; right: 0; width: 40%;'>
      <span class='alert-inner--icon'><i class='ni ni-fat-remove'></i></span>
      <span class='alert-inner--text'><strong>Error!</strong> Empty list of commands! Doing nothing..</span>
      <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
        <span aria-hidden='true'>&times;</span>
      </button>
    </div>
  ";
  exit();
}

$ssh = new Net_SSH2($host);

if (!$ssh->login($user, $password)) {
  echo "
    <div class='alert alert-danger alert-dismissible fade fade.in show' role='alert' style='position: fixed; z-index: 2; bottom: 0; right: 0; width: 40%;'>
      <span class='alert-inner--icon'><i class='ni ni-fat-remove'></i></span>
      <span class='alert-inner--text'><strong>Error!</strong> Connection to operating system failed!</span>
      <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
        <span aria-hidden='true'>&times;</span>
      </button>
    </div>
  ";
  exit();
}

if ($action == "list") {
  $cmd = 'bash -c "tmux ls 2>/dev/null | grep ^bulk-exe- | cut -d: -f1 | sed s/bulk-exe-//g"';
  $output = $ssh->exec("echo $password | sudo -S " . $cmd);
  if (empty($output)){
    echo "no-tasks";
  } else {
    $tasks = explode("\n", trim($output));
    $output = " ";
    foreach ($tasks as $task) {
      $output = $output . "<b class='text-white bg-dark'>$task</b>&nbsp;&nbsp;";
    }
    echo $output;
  }
  exit();
}

if ($action == "stop") {
  $cmd = 'bash -c "tmux ls 2>/dev/null | grep ^bulk-exe- | xargs -r -n 1 tmux kill-sess -t"';
  $output = $ssh->exec("echo $password | sudo -S " . $cmd);
  if (empty($output)){
    echo "
       <div class='alert alert-success alert-dismissible fade show' role='alert' style='position: fixed; z-index: 2; bottom: 0; right: 0; width: 40%;'>
            <span class='alert-inner--icon'><i class='ni ni-fat-checked'></i></span>
          <span class='alert-inner--text'><strong>Success!</strong> Jobs finished successfully.</span>
          <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
            <span aria-hidden='true'>&times;</span>
          </button>
        </div>
    ";
  } else {
    echo "
      <div class='alert alert-danger alert-dismissible fade fade.in show' role='alert' style='position: fixed; z-index: 2; bottom: 0; right: 0; width: 40%;'>
        <span class='alert-inner--icon'><i class='ni ni-fat-remove'></i></span>
        <span class='alert-inner--text'><strong>Error!</strong> Failed to stop jobs: $output</span>
        <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
          <span aria-hidden='true'>&times;</span>
        </button>
      </div>
    ";
  }
  exit();
}

foreach($commands as $key => $val) {
  $cmd = "";
  $arrayInputs = $val['arrayInputs'] ?? [];
  $arrayParams = $val['arrayParams'] ?? [];
  $delay = $val['delay'];
  $delayStrategy = $val['delayStrategy'];
  $repeat = $val['repeat'];
  // Get all the inputs firt
  for ($i = 0; sizeof($arrayInputs) > $i; $i++) {
    $cmd = $cmd . " " . $arrayInputs[$i][0] . " " . $arrayInputs[$i][1];
  }
  // checkboxes
  for ($i = 0; sizeof($arrayParams) > $i; $i++) {
    $cmd = $cmd . " " . $arrayParams[$i];
  }
  if (isset($delay) && !empty($delay)) {
    $delay = "--delay $delay";
  }
  if (isset($repeat) && !empty($repeat)) {
    $repeat = "--repeat $repeat";
  }
  if (isset($delayStrategy) && !empty($delayStrategy)) {
    $delayStrategy = "--delay_strategy $delayStrategy";
  }
  $run = $val["command"] . " " . $cmd . " " . $val["target"];
  $runFull = "tmux new-session -d -s bulk-exe-$key python3 $cur_dir/launch-cmd.py $delay $repeat $delayStrategy --cmd '$run'";
  #shell_exec($runFull);
  syslog(LOG_INFO, "running command $runFull");
  $ssh->setTimeout(0);
  $ssh->exec("echo $password | sudo -S " . $runFull, 'packet_handler');
}

echo "
  <div class='alert alert-success alert-dismissible fade show' role='alert' style='position: fixed; z-index: 2; bottom: 0; right: 0; width: 40%;'>
    <span class='alert-inner--icon'><i class='ni ni-fat-checked'></i></span>
    <span class='alert-inner--text'><strong>Success!</strong> Commands sent to be executed in bulk mode.</span>
    <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
      <span aria-hidden='true'>&times;</span>
    </button>
  </div>
";
function packet_handler($str) {
	error_log($str);
	flush();
	ob_flush();
}
?>
