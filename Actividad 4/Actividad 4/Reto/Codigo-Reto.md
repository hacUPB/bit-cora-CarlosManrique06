- Aca voy a dejar el coidgo para que no se vea muy saturado la parte del video e imagenes.

para el offApp.h
```cpp

#pragma once

#include "ofMain.h"
#include <deque>
#include <list>

// Humo
struct SmokeParticle {
	ofVec2f pos;
	ofVec2f vel;
	float size;
	float life; 
	float maxLife; 

	SmokeParticle() { }
	SmokeParticle(ofVec2f p, ofVec2f v, float s, float l)
		: pos(p)
		, vel(v)
		, size(s)
		, life(l)
		, maxLife(l) { }

	void update(float dt) {
		pos += vel * dt;
		//Para que desaparezcan lentamente
		vel *= 0.995f;
		life -= dt;
	}

	float opacity() const {
		return ofClamp(life / maxLife, 0.0f, 1.0f);
	}
};

// Estructura de las nubes
struct Cloud {
	ofVec2f pos;
	ofVec2f vel;
	float radius;
	ofColor color;

	// La cola del humo: FIFO 
	std::deque<SmokeParticle> smoke;

	// El tiempo del humo
	float smokeTimer = 0.0f;
	float smokeInterval = 0.08f; // seconds

	Cloud() { }
	Cloud(ofVec2f p, ofVec2f v, float r, ofColor c)
		: pos(p)
		, vel(v)
		, radius(r)
		, color(c) { }

	void update(float dt, const ofVec2f & wind) {
		//aplicar viento
		vel += wind * dt * 0.2f; 
		pos += vel * dt;

		// generar el humo periodicamente
		smokeTimer += dt;
		if (smokeTimer >= smokeInterval) {
			smokeTimer = 0;
			// particle initial velocity depends on cloud velocity
			ofVec2f pvel = vel * 0.2f + ofVec2f(ofRandom(-10, 10), ofRandom(-30, -10));
			float psize = radius * ofRandom(0.08f, 0.22f);
			float life = ofRandom(1.2f, 2.6f);
			smoke.emplace_back(pos + ofVec2f(ofRandom(-radius * 0.4f, radius * 0.4f), ofRandom(-radius * 0.2f, radius * 0.2f)), pvel, psize, life);
		}

		// refrezcar el humo cuando la primera en entrar sale
		for (auto & p : smoke)
			p.update(dt);
		while (!smoke.empty() && smoke.front().life <= 0)
			smoke.pop_front();

		
		const size_t maxSmoke = 120;
		while (smoke.size() > maxSmoke)
			smoke.pop_front();
	}

	bool isOffscreen(int width, int height) const {
		return (pos.x + radius < -200 || pos.x - radius > width + 200 || pos.y - radius > height + 200 || pos.y + radius < -200);
	}
};

class ofApp : public ofBaseApp {
public:
	void setup() override;
	void update() override;
	void draw() override;

	void keyPressed(int key) override;
	void mousePressed(int x, int y, int button) override;

	// Lista enlazada de las nubes
	std::list<Cloud> clouds;

	// Viento global 
	ofVec2f wind = ofVec2f(20, 0);

	// El color del fondo
	ofColor skyTop = ofColor(40, 130, 230);
	ofColor skyBottom = ofColor(200, 220, 250);

	
	float lastTime = 0;

    //Funciones para llamar
	void spawnCloud(ofVec2f pos);
	void spawnRandomCloud();
};



```

- el ofApp.cpp

