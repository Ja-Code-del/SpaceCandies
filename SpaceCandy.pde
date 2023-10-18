/*JEU D'OBJET A EVITER
 ET QUI TOMBE DU CIEL************/

Rain[] rains = new Rain[70];
Player pion;
FuelBar energy;
Button restartButton;
PImage wallpaper;
PFont nasa;
PFont fontForEnd;
color bgColor;
color playerColor;
color rainColor;
boolean end;
boolean start;
boolean pause;
boolean info;
void setup(){
  size(960,540);
  wallpaper = loadImage("space.jpg");
  nasa = createFont("nasaFont.ttf",100);
  fontForEnd = createFont("HelveticaNeue", 70);
  restartButton  = new Button("Restart",width/2,2*height/3,40); //text x y h
  /*Initialize the rains*/  
  for(int i = 0; i < rains.length; i++){
   rains[i] = new Rain(); 
  }
  /*Initialize the player*/
  pion = new Player(width/2,35*height/36,width/14,height/36,8);
  
  /*Initialize the energy bar*/
  energy = new FuelBar(width,0.1);
  bgColor = #F3E5AB;     //#FBE4D8;
  playerColor = #A79E9C;
  rainColor = #7F00FF;
  
  //booleans initial
  end = false;
  pause = false;
  start = true;
  info = false;
}

void draw(){
  
  /********** When you press "pause"********/
  background(#fefefe);
  fill(#2BFAFA);
  rect(0,0,2*width,2*height);
  playIcon();
  pushMatrix();
  translate(-10,10);
  fill(128);
  rect(width/2,4*height/5,500,60,75);
  popMatrix();
  fill(#190019);
  rectMode(CENTER);
  rect(width/2,4*height/5,500,60,75);
 
  textSize(height/15);
  textAlign(CENTER,CENTER);
  fill(#FFFFFF);
  text("\"Press space bar to resume\"",width/2,4*height/5);
  fill(#190019);
  textFont(fontForEnd);
  textSize(width/21);
  text("Score : "+ pion.score,width/2,height/6);
 
 ///////////// STARTING PAGE ///////////////////////
 
 if(start && !pause && !info){
  background(0);
  wallpaper.resize(width,height);
  image(wallpaper,0,0);
  textSize(height/25);
  textAlign(CENTER,CENTER);
  fill(#ffeeff);
  text("\"Press 'X' to start\"",width/2,4*height/5);
  text("\"Press 'i' to see ho to play\"",width/2,2*height/3);
 
 /////////// WHEN YOU WANT INFORMATION////////////////
 
 if(info == true){
  background(#E6CBBC);
  textAlign(CENTER,CENTER);
  textSize(height/25);
  fill(#ffffff);
  text("Space Candy",width/2,height/6);
   }
 }
  
  /***** What you see when the game is on means when you press x*/
  if(!pause && !start && !info){
  background(bgColor); //#FFF8E5);
  energy.displayFuelBar(); //display the energy bar
  fill(#ffffff);
  rectMode(CENTER);
  rect(width/2,50,200,100);
  fill(#2A2E34);
  textFont(nasa);
  textAlign(CENTER,CENTER);
  textSize(80);
  text(pion.score,width/2,70);
  
for(Rain i : rains){  
  energy.fuelBarManager(i);
}
  for(int i = 0; i < rains.length; i++){
   rains[i].fall();
   rains[i].show();
  }
  getTheScore(energy); // increase the score and the energy bar when the rain ball collapse theplayer
  increaseLength(pion);
  strokeWeight(1);  
  pion.showPLayer();
  pion.movePlayer();
  pion.stayInTheCanvas();
  
  if(end){
   gameOver(energy); 
  }
  
  if(restartButton.isClicked()){
    restart(pion,energy);
  }
 }
}

/*******E N D  OF  D R A W ***********/


boolean collision(Rain r, Player p) { 
  //fonction boolean qui retourne true si la balle satisfait la condition toucher la racket
    boolean result = false;
    if ((r.x < p.x + p.w/2) && (r.x > p.x - p.w/2) && (r.y+3*r.len/2 > p.y)){
      r.x = random(width);
      r.y = random(-100, -500);
      r.speed = map(r.z, 0, 20, 0.1, 0.3);
      //p.playerCol = r.rainCol;
      result = true;
    }else{
    result = false;
    }
    return result;
  }
  
void getTheScore(FuelBar f){
  for(Rain i : rains){ // for each iRain :)
    if(collision(i,pion)){
      pion.score++;
      f.w += 0.2;
    }
  }
}

void increaseLength(Player p){
 if(p.score == 10){
    p.w = 73;   
   }else if(p.score == 20){
    p.w = 83; 
   }else if(p.score == 40){
    p.w = 103; 
   }
}
  
void gameOver(FuelBar f){
  for(Rain i : rains){  
     i.setRainSpeed(0,0);
  }
  f.setDecreaseRate(0);
 rectMode(CORNER);
 fill(#2BFAFA);
 rect(0,0,width,height);
 fill(#131313);
 textFont(nasa);
 textAlign(CENTER,CENTER);
 textSize(100);
 text("GAME OVER",width/2,height/6);
 restartButton.displayButton();
 //INSERER LE SCORE FINAL ICI AVEC LE FONT FONTFOR END
 textFont(fontForEnd);
 textSize(30);
 text("Score : "+ pion.score,width/2,height/2);
}

void restart(Player p, FuelBar f){
  end = false;
  p.setPlayerPostion(width/2,35*height/36);
  p.setPlayerLength(width/14);
  p.setPlayerColor(#2BFAFA);
  p.setPlayerSCore(0);
  f.resetFuelBar();
  f.setDecreaseRate(0.1);
  for(Rain i : rains){  
     i.resetRain();
     f.fuelBarManager(i);
  }
}

void playIcon(){
  pushMatrix();
  noStroke();
  translate(-10,15);
  fill(128);
  triangle(2*width/5,height/3,9*width/15,height/2,2*width/5,2*height/3);
  popMatrix();
  fill(#190019);
  triangle(2*width/5,height/3,9*width/15,height/2,2*width/5,2*height/3);
}
  // UTILISER KEYPRESSED POUR CONTROLLER L'AFFICHAGE DES DIFFERENTES PAGES
  void keyPressed(){
   if(key == ' '){
       pause = !pause; 
   } else if(key == 'x'|| key == 'X'){
    start = false; 
   }else if(key == 'i'|| key == 'I'){
    info = !info; 
   }
  }