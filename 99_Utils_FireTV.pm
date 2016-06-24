# Quelle: https://forum.fhem.de/index.php/topic,28770.msg335420.html#msg335420
# Author: nesges (https://github.com/nesges)

# 1.) activate adb debugging in your fire tv
# 2.) get adb for Raspberry from http://forum.xda-developers.com/attachment.php?attachmentid=1392336&d=1349930509
# 3.) copy the binary to /usr/bin/
# 
# general keycodes: http://developer.android.com/reference/android/view/KeyEvent.html

package main;
use strict;
use warnings;
use Switch;
# use Time::HiRes;
use Date::Parse;

sub Utils_FireTV_Initialize($$) {
    my ($hash) = @_;
}

# adb wrapper
sub ftv_adb($;$) {
    my $cmd = shift;
    my $host = shift;
    
    my $saved_host;
    my $saved_host_ts = str2time(ReadingsTimestamp('adb', 'host', 0));
    # read adb:host into $saved_host if it is max 10s old
    if( $saved_host_ts >= time - 10) {
        $saved_host = ReadingsVal('adb', 'host', '');
    }
    
    # param $host not given, try using $saved_host
    if(! $host) {
        Log 3, "host not given, using adb:host $saved_host";
        $host = $saved_host;
    }
    
    # give up if $host is still not set
    if(! $host) { 
        Log 3, "ftv_adb: parameter host never set";
    }
    
    # if $saved_host and $host differ, reconnect
    if($saved_host ne $host) {
        Log 3, "new host $saved_host";

        # delete adb dummy
        fhem("delete adb");
        system("adb disconnect");

        # ...and redefine it
        fhem("define adb dummy");
        fhem("attr adb room hidden");
        fhem("setreading adb host $host");
        
        system("adb connect $host");
    }
    
    Log 3, "adb $cmd";
    system("adb $cmd");
    
    # save $host in adb:host
    fhem("setreading adb host $host");
}

# send a single keyevent using adb
sub ftv_key($;$) {
    my $key = shift;
    my $host = shift;
    ftv_adb("shell input keyevent $key", $host);
}

# send a text using adb
sub ftv_text($;$) {
    my $text = shift;
    my $host = shift;
    
    $text =~ s/ /%s/g;
    
    ftv_adb("shell input text $text", $host);
}


# one function for each fire remote button

sub ftv_up(;$) {
    ftv_key("KEYCODE_DPAD_UP", shift);
}

sub ftv_left(;$) {
    ftv_key("KEYCODE_DPAD_LEFT", shift);
}
sub ftv_enter(;$) {
    ftv_key("KEYCODE_DPAD_CENTER", shift);
}
sub ftv_right(;$) {
    ftv_key("KEYCODE_DPAD_RIGHT", shift);
}

sub ftv_down(;$) {
    ftv_key("KEYCODE_DPAD_DOWN", shift);
}

sub ftv_back(;$) {
    ftv_key("KEYCODE_BACK", shift);
}
sub ftv_home(;$) {
    ftv_key("KEYCODE_HOME", shift);
}
sub ftv_menu(;$) {
    ftv_key("KEYCODE_MENU", shift);
}

sub ftv_prev(;$) {
    ftv_key("KEYCODE_MEDIA_PREVIOUS", shift);
}
sub ftv_playpause(;$) {
    ftv_key("KEYCODE_MEDIA_PLAY_PAUSE", shift);
}
sub ftv_next(;$) {
    ftv_key("KEYCODE_MEDIA_FAST_FORWARD", shift);
}

# complex actions

# navigate to global search, enter some text and navigate to the first result
sub ftv_search($;$) {
    my $text = shift;
    my $host = shift;
    
    ftv_home($host);
    ftv_up();
    ftv_enter();
    if($text) {
        ftv_text($text);
        ftv_next();
        ftv_down();
        ftv_enter();
    }
}

# navigate to system settings -> installed apps
sub ftv_apps(;$) {
    my $host = shift;
    
    ftv_home($host);
    
    ftv_down();
    ftv_down();
    ftv_down();
    ftv_down();
    ftv_down();
    ftv_down();
    ftv_down();
    ftv_down();
    ftv_down();
    ftv_down();
    
    ftv_right();
    ftv_right();
    ftv_right();
    ftv_right();
    ftv_enter();
    
    ftv_down();
    ftv_down();
    ftv_down();
    ftv_down();
    ftv_enter();
}

1;

=pod
=begin html
 
