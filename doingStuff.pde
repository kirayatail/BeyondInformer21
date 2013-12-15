/* 
Copyright 2013 Stig Anton Nielsen

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
void Balance(ArrayList aList, int r, int g, int b, int dotSize ) {

  Vec3D ptBalanceA1=new Vec3D(0, 0, 0);
  Vec3D ptBalanceA2=new Vec3D(0, 0, 0);
  Vec3D ptBalanceA3=new Vec3D(0, 0, 0);
  Vec3D ptBalanceB1=new Vec3D(0, 0, 0);
  Vec3D ptBalanceB2=new Vec3D(0, 0, 0);
  Vec3D ptBalanceB3=new Vec3D(0, 0, 0);
  Vec3D ptLeastSun=new Vec3D(0, 0, 0);
  Vec3D ptMostSun=new Vec3D(0, 0, 0);
  Vec3D ptLeastFlow=new Vec3D(0, 0, 0);
  Vec3D ptMostFlow=new Vec3D(0, 0, 0);

  //place balance A and B 
  if (valMp1<valMp2&&valMp1<valMp3) { 
    ptBalanceA1=mp1;
    if (valMp2<valMp3) {
      ptBalanceA2=mp2; 
      ptBalanceA3=mp3;
    }
    else { 
      ptBalanceA3=mp3; 
      ptBalanceA2=mp2;
    }
  }

  if (valMp2<valMp1&&valMp2<valMp3) { 
    ptBalanceA1=mp2;
    if (valMp1<valMp3) { 
      ptBalanceA2=mp1; 
      ptBalanceA3=mp3;
    }
    else {
      ptBalanceA3=mp3; 
      ptBalanceA2=mp1;
    }
  }

  if (valMp3<valMp1&&valMp3<valMp2) { 
    ptBalanceA1=mp3;
    if (valMp1<valMp2) { 
      ptBalanceA2=mp1; 
      ptBalanceA3=mp2;
    }
    else {
      ptBalanceA3=mp2; 
      ptBalanceA2=mp1;
    }
  }
  ////////////////////
  if (valMp4<valMp5&&valMp4<valMp6) { 
    ptBalanceB1=mp4;
    if (valMp5<valMp6) {
      ptBalanceB2=mp5; 
      ptBalanceB3=mp6;
    }
    else { 
      ptBalanceB3=mp6; 
      ptBalanceB2=mp5;
    }
  }

  if (valMp5<valMp4&&valMp5<valMp6) { 
    ptBalanceB1=mp5;
    if (valMp4<valMp6) { 
      ptBalanceB2=mp4; 
      ptBalanceB3=mp6;
    }
    else {
      ptBalanceB3=mp6; 
      ptBalanceB2=mp4;
    }
  }

  if (valMp6<valMp4&&valMp6<valMp5) { 
    ptBalanceB1=mp6;
    if (valMp4<valMp5) { 
      ptBalanceB2=mp4; 
      ptBalanceB3=mp5;
    }
    else {
      ptBalanceB3=mp5; 
      ptBalanceB2=mp4;
    }
  }
//least / Most Air Flow//////////////////////////
  if (valPin1>valPin2) { 
    ptLeastFlow=pin1; 
    ptMostFlow=pin2;
  }
  else { 
    ptMostFlow=pin1; 
    ptLeastFlow=pin2;
  }
    float distMostToVent=ptMostFlow.distanceTo(vent);
  float distLeastToVent=ptLeastFlow.distanceTo(vent);
 
  //least / Most Sun////////////////////////////
  if (valPin3>valPin4) { 
    ptLeastSun=pin3; 
    ptMostSun=pin4;
  }
  else { 
    ptMostSun=pin3; 
    ptLeastSun=pin4;
  }

  float distMostToSun=ptMostSun.distanceTo(sun);
  float distLeastToSun=ptLeastSun.distanceTo(sun);
  // println(distMostToSun);
  stroke(r,g,b);
  strokeWeight(dotSize);
    //  print(aList.size());
  for (int i = 0; i < aList.size(); ++i) { ///////////////////BIG FOR LOOP

    Vec3D pt = (Vec3D) aList.get(i);
    float distBalanceA1= pt.distanceTo(ptBalanceA1);
    float distBalanceA2= pt.distanceTo(ptBalanceA2);
    float distBalanceA3= pt.distanceTo(ptBalanceA3);
    float distBalanceB1= pt.distanceTo(ptBalanceB1);
    float distBalanceB2= pt.distanceTo(ptBalanceB2);
    float distBalanceB3= pt.distanceTo(ptBalanceB3);
///////////////
    float distMostFlowToPt= pt.distanceTo(ptMostFlow);
    float distLeastFlowToPt= pt.distanceTo(ptLeastFlow);
    float distVent= pt.distanceTo(vent);
    float distVentToMost=vent.distanceTo(ptMostFlow);
    
    
/*if(pt.z>-1.35&&
distVent<distLeastToVent&&
distLeastFlowToPt-distVent<distLeastToVent*-.5&&
distLeastFlowToPt-distVent<distLeastToVent*.5) 

{point(pt.x, pt.y, pt.z);}
*/


