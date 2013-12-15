/* 
Copyright 2013 Stig Anton Nielsen
Modifications done by Axel Pelling & Max Witt 2013

This file is part of BeyondInformer21.

    BeyondInformer21 is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    BeyondInformer21 is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with BeyondInformer21.  If not, see <http://www.gnu.org/licenses/>.

 */

import processing.serial.*;
import damkjer.ocd.*;
import processing.opengl.*;
import dLibs.freenect.toolbox.*;
import dLibs.freenect.constants.*;
import dLibs.freenect.interfaces.*;
import dLibs.freenect.*;
import toxi.geom.*;
import controlP5.*;
//---------------------------------------------------IMPORTS--
PFont skrifttype;
Kinect kinect_;                     // main kinect-object
KinectFrameVideo kinect_video_;     // video frame
KinectFrameDepth kinect_depth_;     // depth frame
Kinect3D k3d_;
int kinectFrame_size_x = VIDEO_FORMAT._RGB_.getWidth();   // width of kinect frame
int kinectFrame_size_y = VIDEO_FORMAT._RGB_.getHeight();  // height of kinect frame
Camera cam;  
Camera camSide;
Camera camFront;
///////////////////////////////////// The serial port
import processing.serial.*;
Serial myPort;        
/////////////////////////////////Other Variables
float scaleF=1.01;
float plateX=1.96;
float plateY=1.22;
float kinectEdge=0.15;
float bottomTrim = 0.2;
float heightTrim = 0;
float leftTrim = 0;
float rightTrim = 0;
float valMp1=0;
float valMp2=0;
float valMp3=0;
float valMp4=0;
float valMp5=0;
float valMp6=0;
float valPin1=0;
float valPin2=0;
float valPin3=0;
float valPin4=0;
ArrayList pointListAll;
ArrayList sensorsAll;
/////////////SETTINGS
float rotX;
float rotY;
float rotZ;        
float moveX;
float moveY;
float moveZ;
float lightA;
float camCorrX;
float camCorrY;
float camZ;
float camX;
float camY;
float hCut;
//////////////
String info[] = new String[17];
//////////////Sensor POSITIONS
Vec3D ptMove = new Vec3D(0, 0, 0);
Vec3D mp1=new Vec3D(.44, .225, 0); //mp1 
Vec3D mp2=new Vec3D(.635, .225, 0);  //mp2
Vec3D mp3=new Vec3D (.535, .42, 0); //mp3
Vec3D mp4=new Vec3D(1.323, .76, 0); //mp4
Vec3D mp5=new Vec3D(1.513, .76, 0); //mp5
Vec3D mp6=new Vec3D(1.42, .93, 0); //mp6
Vec3D pin1=new Vec3D(.05, 0.06, 0);
Vec3D pin2=new Vec3D(1.54, 0.06, 0);
Vec3D pin3=new Vec3D(.84, .765, 0);
Vec3D pin4=new Vec3D(.84, 1.1, 0);
Vec3D sun=new Vec3D(0, 0, 2.3);
Vec3D vent=new Vec3D(0, 0, .5);

///////////////Snake variables

