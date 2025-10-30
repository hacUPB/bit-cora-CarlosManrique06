//Implementa en ensamblador el siguiente problema. 
//En la posición R0 está almacenada la dirección inicial de una región de memoria. 
//En la posición R1 está almacenado el tamaño de la región de memoria. Almacena un -1 en esa región de memoria.


(LOOP)

@i
D=M
@R1
D=D-M  //Este bloque revisa si i es mayor o igual a R1 para ver si salta a end por la region de R1
@END
D;JGE

@i
D=M
@R0 //Este bloque usa el valor de R0 como direccion que se le suma a i para saber donde ubicar el -1 en la region de memoria
A=M
A=D+A
M=-1

@i
M=M+1
@LOOP //Como i se usa como contador la idea es que sume 1 hasta completar la region de memoria de asignada por R1
0;JMP

(END)
