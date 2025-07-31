### Actividad 1

- ¿Qué es la entrada-salida mapeada a memoria?

R/ Permite acceder a dispositivos de entrada y salida como si fueran memoria,mapeando los puertos de entrada y salida a direcciones de memoria específicas donde la pantalla se va llenando por 256 filas y 512 columnas, en este caso la entrada es el teclado y la salida es la pantalla. Cada tecla tiene su propio código que se guardan al presionar en la dirección del teclado que es la 24576, todo el proceso con el fin de obtener datos que da el usuario y mostrarle datos al usuario a traves de la salida y manipulacion de los bits.

- ¿Cómo se implementa en la plataforma Hack?
R/ La pantalla tiene un mapeo y un espacio desginado en la memoria que puede ser modificado por el código para cambiar y refrescar la salida que es la pantalla del proceso que quisieramos mostrar en ella. El mapeo de pantalla es de 256 ancho por 512 de largo de pixeles. Dependiendo del bit que quiera modificar tengo que encontrar la dirección de la memoria enla que esta ese bit, en ese grupo modificar ese bit y luego regresarlo a la memoria RAM, entonces siempre cuando haga un cambio estoy manipulando 16 bits en 0 o 1.

- Inventa un programa que haga uso de la entrada-salida mapeada a memoria.


- Investiga el funcionamiento del programa con el simulador.

### Actividad 2
 - Vas a revisar de nuevo el reto 20 de la unidad anterior. Asegúrate de entenderlo, simularlo y experimentar con él antes de continuar con el siguiente reto.

### Actividad 3

- Vas a implementar y simular una modificación al reto 20 de la unidad anterior. Si se presiona la letra “d” muestras la imagen que diseñaste en el reto 18. Si no se presiona ninguna tecla, borrarás la imagen.

R/