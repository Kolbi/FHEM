##############################################
# $Id: myUtilsTemplate.pm 7570 2015-01-14 18:31:44Z rudolfkoenig $
#
# Save this file as 99_myUtils.pm, and create your own functions in the new
# file. They are then available in every Perl expression.

package main;

use strict;
use warnings;
use POSIX;

sub
DebianMailUtils_Initialize($$)
{
  my ($hash) = @_;
}

sub 
DebianMail($$$$)
{ 
 my ($rcpt, $subject, $text, $attach) = @_;
 my $ret = "";
 my $sender = "absender\@account.de"; 
 my $konto = "kontoname\@account.de";
 my $passwrd = "passwrd";
 my $provider = "smtp.provider.de:25";
 Log 1, "sendEmail RCP: $rcpt";
 Log 1, "sendEmail Subject: $subject";
 Log 1, "sendEmail Text: $text";
 Log 1, "sendEmail Anhang: $attach";;
 
 $ret .= qx(sendEmail -f '$sender' -t '$rcpt' -u '$subject' -m '$text' -a '$attach' -s '$provider' -xu '$konto' -xp '$passwrd' -o tls=auto -o message-charset=utf-8);
 $ret =~ s,[\r\n]*,,g;    # remove CR from return-string 
 Log 1, "sendEmail returned: $ret"; 
}

1;

=pod
=begin html
 
<a name="DebianMail"></a>
<h3>DebianMail</h3>
<ul>
  <b>Name</b>
  <br>
  Text<br>
  DebianMail  Mail auf dem RPi versenden http://www.fhemwiki.de/wiki/E-Mail_senden
  Examples:
  <ul>
   <code>define Sonstiges at *01:00:00 {\
DebianMail('email@email.domain','Subject','Text','Anhang');;\
}</code>
  </ul>
</ul>
 
=end html
=begin html_DE
 
<a name="DebianMail"></a>
<h3>DebianMail</h3>
<ul>
  <b>Name</b>
  <br>
  Text<br>
  DebianMail  Mail auf dem RPi versenden http://www.fhemwiki.de/wiki/E-Mail_senden
  Examples:
  <ul>
   <code>define Sonstiges at *01:00:00 {\
DebianMail('email@email.domain','Subject','Text','Anhang');;\
}</code>
  </ul>
</ul>

=end html_DE
=cut
