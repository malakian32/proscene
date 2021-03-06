/**
 * Mouse Sensitivities.
 * by Jean Pierre Charalambos.
 * 
 * This example illustrates the involved variables that can be fine tuned
 * to control the mouse behavior, such as sensitivities and damping. 
 *
 * Follow the online indications and note that the displayed '+' '-'
 * symbols are interactive. Click on them to set the value of the variables.
 * 
 * Press 'd' to reset all variables to their default values.
 * Press 'u' to switch the control between camera and interactive frame.
 * Press 'v' to toggle the display of the controls.
 * Press 'h' to display the global shortcuts in the console.
 * Press 'H' to display the current camera profile keyboard shortcuts
 * and mouse bindings in the console. 
 */

import remixlab.proscene.*;
import remixlab.dandelion.core.*;
import remixlab.dandelion.geom.*;
import remixlab.tersehandling.core.*;
import remixlab.tersehandling.event.*;

Scene scene;
ArrayList buttons;	
int xM = 10;
boolean focusIFrame;
InteractiveFrame interactiveFrame;
boolean isIFrame = false;
boolean dispControls = true;
PFont myFont;
float defRotSens, defTransSens, defSpngSens, defWheelSens, defDampFrict;

void setup() {
  size(640, 360, P3D);
  
  myFont = loadFont("FreeSans-16.vlw");
  textFont(myFont);
  textAlign(LEFT);

  scene = new Scene(this);
  scene.setGridVisualHint(false);
  interactiveFrame = new InteractiveFrame(scene);
  interactiveFrame.translate(new Vec(30, 30, 0));

  buttons = new ArrayList();
  
  //init defaults (eye and ingeractiveFrame are the same):
  defRotSens   = interactiveFrame.rotationSensitivity();
  defTransSens = interactiveFrame.translationSensitivity();
  defSpngSens  = interactiveFrame.spinningSensitivity();
  defWheelSens = interactiveFrame.wheelSensitivity();
  defDampFrict = interactiveFrame.dampingFriction();

  buttons.add(new ClickButton(scene, new PVector(xM + 210, 50), myFont, "+", Sensitivity.ROTATION, true));	
  buttons.add(new ClickButton(scene, new PVector((xM + 210 + ((ClickButton)buttons.get(buttons.size()-1)).myWidth + 10), 50), myFont, "-", Sensitivity.ROTATION, false));		
  buttons.add(new ClickButton(scene, new PVector(xM + 210, 70), myFont, "+", Sensitivity.TRANSLATION, true));		
  buttons.add(new ClickButton(scene, new PVector((xM + 210 + ((ClickButton)buttons.get(buttons.size()-1)).myWidth + 10), 70), myFont, "-", Sensitivity.TRANSLATION, false));		
  buttons.add(new ClickButton(scene, new PVector(xM + 210, 90), myFont, "+", Sensitivity.SPINNING, true));		
  buttons.add(new ClickButton(scene, new PVector((xM + 210 + ((ClickButton)buttons.get(buttons.size()-1)).myWidth + 10), 90), myFont, "-", Sensitivity.SPINNING, false)); 		
  buttons.add(new ClickButton(scene, new PVector(xM + 210, 110), myFont, "+", Sensitivity.WHEEL, true));		
  buttons.add(new ClickButton(scene, new PVector((xM + 210 + ((ClickButton)buttons.get(buttons.size()-1)).myWidth + 10), 110), myFont, "-", Sensitivity.WHEEL, false));  		
  buttons.add(new ClickButton(scene, new PVector(xM + 210, 130), myFont, "+", Sensitivity.SPINNING_FRICTION, true));		
  buttons.add(new ClickButton(scene, new PVector((xM + 210 + ((ClickButton)buttons.get(buttons.size()-1)).myWidth + 10), 130), myFont, "-", Sensitivity.SPINNING_FRICTION, false));

  scene.setRadius(150);
  scene.showAll();
}	

