#!/usr/bin/perl -w

use strict;


# default
my $storeFile = 'stored_perms.txt';

sub usage {
    my $fileName = shift;
    print "Saves directory names and permissions to '$fileName'\n";
    print "Restores permissions from '$fileName'\n";
    print $0 . ' [store|restore] <storeFile>' . "\n";
    exit;
}

sub store {
    my $storeFile = shift;

    print "Running STORE to $storeFile\n";
    my @dirs = `find .`;

    open( FH, '>', $storeFile ) or die $!;

    foreach (@dirs) {
        chomp;

        #	print "$_" . "\n";
        my @stats    = stat($_);
        my $filemode = $stats[2];
        my $uid      = $stats[4];
        my $gid      = $stats[5];
        printf FH "$_:%04o:$uid:$gid\n", $filemode & 07777;
    }

    close(FH);

    print "Stored to $storeFile\n";
}

sub restore {
    print "Running RESTORE\n";

    my $storeFile = shift;

    -f $storeFile or die("$storeFile does not exist!");

    open( FH, "<", $storeFile ) or die $!;

    while (<FH>) {
        chomp;
        my ( $fileOrDirectory, $perms, $uid, $gid ) = split(/:/);

        print
            "Setting $fileOrDirectory perms to $perms UID,GID to $uid:$gid\n";

        chmod oct($perms), $fileOrDirectory;
        chown $uid, $gid, $fileOrDirectory;

    }

    close(FH);
}

$storeFile = $ARGV[1] if ( defined $ARGV[1] );

if ( !defined $ARGV[0] ) { usage($storeFile) }

my $command = $ARGV[0];
if    ( $command eq 'store' )   { store($storeFile) }
elsif ( $command eq 'restore' ) { restore($storeFile) }
else                              { usage($storeFile) }

