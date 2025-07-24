//Implementa en lenguaje ensamblador el siguiente programa:
//int[] arr = new int[10];
//int sum = 0;
//for (int j = 0; j < 10; j++) {
 //   sum = sum + arr[j]; }


(LOOP)

@j
D=M
@10
D=D-A //Bucle si j es mayor o igual a 10 para saltar a END
@END
D;JGE


@j
D=M
@arr
A=M   //Poner el valor del array en D para poder realizar la suma con sum
A=D+A
D=M
@sum // sumar sum + el array[j]
M=D+M

@j
M=M+1 //sumar 1 a j para el contador
@LOOP
0;JMP

(END)
