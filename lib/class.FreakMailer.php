<?
define ('MAILER_DIR',str_replace('\\', '/', dirname(__FILE__)).'/phpmailer');
require_once(MAILER_DIR.'/class.phpmailer.php');

class FreakMailer extends PHPMailer
{
    var $priority = 3;
    var $to_name;
    var $to_email;
    var $From = null;
    var $FromName = null;
    var $Sender = null;
  
    function FreakMailer()
    {
      
      // Берем из файла config.php массив $site       
      if(!$this->From)
      {
        $this->From = SHOP_MAIL;
      }
      if(!$this->FromName)
      {
        $this-> FromName = SHOP_NAME;
      }
      if(!$this->Sender)
      {
        $this->Sender = SHOP_MAIL;
      }
      $this->Priority = $this->priority;
    }
}
?>