```cpp

// ===================== ofApp.cpp =====================

#include "ofApp.h"

void ofApp::setup() {
	ofSetFrameRate(60);
	ofBackgroundGradient(skyTop, skyBottom, OF_GRADIENT_LINEAR);
	lastTime = ofGetElapsedTimef();

	// Inicializo el programa con algunas nubes
	for (int i = 0; i < 5; ++i)
		spawnRandomCloud();
}

void ofApp::spawnCloud(ofVec2f p) {
	float r = ofRandom(40, 110);
	ofVec2f v(ofRandom(-10, 10), ofRandom(-6, 6));
	ofColor c = ofColor(ofRandom(220, 255), ofRandom(220, 255), ofRandom(220, 255), 220);
	clouds.emplace_back(p, v, r, c);
}

void ofApp::spawnRandomCloud() {
	float x = ofRandom(-200, ofGetWidth() + 200);
	float y = ofRandom(ofGetHeight() * 0.05f, ofGetHeight() * 0.5f);
	spawnCloud({ x, y });
}

void ofApp::update() {
	float now = ofGetElapsedTimef();
	float dt = ofClamp(now - lastTime, 0.0f, 0.05f);
	lastTime = now;

	//Itinerar en la lista enlazada de las nubes
	for (auto i = clouds.begin(); i != clouds.end();) {
		i->update(dt, wind);

		// Borrar las nubes cuando no estan en pantalla
		if (i->isOffscreen(ofGetWidth(), ofGetHeight())) {
			i = clouds.erase(i);
		} else {
			++i;
		}
	}

	// Minimo numero de nubes, para que no se vea vacio sino mas dinamico
	if (clouds.size() < 6) spawnRandomCloud();
}

void drawCloudShape(const Cloud & c) {
	// Crear las nubes con diferentes circulos
	ofPushStyle();
	ofNoFill();
	ofEnableBlendMode(OF_BLENDMODE_ALPHA);

	// Sombras
	ofSetColor(20, 20, 30, 30);
	ofDrawCircle(c.pos.x + c.radius * 0.08f, c.pos.y + c.radius * 0.08f, c.radius * 1.02f);

	// relleno suave de los circulos
	int layers = 5;
	for (int i = layers; i >= 1; --i) {
		float t = (float)i / (float)layers;
		float r = c.radius * (0.7f + 0.6f * t);
		ofColor col = c.color;
		col.a = ofClamp((int)(200 * t), 0, 255);
		ofSetColor(col);
		ofDrawCircle(c.pos.x + ofRandom(-c.radius * 0.02f, c.radius * 0.02f), c.pos.y + ofRandom(-c.radius * 0.02f, c.radius * 0.02f), r);
	}

	ofPopStyle();
}

void ofApp::draw() {
	//Redibujar el fondo
	ofBackgroundGradient(skyTop, skyBottom, OF_GRADIENT_LINEAR);

	// Dibujar el humo y nubes
	for (const auto & c : clouds) {
		
		ofPushStyle();
		ofNoFill();
		ofEnableBlendMode(OF_BLENDMODE_ALPHA);
		for (const auto & p : c.smoke) {
			float alpha = p.opacity() * 180.0f;
			float size = p.size;
		
			ofSetColor(160, 160, 170, (int)alpha);
			ofDrawCircle(p.pos, size);
			ofSetColor(220, 220, 230, (int)(alpha * 0.6f));
			ofDrawCircle(p.pos, size * 0.6f);
		}
		ofPopStyle();

		
		drawCloudShape(c);
	}

	//Mostrar la direccion del viento, cuantas nubes hay y los fps.

	ofSetColor(255);
	std::string s = "Wind: (" + ofToString(wind.x, 1) + ", " + ofToString(wind.y, 1) + ")  Clouds: " + ofToString((int)clouds.size()) + "  FPS: " + ofToString(ofGetFrameRate(), 1);
	ofDrawBitmapStringHighlight(s, 10, ofGetHeight() - 10);
}

//para las teclas
void ofApp::keyPressed(int key) {
	float step = 20.0f;
	switch (key) {
        //Mov viento
	case OF_KEY_LEFT:
		wind.x -= step;
		break;
	case OF_KEY_RIGHT:
		wind.x += step;
		break;
	case OF_KEY_UP:
		wind.y -= step;
		break;
	case OF_KEY_DOWN:
		wind.y += step;
		break;
	case 'c': // Limpiar las nubes e iniciar nuevamente
		clouds.clear();
		for (int i = 0; i < 4; ++i)
			spawnRandomCloud();
		break;
	case 'r': // Cambiar el fondo del cielo
		skyTop = ofColor(ofRandom(10, 80), ofRandom(80, 160), ofRandom(180, 255));
		skyBottom = ofColor(ofRandom(180, 240), ofRandom(200, 245), ofRandom(230, 255));
		break;
	default:
		break;
	}
}

void ofApp::mousePressed(int x, int y, int button) {
	// Crear nueva nube
	spawnCloud({ (float)x, (float)y });
}

```