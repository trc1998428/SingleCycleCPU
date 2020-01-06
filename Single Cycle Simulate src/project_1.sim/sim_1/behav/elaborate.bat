@echo off
set xv_path=D:\\vivado\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto 887b625ba7564c6f8c675789b76f9ace -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot CPU_sim_behav xil_defaultlib.CPU_sim xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
