onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/a
add wave -noupdate /tb/b
add wave -noupdate /tb/sync_rst
add wave -noupdate /tb/clk
add wave -noupdate /tb/rst
add wave -noupdate /tb/pos
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {348097826 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits fs
update
WaveRestoreZoom {0 fs} {1050 ns}
