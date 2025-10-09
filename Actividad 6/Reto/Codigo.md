### .h

```cpp

#pragma once
#include "ofMain.h"
#include <memory>
#include <string>
#include <vector>

// ---------------------------------------------------------
// OBSERVER PATTERN
class Observer {
public:
	// Cuando un PowerUp se activa, se notifica a los observadores
	virtual void onPowerUpActivated(std::string type) = 0;
};

// Subject: mantiene una lista de observadores y les notifica.
// Aquí lo usa la clase PowerUp para notificar al jugador.
class Subject {
protected:
	// vector de punteros crudos a Observer 
	std::vector<Observer *> observers;

public:
	// Registrar un observador
	void addObserver(Observer * obs) { observers.push_back(obs); }

	// Notificar a todos los observadores acerca de un power-up activado.
	void notifyPowerUp(std::string type) {
		for (auto obs : observers)
			obs->onPowerUpActivated(type);
	}
};

// ---------------------------------------------------------
// STATE PATTERN
// ---------------------------------------------------------
// Interfaz base para los distintos estados del jugador.
// Cada estado define su propia lógica de update y draw.
class CircleState {
public:
	// update y draw reciben un puntero al PlayerCircle para poder mutar su comportamiento y acceder a sus campos.
	virtual void update(class PlayerCircle * circle) = 0;
	virtual void draw(class PlayerCircle * circle) = 0;

	// Devuelve el nombre del estado
	virtual std::string getName() = 0;

	virtual ~CircleState() = default;
};

// Estado por defecto / sano
class NormalState : public CircleState {
public:
	void update(PlayerCircle * circle) override;
	void draw(PlayerCircle * circle) override;
	std::string getName() override { return "Normal"; }
};

// Estado de poder 
class PowerState : public CircleState {
	// mantiene su propio timer. Al salir y volver a entrar se reinicia.
	float timer = 0;

public:
	void update(PlayerCircle * circle) override;
	void draw(PlayerCircle * circle) override;
	std::string getName() override { return "Power"; }
};

// Estado cuando el jugador está debilitado 
class WeakState : public CircleState {
public:
	void update(PlayerCircle * circle) override;
	void draw(PlayerCircle * circle) override;
	std::string getName() override { return "Weak"; }
};

// Estado temporal donde el jugador no recibe daño 
class InvulnerableState : public CircleState {
	float timer = 0; // tiempo que lleva el estado
	bool visible = true; 

public:
	void update(PlayerCircle * circle) override;
	void draw(PlayerCircle * circle) override;
	std::string getName() override { return "Invulnerable"; }
};

// Estado final: Game Over 
class GameOverState : public CircleState {
public:
	void update(PlayerCircle * circle) override;
	void draw(PlayerCircle * circle) override;
	std::string getName() override { return "GameOver"; }
};

// ---------------------------------------------------------
// PLAYER CIRCLE (State + Observer)
// ---------------------------------------------------------
// La clase PlayerCircle implementa Observer (porque escucha los PowerUps)
// y contiene un std::unique_ptr<CircleState> para delegar su comportamiento.
class PlayerCircle : public Observer {
public:
	ofVec2f pos; 
	float radius; 
	int lives; 
	float speed; 
	std::unique_ptr<CircleState> state; // estado activo
	std::string prevStateName; 
	bool canMove; 

	PlayerCircle();

	void move(); 
	void update(); // delega al state actual
	void draw(); // delega al state actual

	void takeDamage(); 
	void changeState(std::unique_ptr<CircleState> newState); // cambia estado
	void onPowerUpActivated(std::string type) override; // Observer callback
	void reset(); 
};

// ---------------------------------------------------------
// FACTORY PATTERN (Enemy generation)
// ---------------------------------------------------------


// Clase base Enemy: define propiedades comunes y comportamiento por defecto.
class Enemy {
public:
	ofVec2f pos, vel; 
	ofColor color; 
	float size; 
	virtual void update();
	virtual void draw();
	virtual ~Enemy() = default;
};

// Enemigo cuadrado (sobrescribe draw)
class SquareEnemy : public Enemy {
public:
	void draw() override;
};

// Enemigo triángulo (sobrescribe draw)
class TriangleEnemy : public Enemy {
public:
	void draw() override;
};

// Fábrica de enemigos: encapsula creación de subclases de Enemy.
// Devuelve std::shared_ptr<Enemy> memoria
class EnemyFactory {
public:
	static std::shared_ptr<Enemy> createEnemy();
};

// ---------------------------------------------------------
// POWER-UP CLASS (Subject del patrón Observer)
// ---------------------------------------------------------


// PowerUp hereda Subject para poder notificar a los observadores (player).
class PowerUp : public Subject {
public:
	ofVec2f pos;
	float radius; 
	std::string type;
	bool active; 

	PowerUp(ofVec2f p, std::string t);
	void draw();
};


class ofApp : public ofBaseApp {
public:
	PlayerCircle player;
	std::vector<std::shared_ptr<Enemy>> enemies; // lista de enemigos
	std::vector<std::shared_ptr<PowerUp>> powerUps; // lista de power-ups

	void setup();
	void update();
	void draw();
	void keyPressed(int key);

	void reset(); 
};


```