////////////////
///*
    float distMost= pt.distanceTo(ptMostSun);
    float distLeast= pt.distanceTo(ptLeastSun);
    float distSun= pt.distanceTo(sun);
    float differenceSunPtMost= (distMost+distSun)-distMostToSun; //this number increase as the point is less in the line between the sun and the ptMostSun
    float differenceSunPtLeast= (distLeast+distSun)-distLeastToSun; //this number increase as the point is less in the line between the sun and the ptMostSun



 // */  ////////////////////////Balance IF points

    if (pt.z>heightCut&&distBalanceA1>distBalanceA2&&distBalanceA1>distBalanceA3&&distBalanceA1<distBalanceB1) {
                stroke(r,g+40,b);
                   point(pt.x, pt.y, pt.z);
                   stroke(r+30,g+30,b+90);
             if(pt.z>-1.35&&  //////vent
              distMostFlowToPt<.4&&
              distVent-distMostFlowToPt< distVentToMost-.6
              //distMostFlowToPt>.21+distVentToMost*.37
              //distMostFlowToPt<distMostToVent*.3&&distVent<distMostToVent*.8
              ) //////////REMOVE/CHANGE -1.3
              {point(pt.x, pt.y, pt.z);}
              ///////////////
                 
                   ///////////////////// sun IF points
                       if (pt.z>heightCut+.25&& //the -1 is just to see the color when there is nothing build, before build remove the -1. so its 0.062
                            distMost<.5&&  //outer circle distance
                            distMost>.21+differenceSunPtMost*.37&&  //inner circle
                            distSun+.18<distMostToSun&&
                            distLeast>distMost
                            ){   
                              stroke(r+40,g,b);
                          point(pt.x, pt.y, pt.z);
                        }                // V adjust the reflect back on sensor
                         if (pt.z>heightCut+.25&&
                             distLeast>.5-((differenceSunPtLeast*.65))&& //inner cirkel
                             //distLeast>.25&&
                             distLeast<7.5-((differenceSunPtLeast*9))&&  //outer circle distance
                              distSun>distLeastToSun*.96&&
                              distLeast<distMost
                             ) {  
                               stroke(r,g,b+40);
                          point(pt.x, pt.y, pt.z);
                        }////////////////////////////
      
    }
    if (pt.z>heightCut&&distBalanceB1>distBalanceB2&&distBalanceB1>distBalanceB3&&distBalanceB1<distBalanceA1) {
         stroke(r,g+40,b);
      point(pt.x, pt.y, pt.z);
      stroke(r+30,g+30,b+90);
             if(pt.z>-1.35&&  //////vent
              distMostFlowToPt<.4&&
              distVent-distMostFlowToPt< distVentToMost-.6
              //distMostFlowToPt>.21+distVentToMost*.37
              //distMostFlowToPt<distMostToVent*.3&&distVent<distMostToVent*.8
              ) //////////REMOVE/CHANGE -1.3
              {point(pt.x, pt.y, pt.z);}
                            ///////////////////// sun IF points
                 if (pt.z>heightCut+.25&& //the -1 is just to see the color when there is nothing build, before build remove the -1. so its 0.062
                      distMost<.5&&  //outer circle distance
                      distMost>.21+differenceSunPtMost*.37&&  //inner circle
                      distSun+.18<distMostToSun&&
                      distLeast>distMost
                      ){   
                        stroke(r+40,g,b);
                    point(pt.x, pt.y, pt.z);
                  }                // V adjust the reflect back on sensor
                   if (pt.z>heightCut+.25&&
                       distLeast>.5-((differenceSunPtLeast*.65))&& //inner cirkel
                       //distLeast>.25&&
                       distLeast<7.5-((differenceSunPtLeast*9))&&  //outer circle distance
                        distSun>distLeastToSun*.96&&
                        distLeast<distMost
                       ) {  
                         stroke(r,g,b+40);
                    point(pt.x, pt.y, pt.z);
                  }
   
    }
    ////////////////////////////
  }
  //points to cover the lightSensors
  strokeWeight(70);
  stroke(0,0,0);
  point(pin3.x,pin3.y,0);
  point(pin4.x,pin4.y,0);
  point(pin3.x+.01,pin3.y-.02,0.2);
  point(pin4.x-.02,pin4.y+.03,0.2);
  point(pin3.x+.02,pin3.y-.03,0.4);
  point(pin4.x-.03,pin4.y+.05,0.4);
   point(pin3.x+.05,pin3.y-.03,0.6);
  point(pin4.x-.01,pin4.y+.06,0.6);
/////////////Blocking for the air flow text
 stroke(0);
strokeWeight(190);
point(pin1.x+.04,pin1.y+.05,0.59);
point(pin2.x-.06,pin2.y,0.59);
}

