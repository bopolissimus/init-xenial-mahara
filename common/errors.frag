Patch this into the top of the exception (...) function in htdocs/lib/errors.php


 if(file_exists("/tmp/exception.log")) {
     unlink ("/tmp/exception.log");
   }
   $out=fopen("/tmp/exception.log","a+");

   $trace=debug_backtrace();
   $trace = print_r($trace, true);
   fwrite($out,$trace);
   fclose($out);

   print("See /tmp/exception.log\n");