### .cpp

```cpp

#include "ofApp.h"
#include <cmath> 


// PLAYER STATES IMPLEMENTATION


void NormalState::update(PlayerCircle * c) {
	
	c->move();
}

void NormalState::draw(PlayerCircle * c) {
	
	ofSetColor(0, 200, 255); 
	ofDrawCircle(c->pos, c->radius); 
}


void PowerState::update(PlayerCircle * c) {
	
	c->move();

	//  controla su duración propia con timer local.
	
	timer += ofGetLastFrameTime();

	// Si se cumple la duración, volvemos al estado Normal automáticamente.
	if (timer > 5.0f)
		c->changeState(std::make_unique<NormalState>());
}

void PowerState::draw(PlayerCircle * c) {
	
	ofSetColor(255, 255, 0);
	ofDrawCircle(c->pos, c->radius * 1.3);
}


void WeakState::update(PlayerCircle * c) {
	c->move();
}

void WeakState::draw(PlayerCircle * c) {
	ofSetColor(255, 50, 50); 
	ofDrawCircle(c->pos, c->radius * 0.8); 
}


void InvulnerableState::update(PlayerCircle * c) {
	
	c->move();

	// Aumentamos el temporizador del estado
	timer += ofGetLastFrameTime();

	if (fmod(timer, 0.2f) < 0.1f)
		visible = !visible;

	
	if (timer > 3.0f) {

		// Volvemos al estado que tocaba antes de la invulnerabilidad.
		if (c->prevStateName == "Weak")
			c->changeState(std::make_unique<WeakState>());
		else
			c->changeState(std::make_unique<NormalState>());
	}
}

void InvulnerableState::draw(PlayerCircle * c) {
	
	if (visible) {
		ofSetColor(150, 150, 255); 
		ofDrawCircle(c->pos, c->radius);
	}
}

void GameOverState::update(PlayerCircle * c) {
	
}

void GameOverState::draw(PlayerCircle * c) {
	
	ofSetColor(100, 100, 100);
	ofDrawCircle(c->pos, c->radius);
}


// PLAYER

PlayerCircle::PlayerCircle() {
	
	reset();
}

void PlayerCircle::reset() {
	
	pos = ofVec2f(ofGetWidth() / 2.0f, ofGetHeight() / 2.0f);
	radius = 20;
	speed = 4.0;
	lives = 3;
	prevStateName = "Normal";
	state = std::make_unique<NormalState>(); // State Pattern: comenzamos en Normal
	canMove = true; 
}

void PlayerCircle::move() {
	
	if (!canMove) return;

	// Control basico con flechas del teclado
	if (ofGetKeyPressed(OF_KEY_LEFT)) pos.x -= speed;
	if (ofGetKeyPressed(OF_KEY_RIGHT)) pos.x += speed;
	if (ofGetKeyPressed(OF_KEY_UP)) pos.y -= speed;
	if (ofGetKeyPressed(OF_KEY_DOWN)) pos.y += speed;

	// Mantenemos dentro de la ventana usando ofClamp
	pos.x = ofClamp(pos.x, radius, ofGetWidth() - radius);
	pos.y = ofClamp(pos.y, radius, ofGetHeight() - radius);
}

// Delegamos completamente al state actual 
void PlayerCircle::update() { state->update(this); }
void PlayerCircle::draw() { state->draw(this); }

// Lógica de daño
void PlayerCircle::takeDamage() {
	
	if (state->getName() == "Invulnerable" || state->getName() == "Power" || state->getName() == "GameOver")
		return;

	lives--;
	prevStateName = (lives == 2) ? "Weak" : "Normal";

	
	if (lives > 0) {
		changeState(std::make_unique<InvulnerableState>());
	} else {
		
		changeState(std::make_unique<GameOverState>());
		canMove = false; // bloqueamos movimiento por completo
	}
}

// Cambio de estado simple
void PlayerCircle::changeState(std::unique_ptr<CircleState> newState) {
	state = std::move(newState);
}

// Callback del Observer: reaccionamos a power-ups.
// Este es el punto donde el patrón Observer conecta con el State Pattern:
// el PowerUp (Subject) notifica, y aquí se decide qué hacer (cambiar estado, modificar velocidad, etc).
void PlayerCircle::onPowerUpActivated(std::string type) {
	if (type == "speed") speed = 8.0; // ejemplo: boost de velocidad
	if (type == "shield") changeState(std::make_unique<PowerState>()); // escudo = PowerState
}


// ENEMY FACTORY

// Movimiento por defecto de un enemigo: se desplaza por su velocidad y rebota en bordes.
void Enemy::update() {
	pos += vel;
	if (pos.x < 0 || pos.x > ofGetWidth()) vel.x *= -1;
	if (pos.y < 0 || pos.y > ofGetHeight()) vel.y *= -1;
}


void Enemy::draw() {
	ofSetColor(color);
	ofDrawCircle(pos, size);
}


void SquareEnemy::draw() {
	ofSetColor(color);
	ofDrawRectangle(pos.x - size / 2, pos.y - size / 2, size, size);
}


void TriangleEnemy::draw() {
	ofSetColor(color);
	ofDrawTriangle(pos.x, pos.y - size,
		pos.x - size, pos.y + size,
		pos.x + size, pos.y + size);
}

// EnemyFactory: decide qué subclase crear y la inicializa.
// Aquí se centraliza la creación (Factory Pattern), facilitando añadir

std::shared_ptr<Enemy> EnemyFactory::createEnemy() {
	int r = ofRandom(3); // ofRandom devuelve float; asignamos a int para simplificar la elección.
	std::shared_ptr<Enemy> e;
	if (r == 0)
		e = std::make_shared<Enemy>();
	else if (r == 1)
		e = std::make_shared<SquareEnemy>();
	else
		e = std::make_shared<TriangleEnemy>();

	// Inicializamos propiedades del enemigo
	e->pos = ofVec2f(ofRandomWidth(), ofRandomHeight());
	e->vel = ofVec2f(ofRandom(-2, 2), ofRandom(-2, 2));
	e->color = ofColor::fromHsb(ofRandom(255), 255, 255);
	e->size = ofRandom(20, 40);

	return e;
}


// POWER-UP


PowerUp::PowerUp(ofVec2f p, std::string t) {
	pos = p;
	type = t;
	radius = 10;
	active = true;
}

// Dibujado del power-up sólo si está activo.

void PowerUp::draw() {
	if (active) {
		if (type == "speed")
			ofSetColor(0, 255, 0);
		else if (type == "shield")
			ofSetColor(255, 255, 0);

		ofDrawCircle(pos, radius);
	}
}

// ---------------------------------------------------------
// APP LOGIC
// ---------------------------------------------------------


void ofApp::setup() {
	
	ofSetWindowTitle("Arte Generativo con Observer, Factory, State y Game Over");
	ofBackground(0);

	
	reset();
}


void ofApp::reset() {
	player.reset();
	enemies.clear();
	powerUps.clear();

	// Generamos 5 enemigos iniciales con la Factory
	for (int i = 0; i < 5; i++)
		enemies.push_back(EnemyFactory::createEnemy());

	// Creamos dos power-ups de ejemplo y registramos al jugador como observador.
	// Así, cuando el player colisione, el power-up podrá notificarlo.
	auto p1 = std::make_shared<PowerUp>(ofVec2f(200.0f, 300.0f), "speed");
	auto p2 = std::make_shared<PowerUp>(ofVec2f(600.0f, 400.0f), "shield");
	p1->addObserver(&player);
	p2->addObserver(&player);
	powerUps.push_back(p1);
	powerUps.push_back(p2);
}


void ofApp::update() {
	
	player.update();

	
	if (player.state->getName() != "GameOver") {
		
		for (auto & e : enemies) {
			e->update();

			// Distancia entre enemigo y jugador:
			float dist = e->pos.distance(player.pos);

			
			if (dist < e->size / 2 + player.radius) {
				player.takeDamage();
			}
		}

		
		for (auto & p : powerUps) {
			// Si está activo y la distancia indica colisión, notificar.
			if (p->active && p->pos.distance(player.pos) < player.radius + p->radius) {
				p->notifyPowerUp(p->type); // Aquí el Subject notifica a todos sus Observers
				p->active = false; 
			}
		}
	}
}


void ofApp::draw() {
	player.draw();

	for (auto & e : enemies)
		e->draw();

	for (auto & p : powerUps)
		p->draw();

	// UI simple: vidas y estado 
	ofSetColor(255);
	ofDrawBitmapString("Vidas: " + std::to_string(player.lives), 20, 20);
	ofDrawBitmapString("Estado: " + player.state->getName(), 20, 40);

	// Mostrar Game Over: si el estado del jugador es GameOver mostramos el texto
	if (player.state->getName() == "GameOver") {
		ofSetColor(255, 0, 0);
		ofDrawBitmapStringHighlight("GAME OVER", ofGetWidth() / 2 - 60, ofGetHeight() / 2);
		ofSetColor(255);
		ofDrawBitmapStringHighlight("Presiona 'R' para reiniciar", ofGetWidth() / 2 - 100, ofGetHeight() / 2 + 40);
	}
}


void ofApp::keyPressed(int key) {
	if (key == 'r' || key == 'R') {
		reset();
	}
}


```