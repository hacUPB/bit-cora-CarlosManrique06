
## Actividad 1

1. **Entiende la aplicación**: comienza explorando detenidamente cómo funciona el programa. Usa un un modelo del lenguaje como ChatGPT y el depurador para que verifiques las explicaciones que te propone ChatGPT. Puedes escribir el prompt: quiere entender de manera muy detallada el siguiente programa escrito en C++ y el openframeworks. Luego le das el código. Ve preguntando lo que no entiendas. recuerda ir usando al mismo tiempo el depurador de visual studio.



2. **Realiza evaluaciones formativas**. Dile a ChatGPT que te genere preguntas para verificar si entiendes cómo funciona el programa. Trata de verificar tus hipótesis usando el depurador y luego con las conclusiones del experimento responde la pregunta de ChatGPT. Continúa con este proceso hasta que estés seguro de que entiendes cómo funciona el programa.



3. ¿Qué es una lista enlazada y en qué se diferencia de un arreglo en cuanto a la forma en que los elementos están almacenados en la memoria?

R/ Es una estructura de datos en la que los elementos se almacenan en nodos separados, y cada nodo contiene un valor y un enlace al siguiente nodo. Se diferencia de un arreglo en que los elementos no están continuos en la memoria, sino que están dispersos y se acceden a través de enlaces, ya que en un arreglo se guarda una después del otro.   


4. Al observar el código de una lista enlazada en C++, ¿Cómo crees que se vinculan los nodos entre sí? ¿Qué estructura se utiliza para lograr esta conexión?

R/ Los nodos se vinculan entre sí a través de punteros, que apuntan al siguiente nodo en la lista. Se utiliza la estructura de un nodo que contiene un valor y un puntero al siguiente nodo.


5. ¿Cómo se gestiona la memoria en una lista enlazada? Investiga cómo se crea y se destruye un nodo en memoria utilizando el operador new y delete en C++.

R/ La memoria en una lista enlazada se gestiona en la memoria heap y con el new se crea y  para la destrucción del nodo se usa el delete. Al crear un nodo, se reserva memoria con new, y al destruirlo, se libera esa memoria utilizando delete. En el programa se recorre un for para eliminar los nodos de la lista enlazada.


6. Considerando la estructura de una lista enlazada, ¿qué ventajas ofrece en comparación con un arreglo cuando se trata de insertar o eliminar elementos en posiciones intermedias?

R/  La ventaja es que tu puedes seleccionar el nodo que apunta a ese intermedio y asi inserta o eliminar el elemento en esa direccion, en cambio con el arreglo tienes que mover los elementos o recorrer todo el arreglo hasta esa mitad, ya que los elementos se ponen de manera continua.


7. En el código presentado, ¿Cómo se asegura que no haya fugas de memoria? ¿Qué papel juega el destructor en la clase LinkedList?

R/ Con el clear, ya que como los elementos se crean en el heap con el clear nos aseguramos de borrar los elementos en caso de que lo necesitemos y en el destructor llamamos ese clear.


8. ¿Qué sucede en la memoria cuando se invoca el método clear() en una lista enlazada? Explica paso a paso cómo se liberan los recursos.

R/ el método clear, recorre la lista desde el primer nodo que es head hasta el último, y en cada iteración guarda una referencia al siguiente nodo , elimina el nodo actual con delete para liberar la memoria que ocupaba y luego avanza al siguiente nodo usando ese puntero guardado. De esta manera cada nodo creado se libera y se ponen en null para evitar problemas


9. Explica cómo cambia la estructura en memoria de una lista enlazada al agregar un nuevo nodo al final de la lista. ¿Cómo afecta esto al rendimiento de la lista enlazada?

R/ Como normalmente el último nodo está en null cuando ya tiene un final, al agregar otro nodo ese nodo que era el final en su puntero tiene que a puntar a ese nuevo nodo que se agrego al final y ese nodo final estaría apuntando a null.

