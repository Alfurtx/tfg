# Problemas u otras cosas que han ido ocurriendo

## Problema mostrando por pantalla Hello World

Al tratar de lanzar el ejemplo de Hola Mundo provisto por CVA6 falla al no detectar  
la herramienta de Verilator, aunque esta fue instalada junto a Spike y esa si fue  
detectada. Verilator parece estar instalada en /tfg/cva6/tools/verilator-v5.008/bin/verilator .  

Solucion intento #1:

Ya que el PATH si que tiene esa direccion pero con otro nombre. Voy a  
intentar cambiar el nombre de la carpeta. Aparentemente parece funcionar, pero ahora da otro error.

"ERROR return code: True/2, cmd:make veri-testharness target=cv32a60x variant=rv32imac_zba_zbb_zbs_zbc_zicsr_zifencei elf=/tfg/cva6/verif/sim/out_2024-09-17/directed_c_tests/hello_world.o path_var=/tfg/cva6/ tool_path=/tfg/cva6/tools/spike/bin isscomp_opts="" issrun_opts="+debug_disable=1 +ntb_random_seed=1" isspostrun_opts="0x0000000080000000" log=/tfg/cva6/verif/sim/out_2024-09-17/veri-testharness_sim/hello_world.cv32a60x.log &> /tfg/cva6/verif/sim/out_2024-09-17/veri-testharness_sim/hello_world.cv32a60x.log.iss "  

Aunque creo que el verdadero codigo de error es ese True/2 .  
Acabo de descubrir que este error ya apareció [antes](https://github.com/openhwgroup/cva6/issues/2462)

Solucion intento #2:

Cambiar el nombre del directorio no funcionó ya que exite otro script a la hora  
de realizar la simulacion de hello-world que tiene hardcoded el path previo de  
verilator-v5.008, diferiendo de el path que setup-env.sh realiza. Por lo tanto  
voy a cambiar el script para ver si acaba funcionando.o

Aparentemente funciona, según todos los logs funciona. Pero no hay ningun lugar  
donde se guarde la salida estandar o algo con el Hello World! de ejemplo asi que  
me esta haciendo dudar respecto a si el test lo unico que hace es compilar el
programa pero no ejecutarlo. De todas maneras, supuestamante funciona.

Resumen: modificar el script en .../cva6/verif/sim/setup-env.sh, en concreto,  
cambiar el verilator install dir a "$ROOT_PROJECT"/tools/verilator-v5.008 (o el  
que sea que te haya instalado)

Conclusion: según los propios desarrolladores de CVA6, el print a pantalla ya no  
esta [soportado](https://github.com/openhwgroup/cva6/issues/2426)

## Problema simular saxpy

Puede que no se puedan ver los resultados de la ejecucion por pantalla con un
printf, pero si que se puede observar la traza del programa que se ha ejecutado.
Es asi que decidí cambiar el codigo de hello-world para que ahora ejecutase un
saxpy simple. Y como supuse, la traza del programa y tal salio bien. El problema
de la traza es que esta en ensamblador (y no precisamente del legible), asi que
es complicado observar si se ejecuto todo correctamente.

La unica solucion que se me ocurrio para resolver esto es buscar en la traza
instrucciones como 'mul' y ver si encuentro el patron repetitivo del bucle. Y
voilà, lo encontré. No deberia de ser dificil de replicar.