void draw() {
  background(0); 

  // Draw 3D scene first
  fill(204, 102, 0);
  box(20, 30, 40);		
  // Save the current model view matrix
  pushMatrix();
  // Multiply matrix to get in the frame coordinate system.
  // applyMatrix(interactiveFrame.matrix()) is possible but inefficient 
  interactiveFrame.applyTransformation();//very efficient
  // Draw an axis using the Scene static function
  scene.drawAxis(20);				
  // Draw a second box
  // Draw a second box
  if (focusIFrame) {
    fill(0, 255, 255);
    box(12, 17, 22);
  }
  else if (interactiveFrame.grabsAgent(scene.defaultMouseAgent())) {
    fill(255, 0, 0);
    box(12, 17, 22);
  }
  else {
    fill(0, 0, 255);
    box(10, 15, 20);
  }			
  popMatrix();

  // Finally draw 2D controls on top of the 3D scene
  displayControls();
}

void displayControls() {
  fill(200);
  if ( !dispControls ) {
    scene.beginScreenDrawing();
    displayText("Press 'v' to display info/controls", xM, 10);
    scene.endScreenDrawing();
    return;
  }
  else {
    scene.beginScreenDrawing();
    displayText("Press 'v' to hide info/controls", xM, 10);
    scene.endScreenDrawing();
  }

  InteractiveFrame iFrame;		
  if ( isIFrame ) {
    iFrame = interactiveFrame;
    scene.beginScreenDrawing();
    displayText("Interactive frame sensitivities (Press 'u' to view/set those of Camera frame)", xM, 30);
    scene.endScreenDrawing();
  }
  else {
    iFrame = scene.camera().frame();
    scene.beginScreenDrawing();
    displayText("Camera frame sensitivities (Press 'u' to view/set those of Interactive frame)", xM, 30);
    scene.endScreenDrawing();
  }

  fill(200, 255, 0);
  scene.beginScreenDrawing();
  displayText(equals(iFrame.rotationSensitivity(), defRotSens) ? "Rotation sensitivity" : "Rotation sensitivity *", xM, 50);		
  displayText(String.format("%.2f", iFrame.rotationSensitivity()), xM + 165, 50);
  displayText(equals(iFrame.translationSensitivity(), defTransSens) ? "Translation sensitivity" : "Translation sensitivity *", xM, 70);		
  displayText(String.format("%.2f", iFrame.translationSensitivity()), xM + 165, 70);
  displayText(equals(iFrame.spinningSensitivity(), defSpngSens) ? "Spinning sensitivity" : "Spinning sensitivity *", xM, 90);		
  displayText(String.format("%.2f", iFrame.spinningSensitivity()), xM + 165, 90);  
  displayText(equals(iFrame.wheelSensitivity(), defWheelSens) ? "Wheel sensitivity" : "Wheel sensitivity *", xM, 110);
  displayText(String.format("%.2f", iFrame.wheelSensitivity()), xM + 165, 110);  
  displayText(equals(iFrame.dampingFriction(), defDampFrict) ? "Spinning friction" : "Spinning friction *", xM, 130);
  displayText(String.format("%.2f", iFrame.dampingFriction()), xM + 165, 130);
  scene.endScreenDrawing();

  for (int i = 0; i < buttons.size(); i++)
    ( (ClickButton) buttons.get(i)).display();

  fill(200);
  if (!areDefaultsSet(iFrame)) {
    scene.beginScreenDrawing();
    displayText("Press 'd' to set sensitivities to their default values", xM, 190);
    scene.endScreenDrawing();
  }
}

void increaseSensitivity(Sensitivity sens) {
  if (isIFrame)
    increaseSensitivity(interactiveFrame, sens);
  else
    increaseSensitivity(scene.camera().frame(), sens);
}

