//1. Carga en D el valor 1978.
//2. Guarda en la posición 100 de la RAM el número 69.
//3. Guarda en la posición 200 de la RAM el contenido de la posición 24 de la RAM
//4. Lee lo que hay en la posición 100 de la RAM, resta 15 y guarda el resultado en la posición 100 de la RAM.
//5. Suma el contenido de la posición 0 de la RAM, el contenido de la posición 1 de la RAM y con la constante 69. Guarda el resultado en la posición 2 de la RAM.
//6. Si el valor almacenado en D es igual a 0 salta a la posición 100 de la ROM.
//7. Si el valor almacenado en la posición 100 de la RAM es menor a 100 salta a la posición 20 de la ROM./*
@1978
D=A

@69
D=A
@100
M=D

@24
D=M
@200
M=D

@100
D=M
@15
D=D-A
@100
M=D

@0
D=M
@1
D=D+M
@69
D=D+A
@2
M=D

@100
D;JEQ

@100
D=M
D=D-A
@20
D;JLT

