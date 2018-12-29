#! /usr/bin/perl

# Program:      losung.pl
# Author:       Sven Claussner
# Purpose:      shows a daily Bible verse (Losungen)
# Call:         losung.pl [line length]
#               line length: maximum length of each output line
# Requirements: needs Perl
#               file 'losungen<Year>.csv' must be in current directory
# License:
#    Copyright (C) 2010 by Sven Claussner <>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# History:
#   19.12.2010 Creation
#   18.04.2014 Update copyright note (www.ebu.de->www.herrnhuter.de)
#   05.01.2015 Translate source code to English
#   15.01.2016 Handle lines without a named sunday properly
#   28.12.2016 Output UTF-8 encoded to handle umlauts properly.
#              Prepare for UTF-8 encoded input file.

use strict;
use warnings;
use utf8;
use Encode;

# Initialization
my $csvFile;            # file handle for CSV file
my $csvFilename;        # path to CSV file
my $currentDate;
my $currentDay;
my $currentMonth;
my $currentYear;
my $watchwordVerse;     # current Losungen verse
my $watchwordText;      # current Losungen citation
my $teachingVerse;      # additional text
my $teachingText;       # additional citation
my $dayOfWeek;
my $errorMsg;
my $textlength;
my $DEBUG=0; # 1=show debug messages; other values=hide debug messages
my $ok;                 # auxiliary variable
my $line1;
my @columns;		# text columns for each day

$errorMsg="";
print "\n";

# input with UTF-8 encoding
# binmode(STDIN,  "encoding(utf8)");

# output with UTF-8 encoding
binmode(STDOUT, ":utf8");

# validate input parameters
# optional value for line length must be a number>=1
$_=$ARGV[0];
if (defined $ARGV[0] && m/\d/g && $ARGV[0]>=1 ){
	$textlength=$ARGV[0];
} else {
# otherwise use default line length of 40 characters
	$textlength=40;
}
debug ("Debug: text length: $textlength\n");

# get date
(undef, undef, undef, $currentDay, $currentMonth, $currentYear, undef, undef, undef) = localtime(time);
$currentMonth=sprintf("%02d",$currentMonth+1);
$currentYear=sprintf("%04d",$currentYear+1900);
$currentDay=sprintf("%02d",$currentDay);
$currentDate="$currentDay.$currentMonth.$currentYear";

# open and read input file
$_=$0;
/(.*)\/[\w\.]+$/;
my $workingdir = $1;
$csvFilename="$workingdir/losungen$currentYear.csv";

# check for existence of input file
if (! -e $csvFilename) {
	errorlog("The file $csvFilename is missing.");
}

# check read access permissions on input file
if (! -r $csvFilename) {
	errorlog("You don't have read permissions for file $csvFilename.");
}

open( $csvFile, $csvFilename);

# check file format
$ok=0; # false
if (-f $csvFilename){
	$_=<$csvFile>;
	my ($line1) = m/(^.+?)\r\n/;
	if ($line1 eq "Datum\tWtag\tSonntag\tLosungsvers\tLosungstext\tLehrtextvers\tLehrtext") {
		$ok=1;
	}
}
if (! $ok==1) {
	errorlog("The file $csvFilename is corrupted.");
}

while (<$csvFile>){
  if (/$currentDate/){
  	chomp;
  	s/\r//g;
    
    @columns=split(/\t/,$_);
    if (scalar @columns==6) {
      ($dayOfWeek,$watchwordVerse,$watchwordText,$teachingVerse,$teachingText)=($columns[1],$columns[2],$columns[3],$columns[4],$columns[5]);
    }
    else {
      ($dayOfWeek,$watchwordVerse,$watchwordText,$teachingVerse,$teachingText)=($columns[1],$columns[3],$columns[4],$columns[5],$columns[6]);
    } 
  }
}

# output
if (defined $errorMsg && ! $errorMsg eq ""){
  # output error messages
  printw($errorMsg,$textlength);
} else {
  # output in case of success
  printw("Losung für $dayOfWeek, den $currentDate:\n",$textlength);
  printw("$watchwordText ($watchwordVerse)\n",$textlength);
  printw("$teachingText ($teachingVerse)\n",$textlength);
  printw("(C) Evangelische Brueder-Unität - Herrnhuter Brüdergemeine: www.herrnhuter.de\n",$textlength);
  printw("Weitere Informationen finden Sie hier: www.losungen.de", $textlength);
}
print "\n";

# cleanup
END {
	if (defined $csvFile) {close $csvFile};
}

# Write error messages to the variable $errorMsg; display error message and stop program.
sub errorlog{
  $errorMsg=$_[0];
  printw("Error showing the watchwords:",$textlength);
  printw($errorMsg,$textlength);
  exit 1;
}

# Display debug messages, if enabled.
sub debug{
  if ($DEBUG==1){
	print $_[0];
}
}

# Split a text. Break at the last whitespace or the given length.
# Call: printw(text,line length)
sub printw{
	my ($text,$length)=@_;
	 
	# validate input parameters. Cancel in case of missing parameters.
	if (!defined $text || !defined $length){
		print ("Error calling the subroutine printw: At least one parameter is missing. Use printw(text,line length)\n");
		return;
	}
	
	# cancel if line length is not a number
	$_=$length;
	if (m/\D/g) {
		print ("Error calling the subroutine printw: The line length parameter must be numeric.\n");
		return;
	}
	
	# cancel if line length is less than 1
	if ($length<1) {
		print ("Error calling the subroutine printw: The line length must be 1 or greater.\n");
		return;
	}

	debug("length:$length\n");
	debug("text:$text\n");
	debug("text length:".length($text)."\n");
	
	# split text. Break at the last whitespace, at max at the given length.
	my @singlewords=split(/ /,$text);
	my $singlewordscount = @singlewords;	
	my @words;
	my $i=0;
	while ($i<$singlewordscount) {
		if (length($singlewords[$i])<=$length) {
			push @words,$singlewords[$i];
			$i++;
		} else {
			# split overlong strings into matching substrings and add
			# them separately to the list @words
			push @words,substr($singlewords[$i],0,$length);
			$singlewords[$i]=substr($singlewords[$i],$length);
		}
		debug("last added element:$words[-1]\n");
	}
	
	# debug output
	my $wordcount = @words;	
	for ($i=0 ; $i<$wordcount ; $i++){	
		debug ($words[$i]."\n");
	}
	debug("*****\n");
	
	# build lines of the proper length from list with the found words
	my $result="";
	for ($i=0 ; $i<$wordcount ; $i++){		
		# auxiliary value: value of the line without length restriction
		my $auxvalue; 
		if ($result eq "") {
			$auxvalue=$words[$i];
		} else {
			$auxvalue=$result." ".$words[$i];
		}
		
		# break line at the maximum length
		debug("Zeile an Längengrenze umbrechen:\n");
		if (length($auxvalue)<$length) {
			$result=$auxvalue;
		} elsif (length($auxvalue)==$length) {
			$result=$auxvalue;
			print "$result\n";
			$result="";
		} elsif (length($auxvalue)>$length) {
			print "$result\n";
			$result=$words[$i];
		}
	}
	# display last line
	print "$result\n";
}
