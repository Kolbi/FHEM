##############################################
# $Id: myUtilsTemplate.pm 7570 2015-01-14 18:31:44Z rudolfkoenig $
#
# Save this file as 99_myUtils.pm, and create your own functions in the new
# file. They are then available in every Perl expression.

package main;

use strict;
use warnings;
use POSIX;

######################################################
sub
SetTempList_Heizung($$$$$$$$)
{
	my($dev, $mo, $di, $mi, $do, $fr, $sa, $so) = @_;
	fhem ("set ".$dev." tempListMon prep ".$mo);
  fhem ("set ".$dev." tempListTue prep ".$di);
  fhem ("set ".$dev." tempListWed prep ".$mi);
  fhem ("set ".$dev." tempListThu prep ".$do);
  fhem ("set ".$dev." tempListFri prep ".$fr);
  fhem ("set ".$dev." tempListSat prep ".$sa);
  fhem ("set ".$dev." tempListSun exec ".$so);
}

######################################################
# Temperatur-Liste fürs [HM-CC-RT-DN]
# setzen per Aufruf von "{SetTempList_Heizung_[HM-CC-RT-DN]}"
# Vorsicht, bei HM-CC-RT-DN (im Unterschied zum z.B. HM-CC-TC), ist 
# ein anderer Channel zu nehmen. Zudem wird mit prep|exec gearbeitet, 
# um nicht alle Zeilen als einzelnen Befehl zu senden, 
# sondern per "prep" erst alles zusammenzufassen 
# und dann per "exec" an das Thermostat zu senden.
# Also als ein einziger Befehl statt sieben. Vermeidet "NACKs"
# HM-CC-RT-DN Channel: Clima
# HM-TC-IT-WM-W-EU Channel: Climate
######################################################

# Start SetTempList_Heizung_[HM-CC-RT-DN1]
sub
SetTempList_Heizung_[HM-CC-RT-DN1]()
 {
    my($mo, $di, $mi, $do, $fr, $sa, $so);
 	  
 	  $mo = "01:00 20.0 05:00 19.5 09:00 21.5 16:00 20.0 18:00 20.5 24:00 21.5";
 	  $di = "01:00 20.0 05:00 19.5 09:00 21.5 16:00 20.0 18:00 20.5 24:00 21.5";
 	  $mi = "01:00 20.0 05:00 19.5 09:00 21.5 16:00 20.0 18:00 20.5 24:00 21.5";
 	  $do = "01:00 20.0 05:00 19.5 09:00 21.5 16:00 20.0 18:00 20.5 24:00 21.5";
 	  $fr = "02:00 20.0 05:00 19.5 09:00 21.5 15:00 20.0 18:00 20.5 24:00 21.5";
 	  $sa = "02:00 20.0 06:30 19.5 10:00 21.5 15:00 20.0 18:00 20.5 24:00 21.5";
 	  $so = "01:00 20.0 06:30 19.5 10:00 21.5 15:00 20.0 18:00 20.5 24:00 21.5";
 	  
    SetTempList_Heizung("[HM-CC-RT-DN1]_Clima", $mo, $di, $mi, $do, $fr, $sa, $so);
    # SetTempList_Heizung("[HM-TC-IT-WM-W-EU1]_Climate", $mo, $di, $mi, $do, $fr, $sa, $so);
}
# End SetTempList_Heizung_[HM-CC-RT-DN1]

# Start SetTempList_Heizung_[HM-CC-RT-DN2]
sub
SetTempList_Heizung_[HM-CC-RT-DN2]()
 {
    my($mo, $di, $mi, $do, $fr, $sa, $so);
 	  
 	  $mo = "01:00 20.0 05:00 20.5 09:00 22.0 16:00 21.0 18:00 21.5 24:00 22.5";
 	  $di = "01:00 20.0 05:00 20.5 09:00 22.0 16:00 21.0 18:00 21.5 24:00 22.5";
 	  $mi = "01:00 20.0 05:00 20.5 09:00 22.0 16:00 21.0 18:00 21.5 24:00 22.5";
 	  $do = "01:00 20.0 05:00 20.5 09:00 22.0 16:00 21.0 18:00 21.5 24:00 22.5";
 	  $fr = "02:00 20.0 05:00 20.5 09:00 22.0 15:00 21.0 18:00 21.5 24:00 22.5";
 	  $sa = "02:00 20.0 06:30 20.5 10:00 22.0 15:00 21.0 18:00 21.5 24:00 22.5";
 	  $so = "01:00 20.0 06:30 20.5 10:00 22.0 15:00 21.0 18:00 21.5 24:00 22.5";
 	  
    SetTempList_Heizung("[HM-CC-RT-DN2]_Clima", $mo, $di, $mi, $do, $fr, $sa, $so);
    # SetTempList_Heizung("[HM-TC-IT-WM-W-EU2]_Climate", $mo, $di, $mi, $do, $fr, $sa, $so);
}
# End SetTempList_Heizung_[HM-CC-RT-DN2]

1;