void decreaseSensitivity(Sensitivity sens) {
  if (isIFrame)
    decreaseSensitivity(interactiveFrame, sens);
  else
    decreaseSensitivity(scene.camera().frame(), sens);
}	

void increaseSensitivity(InteractiveFrame iFrame, Sensitivity sens) {
  changeSensitivity(iFrame, sens, true);
}

void decreaseSensitivity(InteractiveFrame iFrame, Sensitivity sens) {
  changeSensitivity(iFrame, sens, false);
}	

void changeSensitivity(InteractiveFrame iFrame, Sensitivity sens, boolean increase) {
  float step = 1;
  float res;
  switch (sens) {
  case ROTATION:
    step = increase ? 0.5f : -0.5f;
    res = iFrame.rotationSensitivity() + step;
    if (0<= res && res <=10)
      iFrame.setRotationSensitivity(res);			
    break;
  case TRANSLATION:
    step = increase ? 0.5f : -0.5f;
    res = iFrame.translationSensitivity() + step;
    if (0<= res && res <=10)
      iFrame.setTranslationSensitivity(res);
    break;
  case SPINNING:
    step = increase ? 0.1f : -0.1f;
    res = iFrame.spinningSensitivity() + step;
    if (0<= res && res <=100)
      iFrame.setSpinningSensitivity(res);
    break;	
  case WHEEL:
    step = increase ? 5 : -5;
    res = iFrame.wheelSensitivity() + step;
    if (-100<= res && res <=100)
      iFrame.setWheelSensitivity(res);
    break;
  case SPINNING_FRICTION:
    step = increase ? 0.05f : -0.05f;
    res = iFrame.dampingFriction() + step;
    if (0<= res && res <=1)
      iFrame.setDampingFriction(res);
    break;
  }
}

boolean areDefaultsSet(InteractiveFrame iFrame) {
  if (   equals(iFrame.rotationSensitivity(), defRotSens)
      && equals(iFrame.translationSensitivity(), defTransSens)
      && equals(iFrame.spinningSensitivity(), defSpngSens)
      && equals(iFrame.wheelSensitivity(), defWheelSens)
      && equals(iFrame.dampingFriction(), defDampFrict)
      )
    return true;
  return false;
}

void setDefaults(InteractiveFrame iFrame) {
  iFrame.setRotationSensitivity(defRotSens);
  iFrame.setTranslationSensitivity(defTransSens);
  iFrame.setSpinningSensitivity(defSpngSens);
  iFrame.setWheelSensitivity(defWheelSens);
  iFrame.setDampingFriction(defDampFrict);
}

void displayText(String text, int x, int y) {
  int width = (int) textWidth(text);
  int height = (int) (textAscent() + textDescent());
  pushStyle();
  text(text, x, y, width, height);
  popStyle();
}

static boolean equals(float a, float b) {
  if (abs(a-b) < 0.01f)
    return true;
  return false;
}	

void keyPressed() {
  if (key == 'u' || key == 'U') {
    isIFrame = !isIFrame;
  }
  if (key == 'v' || key == 'V') {
    dispControls = !dispControls;
    for (int i = 0; i < buttons.size(); i++)
      if (dispControls)
        scene.terseHandler().addInAllAgentPools((ClickButton) buttons.get(i));
      else
        scene.terseHandler().removeFromAllAgentPools((ClickButton) buttons.get(i));
  }		
  if (key == 'd' || key == 'D') {
    if ( isIFrame )
      setDefaults( interactiveFrame );
    else
      setDefaults( scene.camera().frame() );
  }
  if ( key == 'i') {
    if ( focusIFrame ) {
      scene.defaultMouseAgent().setDefaultGrabber(scene.eye().frame());
      scene.defaultMouseAgent().enableTracking();
    } 
    else {
      scene.defaultMouseAgent().setDefaultGrabber(interactiveFrame);
      scene.defaultMouseAgent().disableTracking();
    }
    focusIFrame = !focusIFrame;
  }
}
