onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_seg7ctrl/G1/mclk
add wave -noupdate /tb_seg7ctrl/G1/reset
add wave -noupdate /tb_seg7ctrl/G1/d0
add wave -noupdate /tb_seg7ctrl/G1/d1
add wave -noupdate /tb_seg7ctrl/G1/d2
add wave -noupdate /tb_seg7ctrl/G1/d3
add wave -noupdate /tb_seg7ctrl/G1/dec
add wave -noupdate -expand /tb_seg7ctrl/G1/abcdefgdec_n
add wave -noupdate -expand /tb_seg7ctrl/G1/a_n
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {35000000 fs} 0}
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
WaveRestoreZoom {0 fs} {105 ns}
