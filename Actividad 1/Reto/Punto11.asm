//11. Considera el siguiente programa:
    //i = 1000
    //LOOP:
    //if (i == 0) goto CONT
    //i = i - 1
    //goto LOOP
    //CONT: 
    
    //La traducción a lenguaje ensamblador del programa anterior es:
    
    
    
    @1000
    D=A  // inicializa  en i el valor 1000
    @i
    M=D
    (LOOP)
    
    @i
    D=M // si se cumple la condicion i== salta a cont
    @CONT
    D;JEQ
    
    @i
    M=M-1 //le resta 1 al valor en M en la variable i
    
    @LOOP
    0;JMP
    (CONT)
