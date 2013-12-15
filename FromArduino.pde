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

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String[] pieces=new String [2];
  String inString = myPort.readStringUntil('\n');  //read untill (\n) means newline
  pieces =  split(inString,',');
 if (inString != null) {
    // trim off any whitespace:
   // inString = trim(inString);
    // convert to an int and map to the screen height:
   //inStrings[0]; 
     valMp6 = float(pieces[0]);
     valMp5 = float(pieces[1]);
     valMp4 = float(pieces[2]);
     valMp2 = float(pieces[4]);
     valMp3 = float(pieces[5]);
     valMp1 = float(pieces[6]);
     valPin2 = float(pieces[8]);
     valPin2=128-valPin2;
    valPin1 = float(pieces[10]);
     valPin1=17-valPin1;
    valPin4 = float(pieces[12]);
    valPin4=1000-valPin4;
     valPin3 = float(pieces[14]);
     valPin3=1000-valPin3;
 /*   
    print (" pin1: ");
    print(valPin1);
    print (" pin2 ");
    print(valPin2);
     print (" pin3 ");
    print(valPin3);
     print (" pin4 ");
    print(valPin4);
     print (" mp5 ");
    print(valMp5);
     print (" mp6 ");
    print(valMp6);
    println();
   */
 }
}
