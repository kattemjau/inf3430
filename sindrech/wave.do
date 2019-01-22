onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/refclk
add wave -noupdate /tb/sync_rst
add wave -noupdate /tb/sp
add wave -noupdate /tb/a
add wave -noupdate /tb/b
add wave -noupdate /tb/force_cw
add wave -noupdate /tb/force_ccw
add wave -noupdate /tb/arst
add wave -noupdate /tb/abcdefgdec_n
add wave -noupdate /tb/a_n
add wave -noupdate /tb/motor_ccw
add wave -noupdate /tb/motor_cw
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2024203822 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 38
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
WaveRestoreZoom {0 fs} {2100 ns}