int whiteCount = 0;
float redCount= 0;
float blueCount= 0;
int leader = 0;
Timer timer;
///////////////////////////////////SETUP///////////////////////////////
void setup() {
  size(1660, 1015, OPENGL);
  skrifttype =loadFont("SwissFont.vlw");
  textFont(skrifttype);
  textSize(.017);
  // textMode(SCREEN);
  //size(kinectFrame_size_x, kinectFrame_size_y, OPENGL);
  kinect_ = new Kinect(0);  //create a main kinect instance with index 0
  kinect_video_ = new KinectFrameVideo(VIDEO_FORMAT._RGB_);    // create a video instance
  kinect_depth_ = new KinectFrameDepth(DEPTH_FORMAT._11BIT_);  // create a depth instance

  k3d_ = new Kinect3D(); // generate a 3d instance
  k3d_.setFrameRate(30); // set framerate
  kinect_video_.connect(kinect_);  //connect the created video instance to the main kinect
  kinect_depth_.connect(kinect_);  //connect the created depth instance to the main kinect
  k3d_.connect(kinect_);
  //////////////////////////////////////////////PortArduino
  myPort = new Serial(this, "COM5", 9600);
  myPort.bufferUntil('\n');

  /////////////////////////////////////////////////read Rotations

  String[] settingLines = loadStrings("rotations.txt");
  // for(int i = 0; i < settingLines.length; ++i){
  //String[] pieces = split(lines[0], ',');
  rotX = float(settingLines[0]) ;
  rotY = float(settingLines[1]) ;
  rotZ = float(settingLines[2]) ;
  moveX = float(settingLines[3]) ;
  moveY = float(settingLines[4]) ;
  moveZ = float(settingLines[5]) ;
  lightA= float(settingLines[6]);
  camCorrX=float(settingLines[7]);
  camCorrY=float(settingLines[8]);
  camX=float(settingLines[9]);
  camY=float(settingLines[10]);
  camZ=float(settingLines[11]);
  hCut=float(settingLines[12]);
  heightTrim=float(settingLines[13]);
  bottomTrim=float(settingLines[14]);
  leftTrim=float(settingLines[15]);
  rightTrim=float(settingLines[16]);


  angleX=rotX;
  angleY=rotY;
  angleZ=rotZ;
  lightAngle=lightA;
  camCorrectionX=camCorrX;
  camCorrectionY=camCorrY;
  camMoveZ=camZ;
  camMoveX=camX;
  camMoveY=camY;
  heightCut=hCut;
  topClip = heightTrim;
  bottomClip = bottomTrim;
  leftClip = leftTrim;
  rightClip = rightTrim;

  ////////////////////////////////////////////////Kinect
  initOCDCam();
  initOCDCamSide();
  initOCDCamFront();

  GUIsetup();
  pointListAll = new ArrayList();

  sun.x=plateX*.5+(1*cos(lightAngle));
  sun.y=plateY*.5+(1*sin(lightAngle));

  showAll = 1;
  timer = new Timer(300000);
  timer.start();
}
///////////////////////////////////DRAW///////////////////////////////
void draw () {

  scale(500); // to scale the scene (original units are in meters)
  background(0);
  
heightTrim = topClip;
bottomTrim = bottomClip;
leftTrim = leftClip;
rightTrim = rightClip;
  //bottomClip / heightClip / rightClip / widthClip / frontClip / debthClip/ res / ptSize)
  drawPointCloud((plateY*-.5)+kinectEdge+bottomTrim, plateY+kinectEdge*2+heightTrim, -plateX*.5-kinectEdge+rightTrim, plateX+kinectEdge*2+leftTrim, 0, 6, 3, 14);
  coordinateSystem();
  
  if(redCount > blueCount) {
    leader = 1; // Red is 1
  } else {
    leader = 2;
  }
  
  print("Red count: " + ((int)redCount) + "\n");
  print("Blue count: " + ((int)blueCount) + "\n");
  

  textSize(0.06);
  //text("Start in ", pin3.x, pin3.y, 1.0);
  
  if(!timer.isFinished()) {
    textSize(0.04);
    text("Time left: " + -timer.getPassedTime() / 1000, pin4.x, pin4.y+0.1, 0);
    println("Time left: " + -timer.getPassedTime() / 1000);
  }
  
  if(timer.isFinished()) {
    textSize(0.08);
    text("Time's up!", pin4.x, pin4.y, 0);
    
    if(blueCount > redCount)
      text("Blue wins with " + ((int)blueCount) + " points", pin1.x+.35, pin4.y+.1, 0);
    else if(blueCount < redCount)
      text("Red wins with " + ((int)redCount) + " points", pin1.x+.35, pin4.y+.1, 0);
    else
     text("The game is a draw with " + ((int)blueCount) + " points each", pin1.x, pin4.y+.1, 0);
  }

  textSize(.040);
  text("Red count: " + ((int)redCount), pin1.x, pin1.y, 0);
  text("Blue count: " + ((int)blueCount), pin2.x, pin2.y, 0);

  whiteCount = 0;
  redCount = 0;
  blueCount = 0;


  if (cams==0)cam.feed();
  if (cams==1)camSide.feed();
  if (cams==2)camFront.feed();
}
void keyPressed() {

  if (key=='s') {
    info[0]=angleX+"";
    info[1]=angleY+"";
    info[2]=angleZ+"";
    info[3]=moveX+"";
    info[4]=moveY+"";
    info[5]=moveZ+"";
    info[6]=lightAngle+"";
    info[7]=camCorrectionX+"";
    info[8]=camCorrectionY+"";
    info[9]=camMoveX+"";
    info[10]=camMoveY+"";
    info[11]=camMoveZ+"";
    info[12]=heightCut+"";
    info[13]=topClip+"";
    info[14]=bottomClip+"";
    info[15]=leftClip+"";
    info[16]=rightClip+"";


    saveStrings("rotations.txt", info );
  }

  if (key=='c') {
    // cam.jump(500*(.325+camMoveX),500*(.275+camMoveY),500*(camMoveZ)); 
    //cam.aim(500*(.325+camMoveX),500*(.275+camMoveY+camCorrection),0); 
    cam.jump(500*(1.2+camMoveX), 500*(.6+camMoveY), 500*(camMoveZ)); 
    cam.aim(500*(1.2+camMoveX+camCorrectionY), 500*(.6+camMoveY+camCorrectionX), 0);
  }
  if (key=='-') {
    if (cams==0) cam.zoom(.005);
    if (cams==1) camSide.zoom(.01);
    if (cams==2) camFront.zoom(.01);
  }
  if (key=='+') {
    if (cams==0) cam.zoom(-.01);
    if (cams==1) camSide.zoom(-.01);
    if (cams==2) camFront.zoom(-.01);
  }
}

