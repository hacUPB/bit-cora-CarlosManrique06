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

R/ Se inicializa con el *

- ¿Para qué se está usando el puntero?

R/ Para guardar direcciones de memoria por si necesitamos luego desreferenciar

- ¿Qué es exactamente lo que está almacenado en el puntero?

R/ En este caso: std::vector<Sphere*> globalVector; Lo que está guardando es la direccion que tiene cada esfera creada en el vector y no la esfera en si, sino la dirección de esa esfera.

### Actividad 6

El código anterior tiene un problema. ¿Puedes identificar cuál es? ¿Cómo lo solucionarías? Recuerda que deberías poder seleccionar una esfera y moverla con el mouse.

R/ El problema es que para seleccionar una esfera la distancia tiene que ser menor que el radio de la esfera, pero cuando se selecciona una esfera y se mueve con el mouse, no se puede seleccionar otra diferente, ya que la distancia del mouse seguiria siendo menor que el radio en la que estoy moviendo. Para solucionarlo, se podría crear una nueva funcion para cuando el click izquierdo del mouse se suelte y que selectedSphere sea NULL, para que se pueda seleccionar otra esfera.

```cpp

//ofApp.h
void mouseReleased(int x, int y, int button);


//ofApp.cpp
void ofApp::mouseReleased(int x, int y, int button) 

{
    if (button == 0)

    {
       selectedSphere = nullptr;
    }

}

```


### Actividad 7

Primer Código con Stack: ¿Qué sucede cuando presionas la tecla “c”?

R/ Cuando presiono c se crea una esfera de forma local en la funcion, en el bloque de memoria stack, pero como es local la esfera no se muestra porque se destruye cuando finaliza la funcion

Segundo código con heap:


- ¿Qué sucede cuando presionas la tecla “c”?

R/ Cuando presiono c se crea una esfera con el new, entonces esto se guarda en la memoria dinamica, la cual es heap, por lo tanto la esfera si se muestra en algun lado del canva al terminar la funcion 

- ¿Por qué ocurre esto?

R/ Esto ocurre porque al guardar en stack el objeto solo se mantiene mientras dure la funcion y apenas termine se elimina. En cambio, si se guarda en heap esta no se eliminara hasta que se use algun comando para borrala, sino seguira funcionando aunque la funcion haya terminado.


### Actividad 8

Código Experimento app.h:
```cpp
#pragma once
#include "ofMain.h"

ofRectangle globalRect;

class ofApp : public ofBaseApp {
public:
	void setup();
	void update();
	void draw();
	void keyPressed(int key);


	ofRectangle stackRect;

	vector<ofRectangle *> heapRects;
};

```
Código Experimento app.cpp:

```cpp
#include "ofApp.h"


void ofApp::setup() {

	globalRect.set(50, 50, 100, 100); 
	stackRect.set(200, 50, 100, 100); 
}

void ofApp::update() {
}

void ofApp::draw() {
	ofSetColor(255, 0, 0);
	ofDrawRectangle(globalRect); 

	ofSetColor(0, 255, 0);
	ofDrawRectangle(stackRect);

	ofSetColor(0, 0, 255);
	for (auto r : heapRects) {
		ofDrawRectangle(*r); 
	}
}

void ofApp::keyPressed(int key) {
	if (key == 'h') {
		
		ofRectangle * newRect = new ofRectangle(ofRandom(50, 500), ofRandom(200, 400), 50, 50);
		heapRects.push_back(newRect);
	}

	if (key == 'd') {
		
		if (!heapRects.empty()) {
			delete heapRects.back();
			heapRects.pop_back();
		}
	}
}


```

![alt text](<Act 8.jpg>)

R/ Lo que hace el codigo es que crea 2 rectangulos al iniciar el programa uno que se guarda en memoria global y otro en memoria stack. Para crear un rectangulo en heap sucede cuando se oprime la tecla h y para borrarlos de la memoria se presiona la tecla d

¿Cuándo debo crear objetos en el heap y cuándo en memoria global?

R/Heap cuando tiene que durar mas que la funcion, pero durante cierto tiempo del programa y global si tiene que durar mientras el programa corre.

### Actividad 9


Primer codigo: 

- ¿Qué sucede cuando presionas la tecla “f”?

R/ Cuando presiono la letra f se borra el ultimo objeto guardado en la memoria heap.

Analiza detalladamente esta parte del código:

```cpp
if(!heapObjects.empty()) {
    delete heapObjects.back();
    heapObjects.pop_back();
}
```

R/ el if pregunta si hay algun  objeto guardados en la memoria heap,  y si es asi borra el ultimo objeto guardado en la memoria heap y la última linea lo que hace es elminar el objeto del vector de heapObjects