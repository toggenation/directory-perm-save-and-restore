#!/usr/bin/perl

#use strict;

# default
my $store_file = 'stored_perms.txt';

$store_file = $ARGV[1] if ( defined $ARGV[1] );


if ( ! defined $ARGV[0] ){  usage()};

store($store_file) if ($ARGV[0] eq 'store');

restore($store_file) if ($ARGV[0] eq 'restore');

sub usage(){
	print "Saves directory names and permissions to '$store_file'\n";
	print "Restores permissions from '$store_file'\n";
	print $0 . ' [store|restore] <store_file>' . "\n";
	exit;
}


sub restore($store_file){
	print "Running RESTORE\n";

	my $store_file = shift;

	open(FH, "<", $store_file) or die $!;

	while(<FH>){
		chomp;
		( $dirname, $perms, $uid, $gid) = split(/:/);

		print "Directory $dirname perms $perms\n";

		chmod oct($perms), $dirname;
		chown $uid, $gid, $dirname;

	}

	close(FH);

}

sub store(){

	my $store_file = shift;

	print "Running STORE to $store_file\n";
	my @dirs = `find .`;

	open(FH, '>', $store_file) or die $!;


	foreach(@dirs){
		chomp;
	#	print "$_" . "\n";
		my @stats = stat($_); 
		my $filemode = $stats[2];
		my $uid = $stats[4];
		my $gid = $stats[5];
		printf FH "$_:%04o:$uid:$gid\n",  $filemode & 07777;

	}

	close(FH);
	print "Stored to $store_file\n";
}
