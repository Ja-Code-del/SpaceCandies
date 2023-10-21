/*JEU D'OBJET A EVITER
 ET QUI TOMBE DU CIEL************/

Rain[] rains = new Rain[170];
FurtivCandy[] meteor = new FurtivCandy[100];
Player pion;
FuelBar energy;
Button restartButton;
Button resumeButton;
Button quitButton;
Button exitGame;
Button startButton;
Button infoButton;

PFont nasa;
PFont fontForEnd;
PFont title;

color bgColor;
color playerColor;
color rainColor;

boolean end;
boolean start;
boolean pause;
boolean info;

float k;

/************ THE SETUP NOW************
*****To initialize many variables and objects*/

void setup(){
  size(960,540);
  nasa = createFont("nasaFont.ttf",100);
  fontForEnd = createFont("HelveticaNeue", 70);
  title = createFont("Chewy.ttf",48);
  restartButton  = new Button("RESTART",2*width/3,2*height/3,60,#1FFF2F,#ffffff); //text x y h
  quitButton  = new Button("QUIT",width/3,2*height/3,60,#FC1929,#ffffff);
  exitGame = new Button("EXIT GAME",width/4,4*height/5,60,#FC1929,#ffffff);
  resumeButton = new Button("RESUME",3*width/4,4*height/5,width/12,#000000,#FFFFFF);
  startButton = new Button("START",width/2,4*height/6,height/12,0.618*width,#000000,#FFFFFF); //String $text, float $x, float $y, float $h,float $w, color $btColor,color $txtColor
  infoButton = new Button("ABOUT US",width/2,4*height/5,height/12,0.618*width,#000000,#FFFFFF); //String $text, float $x, float $y, float $h,float $w, color $btColor,color $txtColor
  /*Initialize the rains*/  
  for(int i = 0; i < rains.length; i++){
   rains[i] = new Rain(); 
  }
  for(int i = 0; i < meteor.length; i++){
    meteor[i] = new FurtivCandy();
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

/****************************************************/
/************* the mighty DRAW() method *************/
/***************************************************/
void draw(){
  
  /********** When you press "pause"********/
  background(#fefefe);
  fill(#2BFAFA);
  rect(0,0,2*width,2*height);
  playIcon();
  resumeButton.displayButton();
  exitGame.displayButton();
 /* pushMatrix();
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
  text("\"Press space bar to resume\"",width/2,4*height/5);*/
  fill(#190019);
  textFont(fontForEnd);
  textSize(width/21);
  text("Score : "+ pion.score,width/2,height/6);
 
 ///////////// STARTING PAGE ///////////////////////
 
 if(start && !pause && !info){
  background(#eaeaea);
  startMotion();
 }
 /////////// WHEN YOU WANT INFORMATION////////////////
 
 if(start && !pause && info){
  background(#E6CBBC);
  textAlign(CENTER,CENTER);
  textSize(height/25);
  fill(#ffffff);
  text("Space Candy",width/2,height/6);
   }
 
  
  /***** What you see when the game is on means when you press x or clic on start*/
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

/////// STATIC METHODS NOW///////////



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
 quitButton.displayButton();
 //INSERER LE SCORE FINAL ICI AVEC LE FONT FONTFOR END
 fill(#190019);
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

void startMotion(){
  if(k < 10){
   k += 0.25; 
  }
  for(int i = 0; i < meteor.length; i++){
    meteor[i].show();
    meteor[i].fall();
  }
  noStroke();
  //THE SHADOW FIRST
  pushMatrix();
  fill(0);
  translate(-k,k);
  rect(width/2,height/3,width/2,height/4,90); //SHADOW
  
  popMatrix();
  
  fill(255);
  rectMode(CENTER);
  rect(width/2,height/3,width/2,height/4,90); // REAL RECT
  fill(0);
  textFont(title);
  textAlign(CENTER,CENTER);
  textSize(height/10);
  text("S P A C E \nC A N D I E S",width/2,height/3);
  
  startButton.displayButton();
  infoButton.displayButton();
  
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
  // UTILISATION DE MOUSEPRESSED
  void mousePressed(){
   if(startButton.isClicked()){
     start = false;
   }else if(infoButton.isClicked()){
    info = true; 
   }
  }
