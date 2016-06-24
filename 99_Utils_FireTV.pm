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
