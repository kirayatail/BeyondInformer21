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

void initOCDCam(){
 cam = new Camera(this,500*(1.75+camMoveX),500*(0.6+camMoveY),500,500*(1.75+camMoveX),500*(0.6+camMoveY),0);
 cam.roll(PI);
 cam.jump(500*(1.2+camMoveX),500*(.6+camMoveY),500*(camMoveZ)); 
 cam.aim(500*(1.2+camMoveX+camCorrectionX),500*(.6+camMoveY+camCorrectionY),0); 
}
 void initOCDCamSide(){
 camSide = new Camera(this, 500,3.2*500,0,   1.2*500,1.2*500,0);
 camSide.roll(PI/2);
}
void initOCDCamFront(){
 camFront = new Camera(this, 3.6*500,300,0,    500,300,0);
 camFront.roll(-PI/2);
}



