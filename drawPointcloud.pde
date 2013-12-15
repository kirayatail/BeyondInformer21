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
 
void drawPointCloud(float bottomClip,float heightClip,float rightClip,float widthClip,float frontClip,float debthClip, int res,int ptSize)
{  //draws cloud in colored points
 pointListAll.clear();// get the kinects 3d-data (by reference)
  KinectPoint3D kinect_3d[] = k3d_.get3D();
  Vec3D origo = new Vec3D (0,0,0); 
  int jump = res; // resolution, ... use every fifth point in 3d
  
  Vec3D lookAtRot=new Vec3D(0,0,0);
  
  int cam_w_ = kinectFrame_size_x;
  int cam_h_ = kinectFrame_size_y;
  
  for(int y = 0; y < cam_h_-jump ; y+=jump){
    for(int x = 0; x< cam_w_-jump*2 ; x+=jump){
      int index1 = y*cam_w_+x;
     
      strokeWeight(ptSize);
     // stroke(kinect_3d[index1].getColor() ); //get color from video frame
      float cx = kinect_3d[index1].x*-scaleF;
      float cy = kinect_3d[index1].z*-scaleF; 
      float cz = (kinect_3d[index1].y)*-scaleF;  
       color ptCol = (kinect_3d[index1].getColor());
        int a = (ptCol >> 24) & 0xFF;  // alpha 
        int cr = (ptCol >> 16) & 0xFF;  
        int cg = (ptCol >> 8) & 0xFF;   
        int cb = ptCol & 0xFF;
      stroke(cr,cg,cb); 
      
      
      
      
      Vec3D lookAt = new Vec3D (cx,cy,cz);
   //   pointColor pcLookAt =new pointColor (lookAt,cr,cg,cb);
      float clipDist = lookAt.distanceTo(origo);
      
      /* VERY IMPORTANT!!
      Inside this if-statement, only the points that show up on screen are considered. 
      Put any important point processing here.
      */
      int interestingColor = 0;
      if(bottomClip<cz&&cz<bottomClip+heightClip && rightClip<cx&&cx<rightClip+widthClip  &&  frontClip<cy&&cy<frontClip+debthClip){ 
 
       whiteCount++;
      int total = cr + cg + cb;
      
      float heightBonus = (2.7-cy)*0.2;
      
      if (cr > cg+35 && cr > cb) {
     //   print("Red point: x" +cx+" y"+cy+" z"+cz+" rgb:"+cr+","+cg+","+cb+"\n"); 
        redCount++;
        redCount += heightBonus;
        if(leader == 1){
          interestingColor = 1;
        }  
      } 
      
      if (cb > cg+10 && cb > cr) {
        blueCount++;
        blueCount += heightBonus;
        if(leader == 2){
          interestingColor = 1;
        }
      }
    // point(cx, cy, cz);
     
      lookAtRot=lookAt.getRotatedX(angleX);
      lookAtRot=lookAtRot.getRotatedY(angleY);
      lookAtRot=lookAtRot.getRotatedZ(angleZ);
        lookAt.x=lookAtRot.x+(moveX);
        lookAt.y=lookAtRot.y+(moveY);  
        lookAt.z=lookAtRot.z+(moveZ); 
     
       if(showAll==1 && interestingColor > 0) point(lookAt.x,lookAt.y,lookAt.z);  //drawing the stuff it sees
      pointListAll.add(lookAt);

   }
        //draw the points if they are within 'view box settings/clip planes'
  }
  }
  //////////////////////////////lightDirection arrow
//stroke(255,255,200);
strokeWeight(3);
   line(.05+(0.06*cos(lightAngle)),0.05+(0.06*sin(lightAngle)),0,0.05-(0.06*cos(lightAngle)),0.05-(0.06*sin(lightAngle)),0); // indication line in the corner of thescreen
   strokeWeight(6);
   point(.05+(0.06*cos(lightAngle)),0.05+(0.06*sin(lightAngle)),0); //this is the indication point
   point(plateX*.5+((cos(lightAngle))*2),plateY*.5+((sin(lightAngle))*2),0);
 sun.x=plateX*.5+(cos(lightAngle)*2);
  sun.y=plateY*.5+(sin(lightAngle)*2);
   
//stroke(100,255,100);
strokeWeight(3);
   line(.05+(0.06*cos(flowAngle)),0.05+(0.06*sin(flowAngle)),0,0.05-(0.06*cos(flowAngle)),0.05-(0.06*sin(flowAngle)),0); // indication line in the corner of thescreen
   strokeWeight(6);
   point(.05+(0.06*cos(flowAngle)),0.05+(0.06*sin(flowAngle)),0); //this is the indication point
   point(plateX*.5+((cos(flowAngle))*2),plateY*.5+((sin(flowAngle))*2),0);
 vent.x=plateX*.5+(cos(flowAngle)*2);
  vent.y=plateY*.5+(sin(flowAngle)*2);   
   

}
 void dispose(){
  Kinect.shutDown(); 
  super.dispose();
}
