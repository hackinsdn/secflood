<?php
$interval = $_GET["interval"] ?? "2000";
$intf1 = "XXXINTF1XXX";
$intf2 = "XXXINTF2XXX";

header('Content-Type: text/event-stream');
header('Cache-Control: no-cache');

$data['time'] = time()*1000;
$data['rec1'] = exec("cat /sys/class/net/{$intf1}/statistics/rx_bytes");
$data['snd1'] = exec("cat /sys/class/net/{$intf1}/statistics/tx_bytes");
$data['rec2'] = exec("cat /sys/class/net/{$intf2}/statistics/rx_bytes");
$data['snd2'] = exec("cat /sys/class/net/{$intf2}/statistics/tx_bytes");

$output = json_encode($data);

echo "retry: $interval\n";
echo "data: {$output}\n\n";

flush();
?>
