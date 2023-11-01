class Candies{
 float x,y,speed,len,z,grav;
 color[] col = new color[7];
 color CandiesCol;
   Candies(){
    x = random(width);
    y = random(-500,0);
    z = random(0,20);
    len = map(z, 0, 20, 40, 50);
    speed = map(z, 0, 20, 0.1, 0.5);
    col[0] = #8CC540; //VERT
    col[1] = #00BFFF;// BLEU CIEL
    col[2] = #FFFF00;// JAUNE CITRON
    col[3] = #FF0000; // ROUGE CERISE
    col[4] = #AB8FDA; // VIOLET 
    col[5] = #FF00FF; // FSHIA
    col[6] = #FFA500; // ORANGE 
    CandiesCol = col[round(random(6))];
    grav = map(z, 0, 20, 0, 0.008);
   }
  
  void fall(){
    y += speed;
    speed += grav;
    
    if(y > height){
    y = random(-200,-100);
    speed = map(z, 0, 20, 0.1, 0.3); 
    }
  }
  
  void show(){
    float thick = map(z, 0, 20, 5, 30);
    strokeWeight(1.2*thick);
    stroke(#0000FF);
    line(x,y,x,y+3*len/2);
    strokeWeight(thick);
    stroke(CandiesCol);                //#717B7F);   //#9E9CAA;
    line(x,y,x,y+3*len/2);
    noStroke();
    fill(#FFFFFF);
    ellipse(x,y+3*len/2,3*thick/4,3*thick/4);
    noStroke();
  }
  
  void resetCandies(){
   y = random(-500,-50); 
   grav = map(z, 0, 20, 0, 0.008);
  }
  void setCandySpeed(float $grav, float $speed){
   grav = $grav;
   speed = $speed; 
  }
}