10. Analiza una situación en la que utilizar una lista enlazada sería más ventajoso que utilizar un arreglo. Justifica tu respuesta considerando la gestión de memoria y las operaciones de inserción y eliminación.

R/ Como la lista enlazada no es continua la puedes utilizar en un programa que necesites eliminar muchos componentes a la vez y en pos especificas y principalmente si esas pos especificas están en la parte intermedia, ya que de esta manera puedes liberar la memoria eficientemente gracias a los punteros.

11. Después de estudiar el manejo de memoria en listas enlazadas, ¿Cómo aplicarías este conocimiento para diseñar una estructura de datos personalizada para una aplicación creativa? ¿Qué aspectos considerarías para asegurar la eficiencia y evitar fugas de memoria?

R/ Tener métodos que se encarguen de liberar la memoria de esas pos especificas o franjas medias usando el destructor para corroborar es liberacion y siempre teniendo head and tail para en base a esto usar los nodos.

12. Reflexiona sobre las diferencias en la gestión de memoria entre C++ y un lenguaje con recolección de basura automática como C#. ¿Qué ventajas y desafíos encuentras en la gestión explícita de memoria en C++ al trabajar con estructuras de datos?

R/La gran diferencia es asegurarnos de que este funcionando correctamente la gestion de memoria, ya que como en C++ nosotros decidimos que queremos borrar con delete y cuando no, así que el mayor desafio es darnos cuenta que no haya fallos en el flujo para evitar fugas de memoria para que el programa pueda correr limpiamente.

13. Imagina que estás optimizando una pieza de arte generativo que usa listas enlazadas para representar elementos en movimiento. ¿Qué consideraciones tomarías en cuenta para garantizar que la gestión de la memoria sea eficiente y que no ocurran fugas de memoria?

R/Que si voy a manejar direcciones especificas que esten principalmente en mitades para que el uso de listas enlazadas sea eficiente y llamar al destructor cuando lo necesite para evitar fugas de memoria o problemas que puedan ocurrir sin darme cuenta.

14. **Pruebas:** pregunta a ChatGPT cómo podrías probar las partes del programa y el programa completo. Luego realiza las pruebas y verifica si los resultados coinciden con tus expectativas.


## Actividad 2

Vas a reportar en tu bitácora de aprendizaje:

1. **Entendiendo la aplicación**: comienza explorando detenidamente cómo funciona el programa. Usa un un modelo del lenguaje como ChatGPT y el depurador para que verifiques las explicaciones que te propone ChatGPT. Puedes escribir el prompt: quiere entender de manera muy detallada el siguiente programa escrito en C++ y el openframeworks. Luego le das el código. Ve preguntando lo que no entiendas. recuerda ir usando al mismo tiempo el depurador de visual studio.
2. **Realiza evaluaciones formativas**. Dile a ChatGPT que te genere preguntas para verificar si entiendes cómo funciona el programa. Trata de verificar tus hipótesis usando el depurador y luego con las conclusiones del experimento responde la pregunta de ChatGPT. Continúa con este proceso hasta que estés seguro de que entiendes cómo funciona el programa.
3. **Pruebas:** pregunta a ChatGPT cómo podrías probar las partes del programa y el programa completo. Luego realiza las pruebas y verifica si los resultados coinciden con tus expectativas.

Preguntas de reflexión para el stack:

1. ¿Cómo se gestiona la memoria en una implementación manual de un stack en C++? Reflexiona sobre cómo el uso de new y delete en la creación y destrucción de nodos afecta el rendimiento y la seguridad de tu programa.

R/ En una implementación manual del stack cada nodo se crea con new  y se elimina con delete cuando para eliminarlo de la memoria,pero tienes que estar atento a que si se borren o sino pueden ocurrir las fugas de memoria y reducir el rendimiento del programa, lo bueno es que permite hacer ajustes manualmente, pero toca tener cuidado.

