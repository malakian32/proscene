/**
 * Window Culling.
 * by Jean Pierre Charalambos.
 * 
 * Doc to come...
 *
 * Press 'h' to display the global shortcuts in the console.
 * Press 'H' to display the current camera profile keyboard shortcuts
 * and mouse bindings in the console.
 */

import remixlab.dandelion.core.Constants.*;
import remixlab.proscene.*;
import remixlab.dandelion.core.*;
import remixlab.dandelion.geom.*;

Scene scene, auxScene;
PGraphics canvas, auxCanvas;
float circleRadius = 150;

void setup() {
  size(640, 720, JAVA2D);

  canvas = createGraphics(640, 360, JAVA2D);
  scene = new Scene(this, canvas);

  scene.setRadius(200);
  scene.showAll();

  // enable computation of the frustum planes equations (disabled by default)
  scene.enableBoundaryEquations();
  scene.setGridVisualHint(false);
  scene.addDrawHandler(this, "mainDrawing");

  auxCanvas = createGraphics(640, 360, JAVA2D);
  // Note that we pass the upper left corner coordinates where the scene
  // is to be drawn (see drawing code below) to its constructor.
  auxScene = new Scene(this, auxCanvas, 0, 360);
  auxScene.setAxisVisualHint(false);
  auxScene.setGridVisualHint(false);
  auxScene.setRadius(400);
  auxScene.showAll();
  auxScene.addDrawHandler(this, "auxiliarDrawing");
}

public void mainDrawing(Scene s) {
  PGraphics p = s.pg();
  p.background(0);
  p.noStroke();
  p.ellipseMode(RADIUS);
  // the main viewer camera is used to cull the sphere object against its frustum
  switch (scene.window().ballIsVisible(new Vec(0, 0), circleRadius)) {
  case VISIBLE:
    p.fill(0, 255, 0);
    p.ellipse(0, 0, circleRadius, circleRadius);
    break;
  case SEMIVISIBLE:
    p.fill(255, 0, 0);
    p.ellipse(0, 0, circleRadius, circleRadius);
    break;
  case INVISIBLE:
    break;
  }
}

void auxiliarDrawing(Scene s) {
  mainDrawing(s);    
  s.pg().pushStyle();
  s.pg().stroke(255, 255, 0);
  s.pg().fill(255, 255, 0, 160);
  s.drawEye(scene.eye());
  s.pg().popStyle();
}

void draw() {
  handleMouse();
  canvas.beginDraw();
  scene.beginDraw();
  scene.endDraw();
  canvas.endDraw();
  image(canvas, 0, 0);

  auxCanvas.beginDraw();
  auxScene.beginDraw();
  auxScene.endDraw();
  auxCanvas.endDraw();
  // We retrieve the scene upper left coordinates defined above.
  image(auxCanvas, auxScene.upperLeftCorner.x(), auxScene.upperLeftCorner.y());
}

void handleMouse() {
  if (mouseY < 360) {
    scene.enableDefaultMouseAgent();
    scene.enableDefaultKeyboardAgent();
    auxScene.disableDefaultMouseAgent();
    auxScene.disableDefaultKeyboardAgent();
  } 
  else {
    scene.disableDefaultMouseAgent();
    scene.disableDefaultKeyboardAgent();
    auxScene.enableDefaultMouseAgent();
    auxScene.enableDefaultKeyboardAgent();
  }
}
