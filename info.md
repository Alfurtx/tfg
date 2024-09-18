# Problemas u otras cosas que han ido ocurriendo

Al tratar de lanzar el ejemplo de Hola Mundo provisto por CVA6 falla al no detectar  
la herramienta de Verilator, aunque esta fue instalada junto a Spike y esa si fue  
detectada. Verilator parece estar instalada en /tfg/cva6/tools/verilator-v5.008/bin/verilator .  

Solucion intento #1:

Ya que el PATH si que tiene esa direccion pero con otro nombre. Voy a  
intentar cambiar el nombre de la carpeta. Aparentemente parece funcionar, pero ahora da otro error.

"ERROR return code: True/2, cmd:make veri-testharness target=cv32a60x variant=rv32imac_zba_zbb_zbs_zbc_zicsr_zifencei elf=/tfg/cva6/verif/sim/out_2024-09-17/directed_c_tests/hello_world.o path_var=/tfg/cva6/ tool_path=/tfg/cva6/tools/spike/bin isscomp_opts="" issrun_opts="+debug_disable=1 +ntb_random_seed=1" isspostrun_opts="0x0000000080000000" log=/tfg/cva6/verif/sim/out_2024-09-17/veri-testharness_sim/hello_world.cv32a60x.log &> /tfg/cva6/verif/sim/out_2024-09-17/veri-testharness_sim/hello_world.cv32a60x.log.iss "  

Aunque creo que el verdadero codigo de error es ese True/2 .  
Acabo de descubrir que este error ya apareció [antes](https://github.com/openhwgroup/cva6/issues/2462)