<a name="Utils_FireTV"></a>
<h3>Utils_FireTV</h3>
<ul>
  <b>Name</b>
  <br>
  Text<br>
  Examples:
  <ul>
   <code> <li data-row="1" data-col="2" data-sizex="2" data-sizey="4">
        <header>FIRE TV</header>
        <div class="centered container">
            <div id="" data-type="button" data-fhem-cmd="{ftv_up('192.168.178.41')}" data-icon="fa-angle-up" data-on-background-color="#2E8AE6" class="cell"></div>
        </div>
        <div class="centered container">
            <div id="" data-type="button" data-fhem-cmd="{ftv_left('192.168.178.41')}" data-icon="fa-angle-left" data-on-background-color="#2E8AE6" class="cell"></div>
            <div id="" data-type="button" data-fhem-cmd="{ftv_enter('192.168.178.41')}" data-icon="fa-check-circle" data-on-background-color="#0066FF" class="cell"></div>
            <div id="" data-type="button" data-fhem-cmd="{ftv_right('192.168.178.41')}" data-icon="fa-angle-right" data-on-background-color="#2E8AE6" class="cell"></div>
        </div>
        <div class="centered container">
            <div id="" data-type="button" data-fhem-cmd="{ftv_down('192.168.178.41')}" data-icon="fa-angle-down" data-on-background-color="#2E8AE6" class="cell"></div>
        </div>
        
        <div class="centered container" style="margin-top:30px">
            <div id="" data-type="button" data-fhem-cmd="{ftv_back('192.168.178.41')}" data-icon="fa-arrow-circle-o-left" data-on-background-color="#aa6900" class="cell"></div>
            <div id="" data-type="button" data-fhem-cmd="{ftv_home('192.168.178.41')}" data-icon="fa-home" data-on-background-color="#9933FF" class="cell"></div>
            <div id="" data-type="button" data-fhem-cmd="{ftv_menu('192.168.178.41')}" data-icon="fa-bars" data-on-background-color="#aa6900" class="cell"></div>
        </div>
        
        <div class="centered container">
            <div id="" data-type="button" data-fhem-cmd="{ftv_prev('192.168.178.41')}" data-icon="fa-backward" data-on-background-color="#aa6900" class="cell"></div>
            <div id="" data-type="button" data-fhem-cmd="{ftv_playpause('192.168.178.41')}" data-icon="fa-play" data-on-background-color="#FFCC00" class="cell"></div>
            <div id="" data-type="button" data-fhem-cmd="{ftv_next('192.168.178.41')}" data-icon="fa-forward" data-on-background-color="#aa6900" class="cell"></div>
        </div>
        
        <div class="centered container" style="margin-top:30px">
            <div id="" data-type="button" data-fhem-cmd="{ftv_search('Terminator 1', '192.168.178.41')}" data-icon="fa-search" data-on-background-color="#808080" class="cell"></div>
            <div id="" data-type="button" data-fhem-cmd="{ftv_apps('192.168.178.41')}" data-icon="fa-tasks" data-on-background-color="#808080" class="cell"></div>
        </div></code>
    </li>
  </ul>
</ul>
 
=end html
=begin html_DE
 
<a name="Utils_FireTV"></a>
<h3>Utils_FireTV</h3>
<ul>
  <b>Name</b>
  <br>
  Text<br>
  Examples:
  <ul>
   <code> <li data-row="1" data-col="2" data-sizex="2" data-sizey="4">
        <header>FIRE TV</header>
        <div class="centered container">
            <div id="" data-type="button" data-fhem-cmd="{ftv_up('192.168.178.41')}" data-icon="fa-angle-up" data-on-background-color="#2E8AE6" class="cell"></div>
        </div>
        <div class="centered container">
            <div id="" data-type="button" data-fhem-cmd="{ftv_left('192.168.178.41')}" data-icon="fa-angle-left" data-on-background-color="#2E8AE6" class="cell"></div>
            <div id="" data-type="button" data-fhem-cmd="{ftv_enter('192.168.178.41')}" data-icon="fa-check-circle" data-on-background-color="#0066FF" class="cell"></div>
            <div id="" data-type="button" data-fhem-cmd="{ftv_right('192.168.178.41')}" data-icon="fa-angle-right" data-on-background-color="#2E8AE6" class="cell"></div>
        </div>
        <div class="centered container">
            <div id="" data-type="button" data-fhem-cmd="{ftv_down('192.168.178.41')}" data-icon="fa-angle-down" data-on-background-color="#2E8AE6" class="cell"></div>
        </div>
        
        <div class="centered container" style="margin-top:30px">
            <div id="" data-type="button" data-fhem-cmd="{ftv_back('192.168.178.41')}" data-icon="fa-arrow-circle-o-left" data-on-background-color="#aa6900" class="cell"></div>
            <div id="" data-type="button" data-fhem-cmd="{ftv_home('192.168.178.41')}" data-icon="fa-home" data-on-background-color="#9933FF" class="cell"></div>
            <div id="" data-type="button" data-fhem-cmd="{ftv_menu('192.168.178.41')}" data-icon="fa-bars" data-on-background-color="#aa6900" class="cell"></div>
        </div>
        
        <div class="centered container">
            <div id="" data-type="button" data-fhem-cmd="{ftv_prev('192.168.178.41')}" data-icon="fa-backward" data-on-background-color="#aa6900" class="cell"></div>
            <div id="" data-type="button" data-fhem-cmd="{ftv_playpause('192.168.178.41')}" data-icon="fa-play" data-on-background-color="#FFCC00" class="cell"></div>
            <div id="" data-type="button" data-fhem-cmd="{ftv_next('192.168.178.41')}" data-icon="fa-forward" data-on-background-color="#aa6900" class="cell"></div>
        </div>
        
        <div class="centered container" style="margin-top:30px">
            <div id="" data-type="button" data-fhem-cmd="{ftv_search('Terminator 1', '192.168.178.41')}" data-icon="fa-search" data-on-background-color="#808080" class="cell"></div>
            <div id="" data-type="button" data-fhem-cmd="{ftv_apps('192.168.178.41')}" data-icon="fa-tasks" data-on-background-color="#808080" class="cell"></div>
        </div></code>
    </li>
  </ul>
</ul>

=end html_DE
=cut
