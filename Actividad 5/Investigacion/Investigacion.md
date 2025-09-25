## Sesion 1

- ¿Qué es un objeto desde la perspectiva de la memoria?

R/ Un objeto en memoria es un bloque de datos que corresponde a los atributos de la clase donde cada atributo tiene cierto tamaño de bytes.

- ¿Cómo influyen los atributos y métodos en el tamaño y estructura del objeto?

R/ los atributos determinan directamente el tamaño del objeto, los métodos no afectan el tamaño, ya que son compartidos y se guardan en la memoria de texto, las variables estáticas tampoco aumentan el tamaño cada instancia, ya que comparten los datos y existen una vez y las variables dinámicas hacen que el objeto guarde punteros y la memoria se gestiona en el heap.

- Conclusión: resumir los hallazgos y cómo esto impacta el diseño de clases

R/ Entender cómo se organizan los objetos en memoria permite diseñar clases más eficientes, ya que puedes ver como gestionar el uso de la memoria en los objetos creados. Si un objeto necesita contener muchos datos compartidos, conviene usar static. Si un objeto necesita datos que cambian de tamaño, conviene usar asignación dinámica, pero liberando la memoria adecuadamente cuando se necesite.



## Sesion 2


Vtables: Cuando una clase tiene al menos un método virtual, el compilador agrega un puntero oculto dentro de cada objeto  como vptr. Ese puntero apunta a una vtable: una tabla con direcciones de funciones. La vtable se almacena en una zona 
estática del programa, usualmente junto al código.

Permite que, usando un puntero o referencia a Base, el programa decida en tiempo de ejecución cuál versión de display() llamar.


Diferencia entre punteros a funciones y punteros a métodos

los punteros a funciones son direcciones simples a funciones globales o estáticas que se pueden guardar directamente en un objeto y Ocupan espacio en la instancia.

Punteros a métodos miembro:

Tienen más complejidad porque deben incluir el contexto del objeto (a qué instancia se aplica).

Su tamaño puede ser mayor que un simple puntero.

No están relacionados con la vtable: son una forma manual de enlazar un método.


1. Reflexión individual:


- ¿Dónde residen los datos y métodos de una clase en la memoria?

R/ Datos: stack o heap, según cómo se instancie.

   Métodos: sección de código del programa, en los textos.

   Vtable: sección estática.

- ¿Cómo interactúan las diferentes partes en tiempo de ejecución?

R/ Los métodos se buscan en la vtable si son virtuales y Los datos se acceden directamente desde el bloque de memoria del objeto.


- Conclusión: cómo esta comprensión afecta el diseño de sistemas.

R/ vtables y punteros ayudan,  a ver por qué el polimorfismo tienecosto en memoria y ejecucion.
Saber dónde residen los datos y métodos permite diseñar clases más eficientes, pudiendo reducir el codigo cuando no se requiere polimorfismo.



