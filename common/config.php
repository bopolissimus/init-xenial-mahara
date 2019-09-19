<?php
$cfg = new stdClass();

$branch = 'master';

// database connection details
// valid values for dbtype are 'postgres8' and 'mysql5'
$cfg->dbtype   = 'postgres';
$cfg->dbhost   = 'localhost';
$cfg->dbuser   = 'maharauser';
$cfg->dbname   = "mahara-$branch";
$cfg->dbpass   = 'maharapassword'; 

$cfg->dataroot = "/var/lib/maharadata/$branch";

$cfg->sendemail = true;
$cfg->sendallemailto = 'EMAIL_ADDRESS';

$cfg->productionmode = false;
$cfg->perftofoot = true;

$cfg->behat_dbprefix = 'behat_'; // must not empty
$cfg->behat_dataroot = "/var/lib/maharadata/master_behat"; // Behat's copy of maharadata
$cfg->behat_wwwroot = 'http://localhost:8000'; // Must be this
$cfg->behat_selenium2 = "http://127.0.0.1:4444/wd/hub"; // Must be this