2. ¿Por qué es importante liberar la memoria cuando se desapila un nodo en un stack? Considera las consecuencias de no liberar memoria en términos de fugas de memoria y cómo esto puede impactar aplicaciones de largo tiempo de ejecución.

R/ Liberar memoria al desapilar evita fugas que si se  acumulan, consumen RAM y bajan el rendimiento del programa bajando los fps hasta causar crashes en el programa durante  largas ejecuciones.

3. ¿Qué diferencias existen entre usar un stack de la STL (std::stack) y crear un stack manualmente? Explora cómo la abstracción que proporciona la STL puede simplificar la implementación, pero también cómo una implementación manual ofrece mayor control sobre la gestión de recursos.

R/ std::stack gestiona memoria por RAII, osea que se libera automaticamente cuando su funcionalidad termine, seguro y evita implementar destructor, ya que se libera automaticamente. Es más sencillo y rápido de usar. Una implementación manual te da control sobre su ocupación en la memoria, comportamiento exacto que tienen los nodos y optimizaciones específicas, pero tiene  mayor complejidad, ya que pueden ocurrir fugas de memoria o errores.


4. ¿Cómo afecta la estructura de un stack al orden de acceso y eliminación de elementos? Analiza cómo la naturaleza LIFO (Last In, First Out) del stack influye en los tipos de problemas que esta estructura de datos puede resolver eficientemente.

R/ La estructura LIFO quiere decir que el último elemento insertado es el primero en salir, eso hace al stack ideal para problemas donde el orden inverso al de llegada es deseado como deshacer o rehacer. Su restricción de acceso solo al top simplifica operaciones a simples pero impide acceso rápido a elementos intermedios.

5. ¿Cómo podrías modificar el stack para almacenar tipos de datos más complejos (e.g., objetos con múltiples atributos) sin causar problemas de memoria? Reflexiona sobre cómo gestionar adecuadamente la memoria para objetos más complejos y cómo esto afectaría tu implementación actual.

R/  Usar un contenedor como una lista enlazada que gestione objetos complejos, definiendo correctamente constructores/destructores y probar excepciones para evitar fugas, ya que así puedo tener mejor manejo de objetos complejos.

Preguntas de autoevaluación:

1. ¿Puedo explicar detalladamente cómo funciona el proceso de apilar y desapilar nodos en un stack, incluyendo la gestión de memoria?

R/ Se apila como push y desapila como pop y para la creación es con new, cuando creo un nuevo nodo la parte del puntero apunta al siguiente nodo creado y si no hay ningun otro creado se pone en null. Con el delete va liberando los nodos a medida que se avanza

2. ¿Soy capaz de identificar y corregir una fuga de memoria en una implementación de stack manual?

R/Para identificar tenemos que revisar que no haya quedado ningun objeto que hayamos querido borrar en la memoria del programa y si hay tenemos que procurar borrarlo con el delete o el destructor para corroborar que la memoria se libere.

3. ¿Puedo modificar el stack para que incluya una función que busque un elemento específico, sin alterar el orden de los elementos apilados?

R/ Si es una lista enlaza se puede hacer mas facil recorriendo los punteros y si es una pila o cola tendriamos que recorre toda la lista procurando que los nodos queden de la forma en la que estaban antes.

4. ¿Entiendo cómo la estructura LIFO del stack afecta el flujo de datos y puedo dar ejemplos de problemas que se resuelvan mejor con un stack?

R/ Si, ya que si el último elemento en entrar es el primero que sale tiene su propio flujo, seria muy diferente de hacer que el primer elemento sea el primero que salga, ya que este llevaria otro flujo diferente, lo unico que se me ocurre es el deshacer y rehacer, ya que la ultima accion ejecutada es la que necesitamos tener en cuenta.

5. ¿Puedo implementar y depurar un stack para tipos de datos más complejos, asegurándome de que no haya fugas de memoria ni errores de puntero?

