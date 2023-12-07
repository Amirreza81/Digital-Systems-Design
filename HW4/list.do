onerror {resume}
add list -width 14 /TestBench/s
add list -width 14 /TestBench/v
add list -width 14 /TestBench/z
add list -width 14 /TestBench/c
add list -width 18 /TestBench/clock
add list -width 19 /TestBench/result
add list -width 17 /TestBench/data
add list /TestBench/control
configure list -usestrobe 0
configure list -strobestart {0 ns} -strobeperiod {0 ns}
configure list -usesignaltrigger 1
configure list -delta all
configure list -signalnamewidth 0
configure list -datasetprefix 0
configure list -namelimit 5
