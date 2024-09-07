<?php
$interface = "veth0";
$interface2 = "lo";

header('Content-Type: text/event-stream');
header('Cache-Control: no-cache');

$data['time'] = time()*1000;
$data['rec'] = exec("cat /sys/class/net/{$interface}/statistics/rx_bytes");
$data['snd'] = exec("cat /sys/class/net/{$interface}/statistics/tx_bytes");
$data['rec2'] = exec("cat /sys/class/net/{$interface2}/statistics/rx_bytes");
$data['snd2'] = exec("cat /sys/class/net/{$interface2}/statistics/tx_bytes");

$output = json_encode($data);

echo "retry: 2000\n";
echo "data: {$output}\n\n";

flush();
?>
