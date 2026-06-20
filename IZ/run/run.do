#####################################################
# library work create
vlib work
#####################################################
# add libraryes

#set path C:/std_lib_10_6_viv_19_1
#vmap secureip     $path/secureip
#vmap simprims_ver $path/simprims_ver
#vmap unisims_ver  $path/unisims_ver
#vmap unimacro_ver $path/unimacro_ver
#vmap xpm          $path/xpm

# compile glbl file 
#vlog $path/glbl.v

#####################################################
# add and compile source project files

vlog ../func_15_reg.sv
vlog ../func_15.sv
vlog ../tb_func_15.sv
#vlog ../dat_files/*.mem

#####################################################
# use top level testbench

vsim -c work.tb_func_15

# add signals on waveform diagram
# add wave -radix decimal -group TOP sim:/testbench1/sillyfunction/*
add wave *
#####################################################
# run simulation
#run 100ns
run -a 
