//Considera el siguiente programa:
//i = 1
//sum = 0
//sum = sum + i
//i = i + 1

//La traducción a lenguaje ensamblador del programa anterior es:
// i = 1
@i
M=1
// sum = 0
@sum
M=0
// sum = sum + i
@i
D=M
@sum
M=D+M
// i = i + 1
@i
D=M+1
@i
M=D

//Optimiza esta parte del código para que use solo dos instrucciones:
// i = i + 1
@i
D=M+1
@i
M=D

//Parte Optimizada:
@i
M=M+1