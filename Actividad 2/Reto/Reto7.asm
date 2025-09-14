@10
D=A  
@var
M=D // se guarda 10 en var

@5
D=A
@bis  // se guarda 5 en bis
M=D

@var
D=A
@PUNT 
M=D   // se guarda la direccion de var en PUNT

@PUNT  
A=M
D=M
@bis
M=D    // se guarda el valor de la direccion al que apunta el puntero y lo guarda en bis, 
       // osea apunta a la direccion var, toma ese valor que tiene guardado var en este caso 10 y lo guarda en bis