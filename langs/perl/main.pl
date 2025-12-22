#!/usr/bin/perl
use strict;
use warnings;
use Carp;

my ( $dir, $part ) = @ARGV;
my $solution_path = "./$dir/$part.pl";
my $helpers_path  = "./$dir/helpers.pl";
my $func;

if ( -e $helpers_path ) {
    eval {
        do $helpers_path;
        1;
    } or croak "Could not load helpers file '$helpers_path': $@ $!";
}

eval {
    do $solution_path;
    $func = \&{$part};
    1;
} or croak "Could not load solution script '$solution_path': $@ $!";

sub main {
    my @input_data = <STDIN>;
    chomp @input_data;
    print $func->(@input_data);
}

main();