R/ Siento que todavía es algo que tengo trabajar, ya que no he realizado más cosas con ellas además del código analizado en las actividades

Preguntas de reflexión para la queue:

1. ¿Cómo se maneja la memoria en una implementación manual de una queue en C++? Reflexiona sobre cómo se gestionan los nodos al encolar y desencolar elementos y las implicaciones en términos de eficiencia y seguridad.

R/ En la queue manual cada enqueue crea un nodo con new y lo enlaza al rear; cada dequeue avanza y hace delete del nodo antiguo.

2. ¿Qué desafíos específicos presenta la implementación de una queue en comparación con un stack en términos de gestión de memoria? Considera las diferencias en el manejo de punteros front y rear, y cómo estos afectan el proceso de encolado y desencolado.

R/  La queue mantiene dos punteros front y rear y hay que vaciar los dos al final, ya que lo anterior puede provocar errores como punteros que queden apuntando a algo que ya no tiene un elemento o que ese puntero se pierda, lo anterior en ordenpuede provocar acceso a memoria ya liberada. 

3. ¿Cómo afecta la estructura FIFO (First In, First Out) de una queue a su uso en diferentes tipos de problemas? Analiza cómo la estructura FIFO influye en la resolución de problemas donde el orden de procesamiento es crucial, como en sistemas de colas de espera.

R/ La cola garantiza que el primer usuario o elemento en entrar sea el primero en ser atendido, evitando otros escenarios que no deberian ocurrir.

4. ¿Cómo podrías implementar una queue circular y cuál sería su ventaja respecto a una queue lineal en términos de uso de memoria? Reflexiona sobre cómo una queue circular puede mejorar la eficiencia en ciertos contextos y qué cambios serían necesarios en la implementación.

R/ No había tenido tan presente las diferencias, pero la mayor ventaja que tiene el circular frente al lineal, es cuando tu llegas al rear puedes saltar al front y seguir reutilizando el espacio siempre y cuando el front haya estado vacio dando circulacion a la memoria.

5. ¿Qué problemas podrían surgir si no se gestionan correctamente los punteros front y rear en una queue, y cómo podrías evitarlos? Considera posibles errores como la pérdida de referencias a nodos y cómo una gestión cuidadosa de los punteros puede prevenir estos problemas.

R/ Que el rear o front apunten todavía a una dirección la cual ya fue vaciada, así que toca procurarse que tanto el rear o front queden en null al terminar la eliminacion de memoria.

Preguntas de autoevaluación:

1. ¿Puedo explicar claramente el proceso de encolar y desencolar nodos en una queue, incluyendo la gestión de memoria?

R/ Creación con new, enlace por rear, avanzan desde el  front y  con delete se borran o se limpia todo con el destructor. 


2. ¿Soy capaz de identificar y corregir problemas relacionados con la gestión de los punteros front y rear en una queue?

R/ Identificar errores como olvidar colocar el rear o algun elemento en null, pero tendría que trabajar más programas para saber que más errores diferentes podría encontrar.

3. ¿Puedo modificar la queue para implementar una queue circular, entendiendo cómo esto afectaría la gestión de memoria?

R/ Comprendo el concepto de queue circular y su mayor efecto en comparacion al lineal, pero tengo que seguir trabajando en su implementacion.

4. ¿Entiendo cómo la estructura FIFO de una queue afecta el flujo de datos y puedo dar ejemplos de problemas que se resuelvan mejor con una queue?

R/ Tendría que trabajar más con las estructuras, pero entiendo el concepto y como es el flujo del último que entra es el primero que sale. Un ejemplo tal vez sería la mensajeria, tal vez porque el último mensaje ingresado es el primero en que sale a enviarse en este caso,

5. ¿Puedo implementar y depurar una queue para tipos de datos más complejos, asegurándome de que no haya fugas de memoria ni errores de puntero?

R/ Tendría que trabajar más en la depuración para encontrar errores en un queue.