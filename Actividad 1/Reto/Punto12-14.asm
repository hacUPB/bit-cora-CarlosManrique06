//Punto 12
//Implemente en ensamblador:
//R4 = R1 + R2 + 69

//Implementacion
@R1
D=M
@R2
D=D+M
@69
D=D+A
@R4
M=D

//Punto 13
//Implementa en ensamblador:
//if R0 >= 0 then R1 = 1
//else R1 = –1

//(LOOP)
//goto LOOP
//Implementacion
@R0
D=M
@JUMP
D;JGE
@R1
M=-1
@END
0;JMP
(JUMP)
@R1
M=1
(END)



//Punto 14
//Implementa en ensamblador:
//R4 = RAM[R1]

//Implemetancion

@R1
A=M
D=M
@R4
M=D
