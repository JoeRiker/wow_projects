#!/usr/bin/perl

####################################
# Get WoW Armory Data via JSON API #
#----------------------------------#
# Alexandro Ghettini          2018 #
####################################

use LWP::Simple;                # From CPAN
use JSON qw( decode_json );     # From CPAN
use Data::Dumper;               # Perl core module
use Getopt::Long;
use strict;                     # Good practice
use warnings;                   # Good practice

my %args;
GetOptions(\%args,
           "toon=s",
           "realm=s",
           "region=s",
) or die "Invalid arguments!";
die "Missing -toon!" unless $args{toon};
die "Missing -realm!" unless $args{realm};
die "Missing -region!" unless $args{region};

my $TOON;
my $REALM;
my $REGION;

$TOON   = $args{toon};
$REALM  = $args{realm};
$REGION = $args{region};

my @WOW_RACE;
$WOW_RACE[1]='Human';
$WOW_RACE[2]='Orc';
$WOW_RACE[3]='Dwarf';
$WOW_RACE[4]='Night Elf';
$WOW_RACE[5]='Undead';
$WOW_RACE[6]='Tauren';
$WOW_RACE[7]='Gnome';                # Killaaaa
$WOW_RACE[8]='Troll';
$WOW_RACE[9]='Goblin';               # Useless
$WOW_RACE[10]='Blood Elf';
$WOW_RACE[11]='Draenei';
$WOW_RACE[12]='Fel Orc';             # Unused
$WOW_RACE[13]='Naga';                # Unused
$WOW_RACE[14]='Broken';              # Unused
$WOW_RACE[15]='Skeleton';            # Unused
$WOW_RACE[16]='Vrykul';              # Unused
$WOW_RACE[17]='Tuskarr';             # Unused
$WOW_RACE[18]='Forest Troll';        # Unused
$WOW_RACE[19]='Taunka';              # Unused
$WOW_RACE[20]='Northrend Skeleton';  # Unused
$WOW_RACE[21]='Ice Troll';           # Unused
$WOW_RACE[22]='Worgen';
$WOW_RACE[24]='Pandaren';            # Neutral
$WOW_RACE[25]='Pandaren';            # Alliance
$WOW_RACE[26]='Pandaren';            # Horde

my @WOW_CLASS;
$WOW_CLASS[1]='Warrior';
$WOW_CLASS[2]='Paladin';
$WOW_CLASS[3]='Hunter';
$WOW_CLASS[4]='Rogue';
$WOW_CLASS[5]='Priest';
$WOW_CLASS[6]='Death Knight';
$WOW_CLASS[7]='Shaman';
$WOW_CLASS[8]='Mage';
$WOW_CLASS[9]='Warlock';
$WOW_CLASS[10]='Monk';
$WOW_CLASS[11]='Druid';
$WOW_CLASS[12]='Demon Hunter';

my @WOW_FACTION;
$WOW_FACTION[0]='Alliance';
$WOW_FACTION[1]='Horde';

my @WOW_GENDER;
$WOW_GENDER[0]='Male';
$WOW_GENDER[1]='Female';

my $B_NET_URL      = "https://$REGION.api.battle.net/";
my $B_NET_GAME     = 'wow';
my $B_NET_DATATYPE = 'character';
my $B_NET_APIKEY   = 'nznj279tewden8bs68p4q9pw2x6e9rtc';
#my $B_NET_REALM    = 'Pozzo%20dell\'Eternità';
my $B_NET_REALM    = $REALM;
my $B_NET_CHAR     = $TOON;
my $B_NET_LOCALE   = 'it_IT';
my $B_NET_FIELD    = 'stats,talents';
my $URL = "$B_NET_URL$B_NET_GAME/$B_NET_DATATYPE/$B_NET_REALM/$B_NET_CHAR?fields=$B_NET_FIELD&locale=$B_NET_LOCALE&apikey=$B_NET_APIKEY";

my $json = get( $URL );
my $decoded_json = decode_json( $json );

# Decommentare per dumpare il JSON 
print Dumper $decoded_json;
print "----------------------------------------------------\n";
print "Charachter : ",
	$decoded_json->{'name'},
	"\n";
print "Faction    : ",
	$WOW_FACTION[$decoded_json->{'faction'}],
	"\n";
print "Class      : ",
	$WOW_CLASS[$decoded_json->{'class'}],
	"\n";
print "Race       : ",
	$WOW_RACE[$decoded_json->{'race'}],
	"\n";
print "Gender     : ",
	$WOW_GENDER[$decoded_json->{'gender'}],
	"\n----------------------------------------------------\n";
print "- Stats: Agility      : ",
	$decoded_json->{'stats'}{'agi'},
	"\n";
print "         Strenght     : ",
	$decoded_json->{'stats'}{'str'},
	"\n";
print "         Intellect    : ",
	$decoded_json->{'stats'}{'int'},
	"\n         -------------------------------------------\n";
print "         Critical     : ",
	$decoded_json->{'stats'}{'crit'},
	" ( Rating: ",
	$decoded_json->{'stats'}{'critRating'},
	" )\n";
print "         Haste        : ",
	$decoded_json->{'stats'}{'haste'},
	"\n";
print "         Mastery      : ",
	$decoded_json->{'stats'}{'mastery'},
	" ( Rating: ",
	$decoded_json->{'stats'}{'masteryRating'},
	" )\n";
print "         Verstatility : ",
	$decoded_json->{'stats'}{'versatility'},
	"\n";

