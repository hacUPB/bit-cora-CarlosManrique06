    @i 
    M=1
    @sum
    M=0

  (LOOP)  

    @i
    D=M
    @101
    D=D-A
    
    @END
    D;JGE 

    @sum
    D=M
    @i
    D=D+M
    @sum
    M=D

    @i
    M=M+1  

    @LOOP
    0;JMP     

    (END)