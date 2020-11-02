# Implement twonodes point-to-point network with duplex links between them.
set ns [ new Simulator ]

set tf [ open sample2.tr w ]
$ns trace-all $tf

set nf [ open sample2.nam w ]
$ns namtrace-all $nf

proc finish { } {
global ns nf tf
$ns flush-trace
exec nam sample2.nam &
close $tf
close $nf
exit 0
}

#Create the nodes and Links for traffic
set n1 [$ns node]
set n2 [$ns node]
$n1 color "red"
$n2 color "green"
$n1 label "Sender"
$n2 label "Receiver"
$ns duplex-link $n1 $n2 1Mb 100ms DropTail

# Generate UDP traffic
set udps [new Agent/UDP]
set udpr [new Agent/Null]
$ns attach-agent $n1 $udps
$ns attach-agent $n2 $udpr

#Setup a CBR over a UDP conncetion
set cbr [new Application/Traffic/CBR]
$cbr set packet_size_ 1000
$cbr set interval_ 50ms
$cbr attach-agent $udps
$ns connect $udps $udpr

#Schedule events for the CBR and FTP agents
$ns at 0.0 "$cbr start"

$ns at 1.0 "$cbr stop"
$ns at 4.0 "finish"

$ns run
