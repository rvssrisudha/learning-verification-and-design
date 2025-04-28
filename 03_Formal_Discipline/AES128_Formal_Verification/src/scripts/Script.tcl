#set up paths
set ROOT_PATH [pwd]
set RTL_PATH ${ROOT_PATH}/design
set PROP_PATH ${ROOT_PATH}/properties

set top aes_128

# Analyze design under verification files
analyze -v2k \
  ${RTL_PATH}/aes_128.v \
  ${RTL_PATH}/round.v \
  ${RTL_PATH}/table.v

# Analyze property files
analyze -sva \
  ${PROP_PATH}/binding_aes_128.sv \
  ${PROP_PATH}/assertions_aes_128.sv 
  
# Elaborate design and properties
elaborate -top ${top}


# Set up Clock and Reset
clock clk
reset -none


get_design_info

# Prove properties

set_max_trace_length 10
prove -all

set_max_trace_length 50
set_prove_per_property_time_limit 30s
set_engine_mode {K I N} 
prove -all

# Report proof results
report

