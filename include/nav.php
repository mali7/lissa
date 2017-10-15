<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
  <div class="navbar-inner">
    <div class="container">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse-01">
      <span class="sr-only">Toggle navigation</span>
      </button>
      <a class="navbar-brand" href="/rocspeak">ROC Speak</a>
      <div class="collapse navbar-collapse" id="navbar-collapse-01">
      <ul class="nav navbar-nav">
      <?php
      foreach ($pages as $pageKey => $pageValue) {
        if ("$pageKey.php" == $currentPage) echo "<li class='active'><a href='$pageKey.php'>$pageValue</a></li>";
        else echo "<li><a href='$pageKey.php'>$pageValue</a></li>";
      }
      ?>
      </ul>  
      </div><!--/.nav-collapse -->
    </div>
  </div>
</div>