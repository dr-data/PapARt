// PapARt library
import fr.inria.papart.procam.*;
import fr.inria.papart.multitouch.*;
import fr.inria.papart.procam.display.*;
import org.bytedeco.javacpp.*;
import org.reflections.*;
import TUIO.*;
import toxi.geom.*;


Papart papart;

// Frame location. 
int framePosX = 0;
int framePosY = 200;

boolean useProjector;
float planetScale = 1f / 20000f;

// Undecorated frame 
public void init() {
  frame.removeNotify(); 
  frame.setUndecorated(true); 
  frame.addNotify(); 
  super.init();
}

PVector boardSize = new PVector(297, 210);   //  21 * 29.7 cm
float boardResolution = 1;  // 3 pixels / mm

void setup(){

    useProjector = true;
    int frameSizeX = 1280;
    int frameSizeY = 800;

    if(!useProjector) {
	frameSizeX = 640 * 2;
	frameSizeY = 480 * 2;
    }

    size(frameSizeX, frameSizeY, OPENGL);
    papart = new Papart(this);

    if(useProjector){
	papart.initProjectorCamera("0", Camera.Type.OPENCV);
	papart.loadTouchInput(2, 5);
    } else {
  //      papart.initCamera("0", Camera.Type.OPENCV);
//	papart.loadTouchInput(2, 5);

      papart.initKinectCamera(2f);
      papart.loadTouchInputKinectOnly(2, 5);

	BaseDisplay display = papart.getDisplay();
	display.setDrawingSize(width, height);
    }

    papart.loadSketches();
    papart.startTracking();
}


void draw(){
}

void keyPressed() {

  // Placed here, bug if it is placed in setup().
  if(key == ' ')
    frame.setLocation(framePosX, framePosY);
}


