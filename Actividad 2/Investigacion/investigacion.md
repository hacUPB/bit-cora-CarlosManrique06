### Actividad 1

- ¿Qué es la entrada-salida mapeada a memoria?

R/ Permite acceder a dispositivos de entrada y salida como si fueran memoria,mapeando los puertos de entrada y salida a direcciones de memoria específicas donde la pantalla se va llenando por 256 filas y 512 columnas, en este caso la entrada es el teclado y la salida es la pantalla. Cada tecla tiene su propio código que se guardan al presionar en la dirección del teclado que es la 24576, todo el proceso con el fin de obtener datos que da el usuario y mostrarle datos al usuario a traves de la salida y manipulacion de los bits.

- ¿Cómo se implementa en la plataforma Hack?

R/ La pantalla tiene un mapeo y un espacio desginado en la memoria que puede ser modificado por el código para cambiar y refrescar la salida que es la pantalla del proceso que quisieramos mostrar en ella. El mapeo de pantalla es de 256 ancho por 512 de largo de pixeles. Dependiendo del bit que quiera modificar tengo que encontrar la dirección de la memoria enla que esta ese bit, en ese grupo modificar ese bit y luego regresarlo a la memoria RAM, entonces siempre cuando haga un cambio estoy manipulando 16 bits en 0 o 1.

- Inventa un programa que haga uso de la entrada-salida mapeada a memoria.

R/ Lo que hice es que en la dirección de memoria 1000 se le sume 100 cada vez que se presione o se mantenga la tecla d y se guarde en esa misma dirección 1000.

- Investiga el funcionamiento del programa con el simulador.

![alt text](<Actividad 1_ Programa.jpg>)

### Actividad 3

- Vas a implementar y simular una modificación al reto 20 de la unidad anterior. Si se presiona la letra “d” muestras la imagen que diseñaste en el reto 18. Si no se presiona ninguna tecla, borrarás la imagen.

R/ Para hacer que con la letra de muestre la imagen puse la etiqueta DRAW para realizar un salto si se cumplia la condicion de que el valor en la ram del teclado sea 100 que es el código de la D y restarlo con 100 para comprobar la condicion y así salte a DRAW. Para borrar la imagen lo que hice fue otra condición para que realice un salto a la etiqueta CLEAR cuando el valor en la RAM del teclado sea 0 y cuando termine vuelva a preguntar la tecla. Para realizar el barrido fue poner una variable i que iniciara en la dirección 16384 para desde esa posicion poner 0 e ira aumentando despues de poner un 0 hasta la dirección 24576 que es la del teclado y para salir de ese loop resto lo que hay actualmente en i lo resto con 24576 para saber si continua el loop o salta al inicio de la operacion para pedir la tecla.

### Actividad 4

Ahora realizarás una nueva variación al programa de la actividad anterior. Si se presiona la letra “d” muestras la imagen que diseñaste en el reto 18. Solo si se presiona la letra “e” borrarás la imagen que se muestra en pantalla.

R/ Fue parecio al anterior, pero el cambio que hice fue que enves que se pregunte si en la dirección del teclado es 0, sino 101 que es el codigo "e" y guardo ese valor en d y lo resto con 101 para corroborar que se presiono e y que realice el salto a CLEAR.
