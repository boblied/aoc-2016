#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# Advent of Code 2016 Day 01 Part 1
#=============================================================================

use v5.40;
use FindBin qw($Bin); use lib "$FindBin::Bin/../../lib"; use AOC;
AOC::setup;

my @directions;

while (<>)
{
    chomp;
    @directions = split(/, */)
}

my %Face = ( NORTH => { L => "WEST",  R => "EAST" },
             SOUTH => { L => "EAST",  R => "WEST" },
             EAST  => { L => "NORTH", R => "SOUTH" },
             WEST  => { L => "SOUTH", R => "NORTH" } );

my ($X,$Y) = (0,0);

my $face = "NORTH";
while ( my $move = shift @directions )
{
    my ($turn, $block) = $move =~ m/^(.)(.*)/;
    $logger->debug("Facing $face, move $turn $block from ($X,$Y)");
    $face = $Face{$face}{$turn};
    if ( $face eq "NORTH" )
    {
        $Y += $block;
    }
    elsif ( $face eq "SOUTH" )
    {
        $Y -= $block;
    }
    elsif ( $face eq "EAST" )
    {
        $X += $block;
    }
    elsif ( $face eq "WEST" )
    {
        $X -= $block;
    }
    $logger->debug("Now facing $face at ($X,$Y)");
}

say abs($X) + abs($Y);
