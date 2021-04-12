#Load trajectory

set inDir INDIR
set inPsf INPSF
set inTraj INTRAJ
set outN OUTNAME

#load trajectory
mol new $inDir$inPsf
mol addfile $inTraj waitfor all
set molID [molinfo top get id]
set Nframes [expr {[molinfo $molID get numframes] - 1}]

set fileOutN3 $outN.c3tail.dat
set fileOutN2 $outN.c2tail.dat
set fout3 [open $fileOutN3 w]
set fout2 [open $fileOutN2 w]

source order_param.tcl
puts $fout2 "frame(1ns) output (tail index; order parameter at each frame)"
puts $fout3 "frame(1ns) output (tail index; order parameter at each frame)"


for {set l 0} {$l <= $Nframes} {incr l} {
  #c2 tail
  orderparam-c2 arr2 $l
  puts -nonewline $fout2 "$l "
  foreach key [lsort -integer [array names arr2]] {
    puts -nonewline $fout2 "[list $key $arr2($key)] "
  }
  if {$l < $Nframes} {
    puts -nonewline $fout2 "\n"
  }

  #c3 tail
  orderparam-c3 arr3 $l
  puts -nonewline $fout3 "$l "
  foreach key [lsort -integer [array names arr3]] {
    puts -nonewline $fout3 "[list $key $arr3($key)] "
  }
  if {$l < $Nframes} {
    puts -nonewline $fout3 "\n"
  }
}

close $fout2
close $fout3
