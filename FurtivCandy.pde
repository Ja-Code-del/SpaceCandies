class FurtivCandy{
 float x,y,speed,len,z,grav;
 color[] col = new color[7];
 color FurtivCandyCol;
   
   FurtivCandy(){
    x = random(-width,width);
    y = random(-height,0);
    z = random(0,10);
    len = map(z, 0, 20, 40, 200);
    speed = map(z, 0, 20, 0.1, 0.5);
    col[0] = #8CC540; //VERT
    col[1] = #00BFFF;// BLEU CIEL
    col[2] = #FFFF00;// JAUNE CITRON
    col[3] = #FF0000; // ROUGE CERISE
    col[4] = #AB8FDA; // VIOLET 
    col[5] = #FF00FF; // FSHIA
    col[6] = #FFA500; // ORANGE 
    FurtivCandyCol = col[round(random(6))];
    grav = map(z, 0, 20, 0, 0.9);
   }
  
  void fall(){
    y += speed;
    x += speed;
    speed += grav;
    
    if(x > width){
    y = random(-200,-100);
    speed = map(z, 0, 20, 0.1, 0.5); 
    }
  }
  
  void show(){
    float thick = map(z, 0, 20, 15, 80);
    strokeWeight(thick);
    stroke(FurtivCandyCol);                //#717B7F);   //#9E9CAA;
    line(x,y,x+len,y+3*len/2);
    noStroke();
    fill(#FFFFFF);
    ellipse(x+len,y+3*len/2,3*thick/4,3*thick/4);
    noStroke();
  }
  
  void resetFurtivCandy(){
   y = random(-500,-50); 
   grav = map(z, 0, 20, 0, 0.5);
  }
  void setFurtivCandySpeed(float $grav, float $speed){
   grav = $grav;
   speed = $speed; 
  }
}
