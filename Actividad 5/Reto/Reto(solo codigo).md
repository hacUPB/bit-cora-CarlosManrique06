### ofApp.h

```cpp
#pragma once
#include "ofMain.h"

// Clase base 
class CelestialObject {
protected:
	ofVec2f pos;
	float size;
	ofColor color;

public:
	CelestialObject(ofVec2f _pos, float _size, ofColor _color) {
		pos = _pos;
		size = _size;
		color = _color;
	}

	virtual void update() = 0;
	virtual void draw() = 0;
	virtual ~CelestialObject() { }
};

// Clase Star
class Star : public CelestialObject {
private:
	float alpha;
	float speed;
	float time;

public:
	Star(ofVec2f _pos, float _size, ofColor _color);
	void update() override;
	void draw() override;
};

//Clase Comet 
class Comet : public CelestialObject {
private:
	ofVec2f velocity;
	float hue;

public:
	Comet(ofVec2f _pos, ofVec2f _vel, float _size, ofColor _color);
	void update() override;
	void draw() override;

	void scaleVelocity(float factor); // para cambiar velocidad
};

// Clase principal 
class ofApp : public ofBaseApp {
public:
	void setup();
	void update();
	void draw();
	void keyPressed(int key);

private:
	vector<CelestialObject *> objetos;
	int cometCount;
	float cometSpeedFactor;
};
```

### ofApp.cpp

```cpp
#include "ofApp.h"

// Star 
Star::Star(ofVec2f _pos, float _size, ofColor _color)
	: CelestialObject(_pos, _size, _color) {
	alpha = 0;
	speed = ofRandom(0.01, 0.05);
	time = ofRandom(0, TWO_PI);
}
void Star::update() {
	time += speed;
	alpha = ofMap(sin(time), -1, 1, 30, 255);
}
void Star::draw() {
	ofSetColor(color.r, color.g, color.b, alpha);
	ofDrawCircle(pos, size);
}

//Comet 
Comet::Comet(ofVec2f _pos, ofVec2f _vel, float _size, ofColor _color)
	: CelestialObject(_pos, _size, _color) {
	velocity = _vel;
	hue = ofRandom(255);
}
void Comet::update() {
	pos += velocity;


	if (pos.x < 0 || pos.x > ofGetWidth() || pos.y > ofGetHeight()) {
		pos.set(ofRandom(ofGetWidth()), 0);

		float dirX = (ofRandom(1) > 0.5) ? ofRandom(2, 5) : -ofRandom(2, 5);
		velocity.set(dirX, ofRandom(2, 5));
	}

	// Cambiar color dinámico
	hue += 0.5;
	if (hue > 255) hue = 0;
	color.setHsb(hue, 200, 255);
}
void Comet::draw() {
	ofSetColor(color);
	ofDrawCircle(pos, size);

	for (int i = 1; i < 10; i++) {
		ofSetColor(color.r, color.g, color.b, 200 - i * 20);
		ofDrawCircle(pos - velocity * i, size - i * 0.3);
	}
}
void Comet::scaleVelocity(float factor) {
	velocity *= factor;
}

// ----------- ofApp ------------
void ofApp::setup() {
	ofBackground(0);
	cometCount = 5;
	cometSpeedFactor = 1.0f;

	// Estrellas
	for (int i = 0; i < 100; i++) {
		objetos.push_back(new Star(
			ofVec2f(ofRandom(ofGetWidth()), ofRandom(ofGetHeight())),
			ofRandom(1, 4),
			ofColor(ofRandom(150, 255))));
	}

	// Cometas
	for (int i = 0; i < cometCount; i++) {
		float dirX = (ofRandom(1) > 0.5) ? ofRandom(2, 5) : -ofRandom(2, 5);
		objetos.push_back(new Comet(
			ofVec2f(ofRandom(ofGetWidth()), ofRandom(ofGetHeight() / 2)),
			ofVec2f(dirX, ofRandom(2, 5)),
			ofRandom(3, 6),
			ofColor(100, 200, 255)));
	}
}

void ofApp::update() {
	for (auto & obj : objetos) {
		obj->update();
	}
}

void ofApp::draw() {
	for (auto & obj : objetos) {
		obj->draw();
	}

	// HUD
	ofSetColor(255);
	ofDrawBitmapString("FPS: " + ofToString(ofGetFrameRate(), 2), 20, 20);
	ofDrawBitmapString("Cometas: " + ofToString(cometCount), 20, 40);
	ofDrawBitmapString("Velocidad factor: " + ofToString(cometSpeedFactor, 2), 20, 60);
	ofDrawBitmapString("Controles: W=Agregar, S=Quitar, D=Mas rapidos, A=Mas lentos", 20, 80);
}

void ofApp::keyPressed(int key) {
	switch (key) {
	case 'w': // agregar cometa
	case 'W':
		cometCount++;
		{
			float dirX = (ofRandom(1) > 0.5) ? ofRandom(2, 5) : -ofRandom(2, 5);
			objetos.push_back(new Comet(
				ofVec2f(ofRandom(ofGetWidth()), ofRandom(ofGetHeight() / 2)),
				ofVec2f(dirX, ofRandom(2, 5)),
				ofRandom(3, 6),
				ofColor(100, 200, 255)));
		}
		break;

	case 's': // quitar cometa
	case 'S':
		for (int i = objetos.size() - 1; i >= 0; i--) {
			Comet * c = dynamic_cast<Comet *>(objetos[i]);
			if (c) {
				delete c;
				objetos.erase(objetos.begin() + i);
				cometCount--;
				break;
			}
		}
		break;

	case 'd': // aumentar velocidad
	case 'D':
		cometSpeedFactor *= 1.2f;
		for (auto & obj : objetos) {
			Comet * c = dynamic_cast<Comet *>(obj);
			if (c) c->scaleVelocity(1.2f);
		}
		break;

	case 'a': // disminuir velocidad
	case 'A':
		cometSpeedFactor *= 0.8f;
		for (auto & obj : objetos) {
			Comet * c = dynamic_cast<Comet *>(obj);
			if (c) c->scaleVelocity(0.8f);
		}
		break;
	}
}
```