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

//Lo q ue agregue al Update de mi nuevo estado
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