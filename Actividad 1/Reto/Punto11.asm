//11. Considera el siguiente programa:
    //i = 1000
    //LOOP:
    //if (i == 0) goto CONT
    //i = i - 1
    //goto LOOP
    //CONT:
   
    
    //La traducción a lenguaje ensamblador del programa anterior es:
    
    
    // i = 1000
    @1000
    D=A
    @i
    M=D
    (LOOP)
    // if (i == 0) goto CONT
    @i
    D=M
    @CONT
    D;JEQ
    // i = i - 1
    @i
    M=M-1 //le resta 1 al valor en M en la variable i
    // goto LOOP
    @LOOP
    0;JMP
    (CONT)
    
  