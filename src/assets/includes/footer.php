<!-- Footer -->
<footer class="footer">
<div class="row align-items-center justify-content-xl-between">
  <div class="col-xl-5">
    <div class="copyright text-center text-xl-left text-muted pl-5">
      &copy; 2024 <a href="https://github.com/hackinsdn/secflood" class="font-weight-bold ml-1" target="_blank">SecFlood by HackInSDN</a>
    </div>
  </div>
</div>
</footer>
</div> <!-- END div Main content from header.php -->
<script src="assets/js/jquery-3.7.1.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/bootstrap.bundle.min.js"></script>
<script src="assets/js/argon.js?v=1.0.0"></script>
<script src="assets/js/canvasjs.min.js"></script>
<!-- Analytics measurements -->
<?php
$gtag = getenv("GTAG");
if ($gtag) {
   echo "<script async src='https://www.googletagmanager.com/gtag/js?id=$gtag'></script>\n";
   echo "<script>\nwindow.dataLayer=window.dataLayer||[];function gtag(){dataLayer.push(arguments);};gtag('js',new Date());gtag('config', '$gtag');\n</script>\n";
}
?>
