<?php	
	if(empty($_POST['number']) && strlen($_POST['number']) == 0 || empty($_POST['street']) && strlen($_POST['street']) == 0 || empty($_POST['zipcode']) && strlen($_POST['zipcode']) == 0)
	{
		return false;
	}
	
	$number = $_POST['number'];
	$street = $_POST['street'];
	$borough = $_POST['borough'];
	$zipcode = $_POST['zipcode'];
	
	$to = 'receiver@yoursite.com'; // Email submissions are sent to this email

	// Create email	
	$email_subject = "Message from propertyhunt.";
	$email_body = "You have received a new message. \n\n".
				  "Number: $number \nStreet: $street \nBorough: $borough \nZipcode: $zipcode \n";
	$headers = "MIME-Version: 1.0\r\nContent-type: text/plain; charset=UTF-8\r\n";	
	$headers .= "From: contact@yoursite.com\n";
	$headers .= "Reply-To: DoNotReply@yoursite.com";	
	
	mail($to,$email_subject,$email_body,$headers); // Post message
	return true;			
?>