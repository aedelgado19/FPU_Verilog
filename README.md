To run this code, clone this repo and run these commands inside the directory they are in:

setup-synopsys
vcs -debug_access+all -kdb add.v sub.v mul.v div.v fpu.v fpu_tb.v
./simv -no_save
