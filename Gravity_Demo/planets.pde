class Planet {
  float x,y,velx,vely,velhyp,m,s,angle;
  boolean remove;
  Planet( float assignedmass, float tempx, float tempy, float tempvelx, float tempvely, float tempang){
    m = assignedmass*5;
    s = sqrt(assignedmass);
    x = tempx;
    y = tempy;
    velx = tempvelx/75;
    vely = tempvely/75;
  }//constructor
  
  void planetdraw(){
    fill((10/m)*255);
    stroke(255);
    strokeWeight(1);
    circle(x,y,s);
  }//planetdraw
  
  void planetcalc(){
    x+=velx;
    y+=vely;
    
    /*(velx) = G(m2)/r^2
    1 pixel = 100m
    1 mass = 5
    */
    
    for(int i=planet.size()-1; i>=0; i--) {
      Planet pl = planet.get(i);
      if (dist(x,y,pl.x,pl.y) > 0) {
      velhyp = sqrt(sq(y-pl.y) + sq(x-pl.x));
      angle = atan2(pl.y-y,pl.x-x);
      
      velx += (velhyp*cos(angle)*pl.m) / (sq(dist(x,y,pl.x,pl.y)*100));
      vely += (velhyp*sin(angle)*pl.m) / (sq(dist(x,y,pl.x,pl.y)*100));
      }//if
    }//for
  }//planetcalc
}//Class