## Sesion 1

- ¿Cómo interactúan sus atributos y métodos?

R/ Los atributos (x, y) representan el estado de cada objeto. El método move representa un comportamiento, en donde modifica ese estado en función de los parámetros.

```cpp

Particle p1;
p1.x = 0;
p1.y = 0;

p1.move(5, 3);

```
En el ejemplo se crea una objeto particle llamado p1, done p1.move cambia los valores de los atributos y si hubiera otra particula como p2 esta tendria sus atributos independientes, lo cual hace que cada instancia maneje su propio tamaño.

- ¿Qué es un objeto desde la perspectiva de la memoria?

R/ Un objeto en memoria es un bloque de datos que corresponde a los atributos de la clase donde cada atributo tiene cierto tamaño de bytes.

- ¿Cómo influyen los atributos y métodos en el tamaño y estructura del objeto?

R/ los atributos determinan directamente el tamaño del objeto, los métodos no afectan el tamaño, ya que son compartidos y se guardan en la memoria de texto, las variables estáticas tampoco aumentan el tamaño cada instancia, ya que comparten los datos y existen una vez y las variables dinámicas hacen que el objeto guarde punteros y la memoria se gestiona en el heap.

- Conclusión: resumir los hallazgos y cómo esto impacta el diseño de clases

R/ Entender cómo se organizan los objetos en memoria permite diseñar clases más eficientes, ya que puedes ver como gestionar el uso de la memoria en los objetos creados. Si un objeto necesita contener muchos datos compartidos, conviene usar static. Si un objeto necesita datos que cambian de tamaño, conviene usar asignación dinámica, pero liberando la memoria adecuadamente cuando se necesite.



## Sesion 2


Si creas un objeto en el stack:

```cpp
Particle p; // vive en el stack



Si lo creas en el heap:

Particle* p = new Particle(); // vive en el heap

```

los atributos se almacenan en el heap, pero la dirección se guarda en el stack.

Métodos: El código de los métodos no se copia en cada objeto. Están en la sección de código (text segment) del programa, compartida por todas las instancias. Por eso, los métodos no afectan el tamaño del objeto.

-  Vtables (tablas virtuales):

Cuando una clase tiene al menos un método virtual, el compilador agrega un puntero oculto dentro de cada objetoconocido como vptr. La vtable se almacena en una zona estática del programa, usualmente junto al código.

```cpp
Base b;
Derived d;

std::cout << "Direccion vtable Base: " << *(void**)&b << std::endl;
std::cout << "Direccion vtable Derived: " << *(void**)&d << std::endl;

```

la clasesBase será mayor que el tamaño de un objeto sin virtuales, porque guarda el vptr. b y d tendrán vptr diferentes:

El de b apunta a la vtable de Base.

El de d apunta a la vtable de Derived.

la vtable permite que, usando un puntero o referencia a Base, el programa decida en tiempo de ejecución cuál versión de display() llamar.



Vtables: Cuando una clase tiene al menos un método virtual, el compilador agrega un puntero oculto dentro de cada objeto  como vptr. Ese puntero apunta a una vtable: una tabla con direcciones de funciones. La vtable se almacena en una zona 
estática del programa, usualmente junto al código.

Permite que, usando un puntero o referencia a Base, el programa decida en tiempo de ejecución cuál versión de display() llamar.


Diferencia entre punteros a funciones y punteros a métodos

```cpp

class FunctionPointerExample {
public:
    void (*funcPtr)(); // puntero a función
    static void staticFunction() {
        std::cout << "Static function called" << std::endl;
    }
    void assignFunction() {
        funcPtr = staticFunction;
    }
};

```
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

### Sesion 3



#### Encapsulamiento

El encapsulamiento se implementa en tiempo de compilación: el compilador revisa los modificadores private, protected, public y decide si el acceso es válido o no. Por otro lado, wn memoria, los atributos sí estándentro del objeto, sin importar si son private o public. Lo que impide el acceso no es el CPU ni la memoria, sino el compilador.

El compilador bloquea el acceso directo a miembros privados/protegidos mediante errores de compilación. Sin embargo, los miembros existen dentro de la estructura en memoria, y con punteros u operaciones de bajo nivel puedes romper ese encapsulamiento.

![alt text](<Error compilador.jpg>)

Con solo poner secret1 ya el compilador te dice que no se puede obtener el acceso a secret y si le das compilar, directamente te salta el error

####  Hackeando el Encapsulamiento

Con reinterpret_cast y aritmética de punteros puedes leer la memoria cruda del objeto. reinterpret_cast no respeta tipos ni seguridad; simplemente reinterpreta una dirección de memoria como si fuera otro tipo.

Esto permite leer atributos privados porque en la memoria no hay “paredes” entre los datos; solo bytes organizados secuencialmente.

[text](Investigacion.md)

En este caso si dejo hacer el compilado y accedio a los miembros privados mediante el reinterpret violando el encapsulamiento.


Encapsulamiento: protege contra errores accidentales y promueve un diseño más seguro y mantenible.

Seguridad: si abusas de reinterpret_cast, tu programa puede romperse o ser vulnerable.

Conclusión: en C++, el encapsulamiento es una garantía del compilador, pero es una barrera que puede romperse.

#### Herencia y Relación en Memoria


La memoria de Derived empieza con los datos de Base. Después de esos, se añaden los atributos de Derived. Si añades más niveles, cada clase va apilando sus atributos en orden de herencia.

Cuando defines un objeto de una clase derivada, en memoria primero están los atributos de la clase base, seguidos por los de la derivada. Esto asegura compatibilidad


#### Reflexión Final

Encapsulamiento: implementado por el compilador, organiza acceso y protege la abstracción, pero no es una barrera en memoria.

Herencia: organiza atributos de forma lineal, respetando la jerarquía para garantizar compatibilidad.

Polimorfismo: añade un nivel de indirección de vptr + vtable, aumentando flexibilidad pero con un pequeño costo en rendimiento.