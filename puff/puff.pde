/*------------------ puff - Alba Corral 2017
  remix from Ira  Greenberg example book + toxi libs
 --------------------------------*/
import java.util.Iterator;
import java.util.Collection;
//http://toxiclibs.org/
import toxi.color.*;
import toxi.geom.*;
import toxi.util.datatypes.*;
//https://github.com/hamoid/video_export_processing
import com.hamoid.*; 
VideoExport videoExport;
// for puff head
float headX;
float headY;
float speedX = .7;
float speedY = .9;
ColorList list;
// for puff body
int cells = 100;
float[]px= new float[cells];
float[]py= new float[cells];
float[]radiiX = new float[cells];
float[]radiiY = new float[cells];
color[] colors = new color[cells];
float[]angle = new float[cells];
float[]frequency = new float[cells];
float[]cellRadius = new float[cells];
float numCols;
float   XRAD = 10;
float   YRAD = 10;
float incremento  =0;
Boolean isMouse = false;
Boolean recording = false;
void setup() {
  size(1920, 1080);
  // begin in the center
  headX = width/2;
  headY = height/2;

  iniciar();
  frameRate(30);
  noCursor();
   background(list.getLightest().toARGB()); 
   if (recording ) initVideo();
   
}
void iniciar() {
  
    setupColors();
 numCols = list.size();
  println("numColors:"+numCols);
  //fill body arrays
  for (int i=0; i< cells; i++) {
    radiiX[i] = random(-7, 7); 
    radiiY[i] = random(-4, 4);
    frequency[i]= random(-9, 9);
    cellRadius[i] = random(10, 400);
    colors[i] = list.get((int) random(numCols)).toARGB();
    //XRAD = 200;
    YRAD = XRAD;
  }
}
void draw() {
constrain(XRAD,-200,200);
YRAD = XRAD;

println("XRAD:"+XRAD);
  noStroke();

  //follow the leader
  for (int i =0; i< cells; i++) {
    if (i==0) {
      if (isMouse){
      px[i] = mouseX;
      py[i] = mouseY;
      }
      else
      {
         px[i] = headX+sin(radians(angle[i]))*radiiX[i];
      py[i] = headY+cos(radians(angle[i]))*radiiY[i];
      }
    } else {
      px[i] = px[i-1]+cos(radians(angle[i]))*radiiX[i];
      py[i] = py[i-1]+sin(radians(angle[i]))*radiiY[i];

      //check collision of body
      if (px[i] >= width-cellRadius[i]/2 || px[i] <= cellRadius[i]/2) {
        radiiX[i]*=-1;
        cellRadius[i] = random(1, 40);
        frequency[i]= random(-13, 13);
      }
      if (py[i] >= height-cellRadius[i]/2 || py[i] <= cellRadius[i]/2) {
        radiiY[i]*=-1;
        cellRadius[i] = random(1, 40);
        frequency[i]= random(-2, 2);
      }
    }
    stroke(list.getDarkest().toARGB(), 100);
    fill(colors[i], 255);

    // draw puff
    ellipse(px[i], py[i], noise(py[i]*0.01)*XRAD, noise(py[i]*0.01)*YRAD);
    // set speed of body
    angle[i]+=frequency[i];
  }

  // set velocity of head
  headX+=speedX;
  headY+=speedY;

  //check boundary collision of head
  if (headX >= width-cellRadius[0]/2 || headX <=cellRadius[0]/2) {
    speedX*=-1;
  }
  if (headY >= height-cellRadius[0]/2 || headY <= cellRadius[0]/2) {
    speedY*=-1;
  }
  if (recording) {
      videoExport.saveFrame();
    }
}
void setupColors() {
   
  ColorTheme t = new ColorTheme("test");
  // add different color options, each with their own weight
  t.addRange("soft ivory", 0.5);
  t.addRange("intense goldenrod", 0.25);
  t.addRange("warm saddlebrown", 0.15);
  t.addRange("fresh teal", 0.05);
  t.addRange("bright yellow", 0.05);

  // now add another random hue which is using only bright shades
  t.addRange(ColorRange.BRIGHT, TColor.newRandom(), random(0.02, 0.05));

  // use the TColortheme to create a list of 160 colors
  list = t.getColors(cells);
}