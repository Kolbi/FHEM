## http://www.fhemwiki.de/wiki/DevelopmentModuleIntro

package main;
use strict;
use warnings;

my %Hello_gets = (
	"whatyouwant"	=> "can't",
	"whatyouneed"	=> "try sometimes",
	"satisfaction"  => "no"
);

sub Hello_Initialize($) {
    my ($hash) = @_;

    $hash->{DefFn}      = 'Hello_Define';
    $hash->{UndefFn}    = 'Hello_Undef';
    $hash->{SetFn}      = 'Hello_Set';
    $hash->{GetFn}      = 'Hello_Get';
    $hash->{AttrFn}     = 'Hello_Attr';
    $hash->{ReadFn}     = 'Hello_Read';

    $hash->{AttrList} =
          "formal:yes,no "
        . $readingFnAttributes;
}

sub Hello_Define($$) {
    my ($hash, $def) = @_;
    my @param = split('[ \t]+', $def);
    
    if(int(@param) < 3) {
        return "too few parameters: define <name> Hello <greet>";
    }
    
    my $hash->{name}  = $param[0];
    my $hash->{greet} = $param[2];
    
    return undef;
}

sub Hello_Undef($$) {
    my ($hash, $arg) = @_; 
    # nothing to do
    return undef;
}

sub Hello_Get($@) {
	my ($hash, @param) = @_;
	
	return '"get Hello" needs at least one argument' if (int(@param) < 2);
	
	my $name = shift @param;
	my $opt = shift @param;
	if(!$Hello_gets{$opt}) {
		my @cList = keys %Hello_gets;
		return "Unknown argument $opt, choose one of " . join(" ", @cList);
	}
	
	if($attr{$name}{formal} eq 'yes') {
	    return $Hello_gets{$opt}.', sir';
    }
	return $Hello_gets{$opt};
}

sub Hello_Set($@) {
	my ($hash, @param) = @_;
	
	return '"set Hello" needs at least one argument' if (int(@param) < 2);
	
	my $name = shift @param;
	my $opt = shift @param;
	my $value = join("", @param);
	
	if(!defined($Hello_gets{$opt})) {
		my @cList = keys %Hello_gets;
		return "Unknown argument $opt, choose one of " . join(" ", @cList);
	}
    $hash->{STATE} = $Hello_gets{$opt} = $value;
    
	return "$opt set to $value. Try to get it.";
}


sub Hello_Attr(@) {
	my ($cmd,$name,$attr_name,$attr_value) = @_;
	if($cmd eq "set") {
        if($attr_name eq "formal") {
			if($attr_value !~ /^yes|no$/) {
			    my $err = "Invalid argument $attr_value to $attr_name. Must be yes or no.";
			    Log 3, "Hello: ".$err;
			    return $err;
			}
		} else {
		    return "Unknown attr $attr_name";
		}
	}
	return undef;
}

1;

=pod
=begin html

<a name="Hello"></a>
<h3>Hello</h3>
<ul>
    <i>Hello</i> implements the classical "Hello World" as a starting point for module development. 
    You may want to copy 98_Hello.pm to start implementing a module of your very own. See 
    <a href="http://www.fhemwiki.de/wiki/DevelopmentModuleIntro">DevelopmentModuleIntro</a> for an 
    in-depth instruction to your first module.
    <br><br>
    <a name="Hellodefine"></a>
    <b>Define</b>
    <ul>
        <code>define <name> Hello <greet></code>
        <br><br>
        Example: <code>define HELLO Hello TurnUrRadioOn</code>
        <br><br>
        The "greet" parameter has no further meaning, it just demonstrates
        how to set a so called "Internal" value. See <a href="http://fhem.de/commandref.html#define">commandref#define</a> 
        for more info about the define command.
    </ul>
    <br>
    
    <a name="Helloset"></a>
    <b>Set</b><br>
    <ul>
        <code>set <name> <option> <value></code>
        <br><br>
        You can <i>set</i> any value to any of the following options. They're just there to 
        <i>get</i> them. See <a href="http://fhem.de/commandref.html#set">commandref#set</a> 
        for more info about the set command.
        <br><br>
        Options:
        <ul>
              <li><i>satisfaction</i><br>
                  Defaults to "no"</li>
              <li><i>whatyouwant</i><br>
                  Defaults to "can't"</li>
              <li><i>whatyouneed</i><br>
                  Defaults to "try sometimes"</li>
        </ul>
    </ul>
    <br>

    <a name="Helloget"></a>
    <b>Get</b><br>
    <ul>
        <code>get <name> <option></code>
        <br><br>
        You can <i>get</i> the value of any of the options described in 
        <a href="#Helloset">paragraph "Set" above</a>. See 
        <a href="http://fhem.de/commandref.html#get">commandref#get</a> for more info about 
        the get command.
    </ul>
    <br>
    
    <a name="Helloattr"></a>
    <b>Attributes</b>
    <ul>
        <code>attr <name> <attribute> <value></code>
        <br><br>
        See <a href="http://fhem.de/commandref.html#attr">commandref#attr</a> for more info about 
        the attr command.
        <br><br>
        Attributes:
        <ul>
            <li><i>formal</i> no|yes<br>
                When you set formal to "yes", all output of <i>get</i> will be in a
                more formal language. Default is "no".
            </li>
        </ul>
    </ul>
</ul>

=end html

=cut
