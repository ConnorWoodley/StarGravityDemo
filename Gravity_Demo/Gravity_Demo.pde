ArrayList<Planet> planet;
int mass = 1;
float x,y, focusx,focusy;
float tempvelx,tempvely,tempvelhyp,tempang;
boolean freeze = true, deletemode = false;
boolean cameraleft, cameraright, cameraup, cameradown;

/*
Gravity forces only

Equations:
ma = Ft

mass(mtrs/scnd^2) = Fg
mass(pixel/frames^2) = Fg
*/


void setup() {
  planet = new ArrayList<Planet>();
  
  
  size(800,500);
  fullScreen();
  rectMode(CENTER);
  textAlign(CENTER);
  strokeWeight(0);
}//setup

void draw() {
  background(0);
  //x,y,100-x+100
  push();
  fill(255);
  rect(width-100,250,200,800);
  pop();
  
  push();
  fill(0);
  text("mass:" + mass, width-100,50);
  pop();
  
  push();
  translate(width-150,150);
  fill(0);
  text("mass +10", 0,0);
  text("mass -10", 0,100);
  noFill();
  strokeWeight(1);
  stroke(0);
  square(0,0,50);
  square(0,100,50);
  pop();
  
  push();
  translate(width-50,150);
  fill(0);
  text("mass +1", 0,0);
  text("mass -1", 0,100);
  noFill();
  strokeWeight(1);
  stroke(0);
  square(0,0,50);
  square(0,100,50);
  pop();
  
  push();
  translate(width-100,390);
  strokeWeight(0);
  stroke(0);
  fill(255,0,0);
  circle(0,0,160);
  fill(255);
  circle(0,0,150);
  strokeWeight(3);
  line(0,0,tempvelx,tempvely);
  pop();
  
  push();
  translate(width-150,550);
  fill(0);
  text("clear all", 0,0);
  if (deletemode) {text("Del Mode: ON", 100,0);} else{text("Del Mode: OFF", 100,0);}
  noFill();
  strokeWeight(1);
  stroke(0);
  square(0,0,80);
  square(100,0,80);
  pop();
  
  push();
  if (planet.size() > 0) translate(width/2 - focusx, height/2 - focusy);
  for(int i=planet.size()-1; i>=0; i--) {
    Planet pl = planet.get(i);
    pl.planetdraw();
    if (!freeze) {pl.planetcalc();}
  }
  pop();
  
  if (cameraright) {focusx +=10;}
  if (cameraleft) {focusx -=10;}
  if (cameradown) {focusy +=10;}
  if (cameraup) {focusy -=10;}
}//draw


void mousePressed() {
  //Buttons
  if (mouseX > (width-175) && mouseX < (width-125) && mouseY > 125 && mouseY < 175) {mass+=10;}
  if (mouseX > (width-175) && mouseX < (width-125) && mouseY > 225 && mouseY < 275 && mass > 10) {mass-=10;}
  if (mouseX > (width-75) && mouseX < (width-25) && mouseY > 125 && mouseY < 175) {mass++;}
  if (mouseX > (width-75) && mouseX < (width-25) && mouseY > 225 && mouseY < 275 && mass > 1) {mass--;}
  
  if (mouseX > (width-190) && mouseX < (width-110) && mouseY > 510 && mouseY < 590 && planet.size()>0) {for(int i=planet.size()-1;i>=0;i--){planet.remove(i);}}
  if (mouseX > (width-90) && mouseX < (width-10) && mouseY > 510 && mouseY < 590 && !deletemode) {deletemode = true;} else {
  if (mouseX > (width-90) && mouseX < (width-10) && mouseY > 510 && mouseY < 590 && deletemode) {deletemode = false;}}
  
  //Planet Maker
  if (mouseX< width-300 && !deletemode) {planet.add(new Planet(mass,mouseX + (focusx-width/2),mouseY + (focusy-height/2),tempvelx,tempvely,tempang));}
  
  //Planet Remover
  for(int i=0; i<=planet.size()-1; i++) {
    Planet pl = planet.get(i);
    if (dist(pl.x,pl.y,mouseX + (focusx-width/2),mouseY + (focusy-height/2)) < pl.s + 1 && deletemode && mousePressed) {planet.remove(i);}
  }//for
}//mousePressed

void mouseDragged() {
  //Vector Circle
  if (dist(mouseX,mouseY,width-100,390)<80) {
    tempvelhyp = constrain(sqrt(sq(mouseX-(width-100)) + sq(mouseY-390)),-75,75);
    tempang = atan2(mouseY-390,mouseX-(width-100));
    tempvelx = tempvelhyp*cos(tempang);
    tempvely = tempvelhyp*sin(tempang);
  }
}//mouseDragged

void keyPressed() {
  if (key==' ' && freeze) {freeze = false;} else{
  if (key==' ' && !freeze) {freeze = true;}}
  
  if (keyCode==RIGHT) {cameraright = true;}
  if (keyCode==LEFT) {cameraleft = true;}
  if (keyCode==DOWN) {cameradown = true;}
  if (keyCode==UP) {cameraup = true;}
}//keyPressed

void keyReleased() {
  if (keyCode==RIGHT) {cameraright = false;}
  if (keyCode==LEFT) {cameraleft = false;}
  if (keyCode==DOWN) {cameradown = false;}
  if (keyCode==UP) {cameraup = false;}
}//keyReleased
