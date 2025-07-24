@24576    // codigo del teclado 
D=M
@100      // Este es el codigo de la tecla d
D=D-A
@DIBUJA
D;JEQ     // Si D == 0  salta a dibujar

(END)
@END
0;JMP     // Bucle infinito

(DIBUJA)
      //Aca dibujaria todo el bitmap que cree
@END
0;JMP
