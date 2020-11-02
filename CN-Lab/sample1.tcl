set ns [new Simulator]

set tf [open sample1.tr w]
$ns trace-all $tf

set nf [open sample1.nam w]
$ns namtrace-all $nf

set n0 [$ns node]
set n1 [$ns node]
$n0 color "red"
$n1 color "green"
$n0 label "sender"
$n1 label "receiver"

$ns duplex-link $n0 $n1 100Mb 300ms DropTail

proc finish {} {
global ns nf tf
$ns flush-trace
exec nam sample1.nam &
close $tf
close $nf 
exit 0
}

$ns at 10.0 "finish"
$ns run
