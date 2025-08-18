### Actividad 1

- ¿Cuál es el resultado que se obtiene al ejecutar este programa?

R/ Al ejecutar el programa el lienzo se coloca de color negro y de acuerdo a la posición en la que este el mouse dibuja un círculo de color blanco.

### Actividad 2

- ¿Qué fue lo que incluimos en el archivo .h?

R/ Creamos un método  para cuando el mouse se mueva que recibe un valor de tipo númerico, que en este caso sera una posicion en X y Y, luego creamos otro método para cuando el mouse se presione y esté recibira 3 parametros númerico, creamos un vector de 2 dimensiones para guardar una pos en el eje X y Y, por último creamos una variable de ofColor llamada particle para utilizarla para usar un color.



- ¿Cómo funciona la aplicación?

R/ Cuando la pos del mouse cambia, se crea un circulo de color blanco en esa posicion y cada vez que se mueva creara otro hasta que llegue a 101, que es donde la app procedera a borrar el primer círculo creado, en caso de que se presiona click los circulos cambiaran de color a uno totalmente random cada vez que se presiona.

- ¿Qué hace la función mouseMoved?

R/ Cada vez que se mueva el mouse crea un vector y lo agrega a particles, si el tamaño supera los 100, borrara la primera pos creada en la lista.

- ¿Qué hace la función mousePressed?

R/ En el programa se llama cada vez que se presione algun boton del mouse y en este caso cada vez que se presiona cambia el color de los circulos a uno aleatorio.

- ¿Qué hace la función setup?

R/Se encarga de inicializar variables o alguna modificacion que pongamos antes de que el programa inicie.

- ¿Qué hace la función update?

R/Se llama repetidamente durante el funcionamiento del programa a los frames que vaya el programa.

- ¿Qué hace la función draw?

R/ Es como la que se encarga de renderizar el programa y dibujarlo en la pantalla.

### Actividad 3

Realiza un experimento con la aplicación anterior. Modifica alguna parte importante de su código.

```cpp

#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
	ofBackground(0);
	particleColor = ofColor::purple;
	Radius = 20;
}

//--------------------------------------------------------------
void ofApp::update() {
}

//--------------------------------------------------------------
void ofApp::draw() {
	for (auto & pos : particles) {
		ofSetColor(particleColor);
		ofDrawCircle(pos.x, pos.y, Radius);
		
	}
}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y) {

	particleColor = ofColor(ofRandom(255), ofRandom(255), ofRandom(255));
	particles.push_back(ofVec2f(x, y));
	if (particles.size() > 500) {
		particles.erase(particles.begin());
	}
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button) {

	if (button == 0)
	{
		Radius++;

	}

	else if (button == 2)
	{
		Radius--;
	}
}

void ofApp::mouseDragged(int x, int y, int button) {

	if (particles.size() > 0) {
		particles.erase(particles.begin());
	}
}

```

R/ Le aumente el tope máximo de pos a 500, el radio del círculo lo puse en 20, en la funcion mouseMoved puse que cambiara de color random, aunque, es epileptico. Cree una var Radius para modificar el radio del círculo, en la funcion mousePressed si el boton presionado es el click izquierdo el radio aumenta y si se presiona el click derecho disminuye y agrege una funcion mouseDragged que es cuando un boton de mantiene undido y se arrastra, ahi puse que si el vector tiene tan solo 1 valor ya se puede borrar el inicio.


### Actividad 5

- ¿Cuál es la definición de un puntero?

R/ Es un tipo de dato encargado de guardar una dirección de memoria.

- ¿Dónde está el puntero?

R/En el programa este es el puntero, ya que tiene el * para inicializarlo std::vector<Sphere*> globalVector;

- ¿Cómo se inicializa el puntero?

R/ SE inicializa con el *

- ¿Para qué se está usando el puntero?

R/ Para guardar direcciones de memoria por si necesitamos luego desreferenciar

- ¿Qué es exactamente lo que está almacenado en el puntero?

R/ En este caso: std::vector<Sphere*> globalVector; Lo que está guardando es la direccion que tiene cada esfera creada en el vector y no la esfera en si, sino la dirección de esa esfera.