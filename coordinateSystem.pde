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

void coordinateSystem(){

 
  //first the cornerlines
strokeWeight(4);

stroke(255,255,255);
line(0,plateY,0,plateX,plateY,0);
line(plateX,0,0,plateX,plateY,0);

line(0,0,0,plateX,0,0);
line(0,0,0,0,plateY,0);
stroke(255,0,0);
line(0,0,0,0,0,.4);
stroke(0,255,0);
line(plateX,0,0,plateX,0,.4);
stroke(255,255,255);
line(plateX,plateY,0,plateX,plateY,.4);
stroke(0,0,255);
line(0,plateY,0,0,plateY,.4);
stroke(255,255,255);
/*stroke(90,90,90);
for (float i=0;i<plateX;i=i+.15){
if(i<1.21)line(0,i,0,  2.4,i,0);
line(i,0,0,  i,1.2,0);

}*/
/*
strokeWeight(8);
point(.44,.255,0); //mp3
point(.635,.255,0); //mp1
point(.535,.42,0);  //mp2

point(1.323,.76,0); //mp4
point(1.513,.76,0); //mp5
point(1.42,.93,0); //mp6
stroke(0,255,0);
*/
strokeWeight(0);

/*Vec3D mp1=new Vec3D(.44,.225,0); //mp1 
Vec3D mp2=new Vec3D(.635,.225,0);  //mp2
Vec3D mp3=new Vec3D (.535,.42,0); //mp3
Vec3D mp4=new Vec3D(1.323,.76,0); //mp4
Vec3D mp5=new Vec3D(1.513,.76,0); //mp5
Vec3D mp6=new Vec3D(1.42,.93,0); //mp6
*/

}
