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
# SetTempList_Heizung($$$$$$$$)
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
    
    #{ fhem ("set [HM-CC-RT-DN1]_Clima tempListMon prep 01:00 20.0 05:00 19.5 09:00 21.5 16:00 20.0 18:00 20.5 24:00 21.5")};
    #{ fhem ("set [HM-TC-IT-WM-W-EU1]_Climate tempListSun exec 01:00 20.0 06:30 19.5 10:00 21.5 15:00 20.0 18:00 20.5 24:00 21.5")};
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
######################################################
# SetTempList_Heizung($$$$$$$$)
######################################################

######################################################
# SetTempList_Heizung_Eco
# setzen per Aufruf von "{SetTempList_Heizung_Eco}"
######################################################
sub
SetTempList_Heizung_Eco()
 {
   { fhem ("set [HM-CC-RT-DN1]_Clima controlManu prep 17.0")};
   { fhem ("set [HM-CC-RT-DN2]_Clima controlManu exec 17.0")};
}
######################################################
# SetTempList_Heizung_Eco
######################################################

######################################################
# SetTempList_Heizung_Auto
# setzen per Aufruf von "{SetTempList_Heizung_Auto}"
######################################################
sub
SetTempList_Heizung_Auto()
 {
   { fhem ("set [HM-CC-RT-DN1]_Clima controlMode prep auto")};
   { fhem ("set [HM-CC-RT-DN2]_Clima controlMode exec auto")};
}
######################################################
# SetTempList_Heizung_Auto
######################################################

######################################################
# SetTempList_Heizung_M_21
# setzen per Aufruf von "{SetTempList_Heizung_Eco}"
######################################################
sub
SetTempList_Heizung_M_21()
 {
   { fhem ("set [HM-CC-RT-DN1]_Clima controlManu prep 21.0")};
   { fhem ("set [HM-CC-RT-DN2]_Clima controlManu exec 21.0")};
}
######################################################
# SetTempList_Heizung_M_21
######################################################

######################################################
# Kalenderstart
######################################################
sub
Kalenderstart ($)
{
	my ($Ereignis) = @_;
	my @Ereignisarray = split(/.*:\s/,$Ereignis);
	my $Ereignisteil1 = $Ereignisarray[1];
	my @uids=split(/;/,$Ereignisteil1);
	foreach my $uid (@uids) {
		my $Kalendertext = fhem("get Kalender_Christian summary $uid");
		if ($Kalendertext =~ /Urlaub/) {
			fhem("set Urlaub_dummy ja");
		};
		if ($Kalendertext =~ /Urlaub2/) {
			fhem("set Urlaub2_dummy ja");
		};
		if ($Kalendertext =~ /Besuch/) {
			fhem("set Gast_dummy ja");
		};
		if ($Kalendertext =~ /Feiertag/) {
			fhem("set Feiertag_dummy ja");
		};
	};
}
######################################################
# Kalenderstart
######################################################

######################################################
# Kalenderende
######################################################
sub 
Kalenderende ($) 
{
	my ($Ereignis) = @_;
	my @Ereignisarray = split(/.*:\s/,$Ereignis);
	my $Ereignisteil1 = $Ereignisarray[1];
	my @uids=split(/;/,$Ereignisteil1);
	foreach my $uid (@uids) {
		my $Kalendertext = fhem("get Kalender_Christian summary $uid");
		if ($Kalendertext =~ /Urlaub/) {
			fhem("set Urlaub_dummy nein");
		};
		if ($Kalendertext =~ /Urlaub2/) {
			fhem("set Urlaub2_dummy nein");
		};
		if ($Kalendertext =~ /Besuch/) {
			fhem("set Gast_dummy nein");
		};
		if ($Kalendertext =~ /Feiertag/) {
			fhem("set Feiertag_dummy nein");
		};
	};
}
######################################################
# Kalenderende
######################################################

