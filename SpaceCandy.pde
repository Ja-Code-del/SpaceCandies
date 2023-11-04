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
Button returnButton;



PFont title;
PFont Agbalumo;
PFont Playpen;
PFont JetBrain;


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
 JetBrain = createFont("data/JetBrainsMono.ttf",32); // for user guide info page
 
  
 shortButtonlength = 0.309*width;
 longButtonlength = 0.618*width;
  
  //THE BUTTONS////////////////
  /*
  >BUTTONS restartButton, exitButton are construct uppon the constructor :
  
  Button(String label, float x, float y, float h, color buttonColor,color labelColor, boolean isActive);
  ::: their width are set automatically by computing the width of the label
  
  >BUTTONS home, resumeButton, startButton, infoButton are built on the constructor :
  
  Button(String label, float x, float y, float h, float w, color buttonColor,color labelColor, boolean isActive);
  ::: their width can be adjust 
  
  >BUTTON returnButton is built on the constructor
   Button(String label, float x, float y, float h, float w, color buttonColor,color labelColor, boolean isActive,String iconUnicode);
   ::: button with a fontAwesome icon
  */
  
  restartButton  = new Button("RESTART", 2*width/3, 2*height/3, height/9, #190019, #ffffff,false); 
  exitButton  = new Button("EXIT GAME",width/6, 5*height/6, height/9, #FC1929, #ffffff, false);
  home = new Button("BACK HOME", width/2, 2*height/3, height/9, shortButtonlength, #000000, #ffffff, false);
  resumeButton = new Button("RESUME", width/2, height/2, height/9, shortButtonlength, #000000, #FFFFFF, false);
  startButton = new Button("START", width/2, 4*height/6, height/12, longButtonlength, #000000, #FFFFFF, false); 
  infoButton = new Button("ABOUT US",width/2,4*height/5,height/12, longButtonlength,#000000,#FFFFFF,false); 
  returnButton = new Button("Return", 3*width/96, 3*height/54, height/12, width/20, #F3E5AB, #503E2C, true,"\uf137");
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
  energy = new FuelBar(width,10); // The width of the energy bar and the decrease rate
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
  //cursor(ARROW);
  background(#eaeaea);
  startMotion();
  //ACTIVATE BUTTON
  startButton.isActive = true;
  infoButton.isActive = true;
  startButton.displayButton();
  infoButton.displayButton(); 
  if(startButton.isClicked()){
     start = false;
  }else if(infoButton.isClicked()){
    info = true;
  }
   startButton.isActive = false;
  infoButton.isActive = false;
 }
 
 /////////// WHEN YOU WANT INFORMATION////////////////
 
 else if(start && !pause && info){
  background(#E6CBBC);
  returnButton.drawIconButton();
  if(returnButton.isClicked()){
   info = !info; 
  }
  textFont(Playpen);
  textAlign(CENTER,CENTER);
  textSize(height/12);
  fill(#ffffff);
  text("Space Candies\n User Guide",width/2,height/6);
   userManuals();
   }
   
  ///////GAME PAGE///////////////
  else if(!start && !pause && !info){
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
  
  //println(startButton.isActive);
  
  if(end){
   gameOver(energy); 
   restartButton.displayButton();
   exitButton.displayButton();
   if(restartButton.isClicked()){
    restart(pion,energy);
   }else if(exitButton.isClicked()){
    exit(); 
   } 
  }
 }
 
  ///////////// PAUSE PAGE//////////////
  else if(pause && !start && !info){
  background(#2BFAFA);
   // DISPLAY THE SCORE AT THE TOP
  fill(#190019);
  textFont(title);
  textSize(width/15);
  text("Your Score is : "+ pion.score,width/2,height/6 );
  textSize(width/25);
  text("Don't give up!",width/2,height/4 );
  //ACTIVATE NEEDED BUTTONS 
  resumeButton.isActive = true;
  //restartButton.isActive = true;
  home.isActive = true;
  //exitButton.isActive = true;
   // DISPLAY THE BUTTONS
  resumeButton.displayButton();
  //restartButton.displayButton();
  home.displayButton();
  //exitButton.displayButton();
  if(resumeButton.isClicked()){
    pause = !pause;
  }else if(home.isClicked()){
   start = !start; 
  }
}
  //////////end OF pause page ///////////
  
  
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

void exit() {
  // Perform any necessary cleanup or saving before the sketch exits
  super.exit();
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
  
  ////////// GAME OVER METHOD TO MANAGE THE END OF THE GAME///////////
void gameOver(FuelBar f){
  exitButton.isActive = true;
  restartButton.isActive = true;
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

////////////RESTART METHOD TO RESTART THE GAME//////////////
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
/////////////THE STARTING ANIMATION///////////////
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
}

 void keyPressed(){
   if(key == ' '){
       pause = !pause; 
       resumeButton.resetButtonPosition();
      // home.resetButtonPosition();
   }else if(key == 'x'|| key == 'X'){
    start = !start; 
   }else if(key == 'i'|| key == 'I'){
    info = !info; 
   }
  }
  
  // UTILISATION DE MOUSEPRESSED
  void mousePressed(){
   if(home.isClicked()){
    println("home is clicked");
    start = true;
    //pause = false;
  }
 }
   
  void userManuals(){
    textSize(height/30);
    textAlign(LEFT,CENTER);
    fill(#503E2C);
    text("Objectives: Catch as many falling candies as possible to increase your score while avoiding raindrops.",width/96,19*height/54);
    text("Controls : -Spacebar: Pause or resume the game.",width/96,22*height/54);
    text("X: Exit the game and return to the start screen.",10*width/96,25*height/54);
    /*text("Controls : -Spacebar: Pause or resume the game.",width/96,22*height/54);
    text("Controls : -Spacebar: Pause or resume the game.",width/96,22*height/54);
    text("Controls : -Spacebar: Pause or resume the game.",width/96,22*height/54);*/
  }
 
  
