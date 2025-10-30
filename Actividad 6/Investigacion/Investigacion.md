### Analisis de caso de estudio


#### Método de fabricas

```cpp

Particle* ParticleFactory::createParticle(const std::string& type) {
    Particle* particle = new Particle();

    if (type == "star") {
        particle->size = ofRandom(2, 4);
        particle->color = ofColor(255, 0, 0);
    }
    else if (type == "shooting_star") {
        particle->size = ofRandom(3, 6);
        particle->color = ofColor(0, 255, 0);
        particle->velocity *= 3;
    }
    else if (type == "planet") {
        particle->size = ofRandom(5, 8);
        particle->color = ofColor(0, 0, 255);
    }
    return particle;
}


void ofApp::setup() {
    ofBackground(0);
    // Crear partículas usando la fábrica
    for (int i = 0; i < 100; ++i) {
        Particle* p = ParticleFactory::createParticle("star");
        particles.push_back(p);
        addObserver(p);
    }

    for (int i = 0; i < 5; ++i) {
        Particle* p = ParticleFactory::createParticle("shooting_star");
        particles.push_back(p);
        addObserver(p);
    }

    for (int i = 0; i < 10; ++i) {
        Particle* p = ParticleFactory::createParticle("planet");
        particles.push_back(p);
        addObserver(p);
    }

}

```

- ¿Qué hace el patrón observer en este caso?

R/ El patrón Observer en este caso permite que actúe como emisora de eventos, mientras que las partículas son los observadores que reaccionan a esos eventos. Cuando el usuario presiona una tecla, ofApp notifica a todas las partículas con un mensaje como “attract” o “stop”, y cada partícula cambia su comportamiento según ese evento. 

- ¿Qué hace el patrón factory en este caso?

R/ El patrón Factory se utiliza para crear distintos tipos de partículas desde un solo punto de construcción. La clase ParticleFactory decide cómo inicializar una partícula según su tipo por ejemplo, “star” ó “planet”  asignando propiedades como color, tamaño y velocidad. De esta forma, el código que crea las partículas no necesita conocer los detalles de configuración y facilita agregar nuevos tipos en el futuro.

- ¿Qué hace el patrón state en este caso?

R/ El patrón State permite que cada partícula cambie su comportamiento dinámicamente dependiendo del estado, cada estado (NormalState, AttractState, RepelState y StopState) tienen un modo de movimiento distinto, y la partícula realiza la lógica respecto al estado actual.  Cambiar el estado equivale a cambiar la forma en que la partícula se comporta.

### Particula añadida al funcionamiento

En el .h

```cpp


//Nuevo estado

class MyState : public State {
public:
    void update(Particle* particle) override;
};

```

En el .cpp

```cpp

//void Particle::onNotify(const std::string& event) Agregue el nuevo evento

 else if (event == "crazy") {
     setState(new MyState());
 }

//Lo que agregue al Update de mi nuevo estado
void MyState::update(Particle* particle) {
    ofVec2f mousePosition(((ofApp*)ofGetAppPtr())->mouseX, ((ofApp*)ofGetAppPtr())->mouseY);
    ofVec2f direction = particle->position - mousePosition;
    direction.normalize();
    particle->velocity += direction * 1;
    ofClamp(particle->velocity.x, -1, 1);
    particle->position += particle->velocity * 2;


}
//Lo que agregue en el particleFactory
 else if (type == "giant") {
     particle->size = ofRandom(10, 15);
     particle->color = ofColor(128, 0, 128);
 }

//Lo que agregue en el setup
 for (int i = 0; i < 100; ++i) {
     Particle* p = ParticleFactory::createParticle("giant");
     particles.push_back(p);
     //addObserver(p);
    
 }

//Lo que agregue en el keyPressed
void ofApp::keyPressed(int key) {

    else if (key == 'm') {
        notify("crazy");
    }
}


```