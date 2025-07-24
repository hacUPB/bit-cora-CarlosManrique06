//Implementa en lenguaje ensamblador:
//if ( (D - 7) == 0) goto a la instrucción en ROM[69]

//La condicion
@7
D=D-A
@69
D;JEQ

//Para comprobar en caso de que se cumpla la condicion
@7
D=A
@7
D=D-A
@69
D;JEQ

