//GAME CATCH FALLING CANDIES
//  BY jacquel penah
// Started Sept. 2023

void settings(){
   size(960,540);
   //fullScreen();
   orientation(LANDSCAPE);
   //pixelDensity(2);
   smooth();
}

Candies[] Candy = new Candies[20];
FurtivCandy[] meteor = new FurtivCandy[200];
Player pion;
FuelBar energy;
Button restartButton;
Button resumeButton;
Button exitButton;
Button home;
Button startButton;
Button infoButton;
Button exitButtonFromPause;
Button restartButtonFromPause;



PFont title;
PFont Agbalumo;
PFont Playpen;

color bgColor;
color playerColor;
color CandiesColor;

boolean end;
boolean start;
boolean pause;
boolean info;

float k;
float shortButtonlength;
float longButtonlength;
int record; // the record variable when a new best score occurs
int basicBestScore; // the basic best score which zero
int pScore;// the previous score to compare to the new score and see if there is a new champion


/************ THE SETUP NOW************
*****To initialize many variables and objects*/

void setup(){
 basicBestScore = 0;
 String[] scoreData = loadStrings("data/score.txt"); //load the content of score.txt
 pScore = int(scoreData[0]);// put it in pScore variable
 title = createFont("data/Chewy.ttf",48);
 Agbalumo = createFont("data/Agbalumo.ttf",48);
 Playpen = createFont("data/PlaypenSansLight.ttf",48);
  
 shortButtonlength = 0.304*width;
 longButtonlength = 0.618*width;
  
  //THE BUTTONS////////////////
  restartButton  = new Button("RESTART", 2*width/3, 2*height/3, height/9, #190019, #ffffff,false); //txtColor,x,y,h,btColor,txtColor
  exitButton  = new Button("EXIT GAME",width/6, 5*height/6, height/9, #FC1929, #ffffff, false);//txtColor
  exitButtonFromPause  = new Button("EXIT GAME",width/2, 5*height/6, height/9, #FC1929, #ffffff, false);//txtColor
  home = new Button("BACK HOME", width/2, height/2, height/9, shortButtonlength, #000000, #ffffff, false);
  resumeButton = new Button("RESUME", width/2, height/3, height/9, shortButtonlength, #000000, #FFFFFF, false);
  startButton = new Button("START", width/2, 4*height/6, height/12, longButtonlength, #000000, #FFFFFF, false); //String $text, float $x, float $y, float $h,float $w, color $btColor,color $txtColor
  infoButton = new Button("ABOUT US",width/2,4*height/5,height/12, longButtonlength,#000000,#FFFFFF,false); //String $text, float $x, float $y, float $h,float $w, color $btColor,color $txtColor
  ////////////////////////////////
  
  /*Initialize the Candy*/  
  for(int i = 0; i < Candy.length; i++){
   Candy[i] = new Candies(); 
  }
  for(int i = 0; i < meteor.length; i++){
    meteor[i] = new FurtivCandy();
  }
  /*Initialize the player*/
  pion = new Player(width/2,35*height/36,width/14,height/36,15);
  
  /*Initialize the energy bar*/
  energy = new FuelBar(width,0.5); // The width of the energy bar and the decrease rate
  bgColor = #F3E5AB;     //#FBE4D8;
  playerColor = #A79E9C;
  CandiesColor = #7F00FF;
  
  //booleans initial
  end = false;
  pause = false;
  start = true;
  info = false;
  
  ////////////////////////////////////// 
}


/****************************************************/
/************* the mighty DRAW() method *************/
/***************************************************/
void draw(){
  String[] s = {str(basicBestScore)}; // store the basic best score into the s array
  saveStrings("data/score.txt", s); // save the s array into the file score.txt
  
   ///////////// STARTING PAGE ///////////////////////
 
 if(start && !pause && !info){
  startButton.isActive = true;
  infoButton.isActive = true;
  cursor(ARROW);
  background(#eaeaea);
  startMotion();
 }
 
 /////////// WHEN YOU WANT INFORMATION////////////////
 
 else if(start && !pause && info){
  background(#E6CBBC);
  textAlign(CENTER,CENTER);
  textSize(height/25);
  fill(#ffffff);
  text("Space Candies",width/2,height/6);
   }
 
  ///////////// PAUSE PAGE//////////////
  else if(pause && !start && !info){
  restartButton.setButtonPosition(width/2,2*height/3);
  restartButton.setButtonStyle("SCORE TO ZERO",shortButtonlength,height/9,#FFFF00,#190019);//float $w, float $h, color $btColor, color $txtColor
  
  background(#fefefe);
  fill(#2BFAFA);
  rect(0,0,2*width,2*height);
  //playIcon();
  
 // DISPLAY THE BUTTONS
  resumeButton.displayButton();
  resumeButton.isActive = true;
  home.displayButton();
  exitButtonFromPause.displayButton();
  restartButton.displayButton();
 // DISPLAY THE SCORE AT THE TOP
  fill(#190019);
  textFont(title);
  textSize(width/15);
  text("Score : "+ pion.score,width/2,height/6);
  
  /*if(exitButtonFromPause.isClicked()){
     exit(); 
   }*/
  
  }
  
  ///////GAME PAGE///////////////
  else if(!pause && !start && !info){
  background(bgColor); //#FFF8E5);
  energy.displayFuelBar(); //display the energy bar
  fill(#ffffff);
  rectMode(CENTER);
  rect(width/2,height/7,width/3,height/6,99);
  fill(#2A2E34);
  textFont(title);
  textAlign(CENTER);
  textSize(height/10);
  text(pion.score,width/2,height/6);
  
  /////////////MANAGE THE BEST SCORE STUFF/////////////
  if(pion.score > basicBestScore){ //if the score is grater than the basic score
   basicBestScore = pion.score; // then score become the new basic best Score
  }
  if(pion.score > pScore){ // if the score is greater than the previous score
   record = pion.score; // then score become the record
  }else{
   record = pScore; // ifnot the record stay the previous score 
  }
  
for(Candies i : Candy){  
  energy.fuelBarManager(i);
}
  for(int i = 0; i < Candy.length; i++){
   Candy[i].fall();
   Candy[i].show();
  }
  getTheScore(energy); // increase the score and the energy bar when the Candies ball collapse theplayer
  increaseLength(pion);
  strokeWeight(1);  
  pion.showPLayer();
  pion.movePlayer();
  pion.stayInTheCanvas();
  
  println(startButton.isActive);
  
  if(end){
   gameOver(energy); 
   if(restartButton.isClicked()){
    restart(pion,energy);
   }/*else if(exitButton.isClicked()){
    exit(); 
   } else if(exitButtonFromPause.isClicked()){
     exit();
   }*/
  }
 }
}

/*******E N D  OF  D R A W ***********/

/////// STATIC METHODS NOW///////////

boolean collision(Candies r, Player p) { 
  //fonction boolean qui retourne true si la balle satisfait la condition toucher la racket
    boolean result = false;
    if ((r.x < p.x + p.w/2) && (r.x > p.x - p.w/2) && (r.y+3*r.len/2 > p.y)){
      r.x = random(width);
      r.y = random(-100, -500);
      r.speed = map(r.z, 0, 20, 0.1, 0.3);
      //p.playerCol = r.CandiesCol;
      result = true;
    }else{
    result = false;
    }
    return result;
  }
  
void getTheScore(FuelBar f){
  for(Candies i : Candy){ // for each iCandies :)
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
  for(Candies i : Candy){  
     i.setCandySpeed(0,0);
  }
 f.setDecreaseRate(0);
 
 rectMode(CORNER);
 fill(#2BFAFA);
 rect(0,0,width,height);
 fill(#131313);
 textFont(title);
 textAlign(CENTER,CENTER);
 textSize(100);
 text("GAME OVER",width/2,height/6);
 restartButton.setButtonPosition(5*width/6, 5*height/6);
 restartButton.displayButton();
 exitButton.displayButton();
 //INSERT THE FINAL SCORE HERE 
 // FIND CONDITIONS TO PRINT THE MESSAGE NEW RECORD WHEN THE SCORE IS BETTER THAN THE RECORD VARIABLE
 if(pion.score < pScore){
 fill(#190019);
 textFont(Playpen);
 textSize(width/12);
 text("Score : "+ pion.score,width/2,height/2);
 textFont(title);
 textSize(width/19.42);
 text("Best Score : "+ record,width/2,2*height/3);
 } else if(pion.score > pScore){
 fill(#190019);
 textFont(Playpen);
 textSize(height/4);
 text(record,width/2,height/2);
 textSize(height/6);
 text("Whoa! New record",width/2, 2*height/3);
 }
}

void restart(Player p, FuelBar f){
  end = false;
  p.setPlayerPostion(width/2,35*height/36);
  p.setPlayerLength(width/14);
  p.setPlayerColor(#2BFAFA);
  p.setPlayerSCore(0);
  f.resetFuelBar();
  f.setDecreaseRate(0.1);
  for(Candies i : Candy){  
     i.resetCandies();
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
  fill(#C68FC5);
  translate(-k,k);
  rect(width/2,height/3,width/2,height/4,90); //SHADOW
  popMatrix();
  
  fill(#53266B);
  rectMode(CENTER);
  rect(width/2,height/3,width/2,height/4,90); // REAL RECT
  fill(255);
  textFont(Agbalumo);
  textAlign(CENTER,CENTER);
  textSize(height/10);
  text("Space \nCandies",width/2,height/3); //S P A C E \nC A N D I E S",width/2,height/3);
  
  startButton.displayButton();
  infoButton.displayButton(); 
}

  // UTILISER KEYPRESSED POUR CONTROLLER L'AFFICHAGE DES DIFFERENTES PAGES
  void keyPressed(){
   if(key == ' '){
       pause = !pause; 
       resumeButton.resetButtonPosition();
       home.resetButtonPosition();
   }else if(key == 'x'|| key == 'X'){
    start = false; 
   }else if(key == 'i'|| key == 'I'){
    info = !info; 
   }
  }
  // UTILISATION DE MOUSEPRESSED
  void mousePressed(){
   if(startButton.isClicked()){
     start = false;
     pause = false;
   }else if(infoButton.isClicked()){
     info = true; 
   }else if(resumeButton.isClicked()){
     start = false;
     info = false;
     pause = !pause;
   }else if(home.isClicked()){
     start = true;
     pause = false; 
     info = false;
     restart(pion,energy);
     startButton.resetButtonPosition();
     infoButton.resetButtonPosition();
   }
   /*}else if(exitButtonFromPause.isClicked()){
     exit(); 
   }*/
  }
  
