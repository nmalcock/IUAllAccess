<?php
//define the receiver of the email
$to = 'michael.jacobucci25@gmail.com';
//define the subject of the email
$subject = 'Stat Update'; 
//define the message to be sent. Each line should be separated with \n
$message = "Hello michael.jacobucci25@gmail.com!\n\nCheck IU All Access for new Stat Updates!."; 
//define the headers we want passed. Note that they are separated with \r\n
$headers = "From: nmalcock97@gmail.com\r\nReply-To: nmalcock97@gmail.com";
//send the email
$mail_sent = @mail( $to, $subject, $message, $headers );
//if the message is sent successfully print "Mail sent". Otherwise print "Mail failed" 
echo $mail_sent ? "Mail sent" : "Mail failed";
?>