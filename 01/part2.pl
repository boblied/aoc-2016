#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# Advent of Code 2016 Day 01 Part 2
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

my $ORIGIN = 200;
my ($X,$Y) = ($ORIGIN,$ORIGIN);

my @Visit;
for my $vertical ( 0 .. 2*$ORIGIN )
{
    push @Visit, [ (false) x (2*$ORIGIN) ];
}
$Visit[$ORIGIN][$ORIGIN] = true;

my $face = "NORTH";
MOVE: while ( my $move = shift @directions )
{
    my ($turn, $block) = $move =~ m/^(.)(.*)/;
    $logger->debug("Facing $face, move $turn $block from ($X,$Y)");
    $face = $Face{$face}{$turn};
    if ( $face eq "NORTH" )
    {
        for ( $Y+1 .. $Y+$block )
        {
            if ( $Visit[$X][$_] ) {
                $logger->debug("Cross at ($X,$_)");
                $Y = $_; last MOVE;
            }
            $Visit[$X][$_] = true;
        }
        $Y += $block;
    }
    elsif ( $face eq "SOUTH" )
    {
        for ( my $y = $Y-1; $y >= $Y-$block; $y-- )
        {
            if ( $Visit[$X][$y] ) {
                $Y = $y; last MOVE;
                $logger->debug("Cross at ($X,$_)");
            }
            $Visit[$X][$y] = true;
        }
        $Y -= $block;
    }
    elsif ( $face eq "EAST" )
    {
        for ( $X+1 .. $X+$block )
        {
            if ( $Visit[$_][$Y] ) {
                $X = $_; last MOVE;
                $logger->debug("Cross at ($X,$_)");
            }
            $Visit[$_][$Y] = true;
        }
        $X += $block;
    }
    elsif ( $face eq "WEST" )
    {
        for ( my $x = $X-1; $x >= $X-$block ; $x-- )
        {
            if ( $Visit[$x][$Y] ) {
                $X = $x; last MOVE;
                $logger->debug("Cross at ($X,$_)");
            }
            $Visit[$x][$Y] = true;
        }
        $X -= $block;
    }
    $logger->debug("Now facing $face at ($X,$Y)");
}

say abs($X-$ORIGIN) + abs($Y-$ORIGIN);
