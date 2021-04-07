#!/usr/bin/perl
#use strict;
use warnings;
use Time::HiRes qw(usleep nanosleep);
use diagnostics;

$| = 1; # Disable output buffering


my $BACK_SPACE = chr(0x08);
my $padRight;
my $padLeft;
my $word;
my $paddingLength;
my $totalLength;
my $shouldMoveRight = True;
my $wordRight = "-->";
my $wordLeft = "<--";

# get inputs
if (scalar(@ARGV) > 0) {
	if (lc $ARGV[0] eq "help") {
		print "test [<first symbol>] [<second symbol>]\n";
		exit;
	}
	$wordRight  = $ARGV[0];
	$wordLeft = $ARGV[0];
}
if (scalar(@ARGV) > 1) {
	$wordLeft = $ARGV[1];
	if (length($wordLeft) != length($wordRight)) {
		print "Bad usage: Inputs must have same length\n";
		exit;
	}
}

# initialize lengths
$paddingLength = 50 - length($wordRight);
$totalLength = $paddingLength + length($wordRight);

main();


sub main {
	# my $pid = shift;
	my $parentPid = $$;
	my $isParent = fork();

	# child waits for input to kill parent
	if (!$isParent) {
		# $| = 1;
		<STDIN>;
		kill '-KILL', $parentPid;
		exit;
	}

	print "Press any key to stop\n";
	# parent enters lopp
	while ($isParent) {
		printToTerm();
	}
}


sub printToTerm {
	for (my $j=0; $j <= $paddingLength; $j++) {
		if ($shouldMoveRight) {
			$word = $wordRight;
			$padLeft = $j;
			$padRight = $paddingLength - $j;
		} else {
			$padLeft =  $paddingLength - $j;
			$padRight = $j;
			$word = $wordLeft;
		}
		printPad ($padLeft);
		print "${word}";
		printPad ($padRight);
		# sleep for affect
		usleep(60000);
		clearLine();
	}
	$shouldMoveRight = !$shouldMoveRight;
}

sub clearLine {
	for (1..$totalLength) {
		print $BACK_SPACE 
	}
}

sub printPad {
	my $padLength = shift;
	for (my $pad = 0; $pad < $padLength; $pad++) {
		print " "; 
	} 
}