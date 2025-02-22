<?php include("assets/includes/config.php"); ?>

<!-- Sidenav -->
<nav class="navbar navbar-vertical fixed-left navbar-expand-md navbar-light bg-white" id="sidenav-main">
  <div class="container-fluid">
    <!-- Toggler -->
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#sidenav-collapse-main" aria-controls="sidenav-main" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <!-- Brand -->
    <a class="navbar-brand pt-0" href="index.php">
      <img src="assets/img/logo.png" class="navbar-brand-img" style="max-height: 100px;">
    </a>
    <!-- User -->
    <ul class="nav align-items-center d-md-none">
      <li class="nav-item dropdown">
        <a class="nav-link" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <div class="media align-items-center">
            <span class="avatar avatar-sm rounded-circle">
              <img style="object-fit: cover;" height="100%" src="<?php echo $avatar;?>">
            </span>
          </div>
        </a>
        <div class="dropdown-menu dropdown-menu-arrow dropdown-menu-right">
          <div class=" dropdown-header noti-title">
            <h6 class="text-overflow m-0">Welcome!</h6>
          </div>
          <a href="profile.php" class="dropdown-item">
            <i class="ni ni-single-02"></i>
            <span>My profile</span>
          </a>
          <div class="dropdown-divider"></div>
          <a href="logout.php" class="dropdown-item">
            <i class="ni ni-user-run"></i>
            <span>Logout</span>
          </a>
        </div>
      </li>
    </ul>
    <!-- Collapse -->
    <div class="collapse navbar-collapse" id="sidenav-collapse-main">
      <!-- Collapse header -->
      <div class="navbar-collapse-header d-md-none">
        <div class="row">
          <div class="col-6 collapse-brand align-items-center">
            <a href="index.php">
              <img src="assets/img/logo.png">
            </a>
          </div>
          <div class="col-6 collapse-close">
            <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#sidenav-collapse-main" aria-controls="sidenav-main" aria-expanded="false" aria-label="Toggle sidenav">
              <span></span>
              <span></span>
            </button>
          </div>
        </div>
      </div>
      <!-- Navigation -->
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="index.php">
            <i class="ni ni-tv-2 text-blue"></i> Dashboard
          </a>
        </li>

        <li class="nav-item">
          <a class="nav-link" href="terminal.php">
            <i class="ni ni-bold-right text-dark"></i> Terminal
          </a>
        </li>

        <li class="nav-item">
          <a class="nav-link" href="tools-list.php">
            <i class="ni ni-bullet-list-67 text-blue"></i> Tools List
          </a>
        </li>

        <li class="nav-item">
          <a class="nav-link" href="bulk-execution.php">
            <i class="ni ni-sound-wave text-blue"></i> Bulk Execution
          </a>
        </li>

        <li class="nav-item">
          <a class="nav-link" href="reports.php">
            <i class="ni ni-single-copy-04 text-yellow"></i> Reports
          </a>
        </li>
      </ul>

      <!-- Divider -->
      <hr class="my-3">

      <!-- Heading -->
      <h6 class="navbar-heading text-muted">THE PROJECT</h6>
      <!-- Navigation -->
      <ul class="navbar-nav mb-md-3">
        <li class="nav-item">
          <a class="nav-link" href="https://github.com/lucasfrag/Kali-Linux-Tools-Interface" target="_blank">
            <i class="ni ni-spaceship"></i> GitHub
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" target='_blank' href="https://docs.google.com/forms/d/e/1FAIpQLSd3GeoAqW05PDLmlyrCaeQu877HyRyzE8Sk0E5p9w2XWV1k0Q/viewform?usp=sf_link">
            <i class="ni ni-chat-round"></i> Feedback
          </a>
        </li>

      </ul>
    </div>
  </div>
</nav>

<!-- Main content -->
<div class="main-content">
  <!-- Top navbar -->
  <nav class="navbar navbar-top navbar-expand-md navbar-dark" id="navbar-main">
    <div class="container-fluid">
      <!-- Form -->
      <form class="navbar-search navbar-search-dark form-inline mr-3 d-none d-md-flex ml-lg-auto">
      <!--  <div class="form-group mb-0">
          <div class="input-group input-group-alternative">
            <div class="input-group-prepend">
              <span class="input-group-text"><i class="fas fa-search"></i></span>
            </div>
            <input class="form-control" placeholder="Search" type="text">
          </div>
        </div>-->
      </form>
      <!-- User -->
      <ul class="navbar-nav align-items-center d-none d-md-flex">
        <li class="nav-item dropdown">
          <a class="nav-link pr-0" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <div class="media align-items-center">
              <span class="avatar avatar-sm rounded-circle">
                <img style="object-fit: cover;" height="100%" src="<?php echo $avatar;?>">
              </span>
              <div class="media-body ml-2 d-none d-lg-block">
                <span class="mb-0 text-sm  font-weight-bold"><?php echo $name;?> </span>
              </div>
            </div>
          </a>
          <div class="dropdown-menu dropdown-menu-arrow dropdown-menu-right">
            <div class=" dropdown-header noti-title">
              <h6 class="text-overflow m-0">Welcome!</h6>
            </div>
            <a href="profile.php" class="dropdown-item">
              <i class="ni ni-single-02"></i>
              <span>My profile</span>
            </a>
            <div class="dropdown-divider"></div>
            <a href="logout.php" class="dropdown-item">
              <i class="ni ni-user-run"></i>
              <span>Logout</span>
            </a>
          </div>
        </li>
      </ul>
    </div>
  </nav>
  <!-- Header -->
  <!-- USE THIS DIV TO CHANGE THE BACKGROUND -->
  <div class="header pb-8 pt-5 pt-md-8" style="background-image: url(<?php echo $background; ?>); background-size: cover; background-position: bottom;">
    <div class="container-fluid">
    </div>
  </div>
  <!-- to be closed on footer.php -->
