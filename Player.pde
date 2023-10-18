class Player{
 
  float x;
  float y;
  float w;
  float h;
  float speed;
  int score;
  color playerCol;
 
Player(float X, float Y, float W, float H, float Speed){
   x = X;
   y = Y;
   w = W;
   h = H;
   speed = Speed;
   score = 0;
   playerCol = #2BFAFA;
 }
 
 void showPLayer(){
   rectMode(CENTER);
   //stroke(0);
   fill(#190019);         //#2BFAFA);       //#A79E9C);
   rect(x,y,w,h,75);
 }
 
 void movePlayer(){
  if(keyPressed){
      if(key == CODED){
        if(keyCode == LEFT){
        x -= speed;
        }
       else if (keyCode == RIGHT){
       x += speed;
      }
     }
   } 
 }
 
 void stayInTheCanvas(){
  //Method that check if the pad stay into the canvas
    if(x-w/2 < 0){
      x = w/2;
    }else if(x+w/2 > width){
      x = width - w/2;
    }
  }
  
  // THE SETTERS
 
  void setPlayerPostion(float $x, float $y){
   x = $x;
   y = $y;
  }
  void setPlayerSCore(int $score){
    score = $score;
  }
  
  void setPlayerColor(color $col){
     playerCol = $col; 
  }
  
  void setPlayerLength(float $len){
     w = $len; 
  }
  void setPlayerSpeed(float $speed){
   speed = $speed; 
  }
}