######################################################
# Müllkalender
# http://www.blog-gedanken.de/smarthome-2/smarthome-mit-fhem-umsetzung-meines-abfallkalenders/
######################################################
#
# Hilfsfunktion für Kalenderauswertungen
#
sub
KalenderDatum($$)
{
 my ($KalenderName, $KalenderUid) = @_;
 my $dt = fhem("get $KalenderName start $KalenderUid");
 my @SplitDt = split(/ /,$dt);
 my @SplitDate = split(/\./,$SplitDt[0]);
 my $ret = timelocal(0,0,0,$SplitDate[0],$SplitDate[1]-1,$SplitDate[2]);
 
 return $ret;
}
#
# Abfall Kalender auswerten / Kalender: "Kalender_Muell"
#
sub
Abfalltermine ($)
{
my ($Ereignis) = @_;
my @Ereignisarray = split(/.*:\s/,$Ereignis);
my $Ereignisteil1 = $Ereignisarray[1];
my @uids=split(/;/,$Ereignisteil1); #id des Kalendereintrags
my $t = time;
my $dtPapier = ''; #Datum der Leerung
my $dtWertstoff = '';
my $dtRest = '';
my $dtBiotonne = '';
my $Kalendername = 'Kalender_Muell';
 
foreach my $uid (@uids) {
	my $Kalendertext = fhem("get $Kalendername summary $uid");
   	if ($Kalendertext =~ /Blaue Tonne/)
   {
	  # befüllt $eventDate mit dem Kalenderdatum aus dem zutreffenden Treffer
      my $eventDate = KalenderDatum($Kalendername, $uid);
	  # Beim ersten Durchlauf ist $dtPapier immer leer
	  # Beim zweiten Durchlauf nicht, daher muss $eventDate in der Zukunft liegen und kleiner sein, als das vorherige Ergebnis
	  # so wird die nächste Abholung ermittelt
      if ($dtPapier eq '' || ($eventDate < $dtPapier && $eventDate > $t))
      {
		 # setze $dtPapier mit erstem Wert aus erstem Treffer
         $dtPapier = $eventDate;
		 # Differenztage zwischen $dtPapier und $time
         my $dayDiff = floor(($dtPapier - $t) / 60 / 60 / 24 + 1);
		 # Wenn Differenz grösser gleich 0 dann setze Reading mit Tagesanzahl
         if ($dayDiff >= 0) {
         	fhem("setreading MuellterminDummy BlaueTonne $dayDiff");
         	# Sollte dem Dummy den nächsten Abholtermin übergeben
         	fhem("set Blau_dummy $dtPapier");
         }
      }
   if ($Kalendertext =~ /Gelber Sack/) {
      my $eventDate = KalenderDatum('$Kalendername', $uid);
      if ($dtWertstoff eq '' || ($eventDate < $dtWertstoff && $eventDate > $t))
      {
         $dtWertstoff = $eventDate;
   
         my $dayDiff = floor(($dtWertstoff - $t) / 60 / 60 / 24 + 1);
         if ($dayDiff >= 0) { 
         	fhem("setreading MuellterminDummy GelbeTonne $dayDiff");
         	fhem("set Gelb_dummy $dtWertstoff");
         }
      }
   };
   if ($Kalendertext =~ /Restmüll/) {
      my $eventDate = KalenderDatum('$Kalendername', $uid);
      if ($dtRest eq '' || ($eventDate < $dtRest && $eventDate > $t))
      {
          $dtRest = $eventDate;
 
          my $dayDiff = floor(($dtRest - $t) / 60 / 60 / 24 + 1);
          if ($dayDiff >= 0) { 
          	fhem("setreading MuellterminDummy Restmuell $dayDiff"); 
          	fhem("set Restmuell_dummy $dtRest");
          }
      }
   };
   if ($Kalendertext =~ /Grünabfall/) {
      my $eventDate = KalenderDatum('$Kalendername', $uid);
      if ($dtBiotonne eq '' || ($eventDate < $dtBiotonne && $eventDate > $t))
      {
         $dtBiotonne = $eventDate;
         
         my $dayDiff = floor(($dtBiotonne - $t) / 60 / 60 / 24 + 1);
         if ($dayDiff >= 0) { 
         	fhem("setreading MuellterminDummy BioTonne $dayDiff");
         	fhem("set Gruen_dummy $dtBiotonne");
         	}
      };
   };
}
}
}
######################################################
# Müllkalender
# http://www.blog-gedanken.de/smarthome-2/smarthome-mit-fhem-umsetzung-meines-abfallkalenders/
######################################################

######################################################
# DebianMail  Mail auf dem RPi versenden
# http://www.fhemwiki.de/wiki/E-Mail_senden
# define Sonstiges at *01:00:00 {\
# DebianMail('email@email.domain','Subject','Text','Anhang');;\
# }
######################################################
sub 
DebianMail 
{ 
 my $rcpt = shift;
 my $subject = shift; 
 my $text = shift;
 my $attach = shift; 
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
######################################################
# DebianMail  Mail auf dem RPi versenden
######################################################

1;
