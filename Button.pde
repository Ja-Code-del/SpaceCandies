class Button {
 String text;
 float x,y,h,w,transCoeff;
 color btColor,txtColor;
 
 //CONSTRUCTOR THAT WIDTH IS SETTED AUTOMATICALLY
  Button(String $text, float $x, float $y, float $h, color $btColor,color $txtColor){
    text = (" "+$text+" ");
    x = $x;
    y = $y;
    h = $h;
    w = 4*textWidth(text); //****//
    btColor = $btColor;
    txtColor = $txtColor;
  }
  
  //CONSTRUCTOR THAT WIDTH CAN BE SET 
  Button(String $text, float $x, float $y, float $h,float $w, color $btColor,color $txtColor){
    text = (" "+$text+" ");
    x = $x;
    y = $y;
    h = $h;
    w = $w;
    btColor = $btColor;
    txtColor = $txtColor;
    transCoeff = 0;
  }
  void displayButton(){
   textFont(title);
   rectMode(CENTER);
   noStroke();
   shadowAnime(); ////Manage the shadow of the button animation
   fill(btColor);
   rect(x,y,w,h,90);
   fill(txtColor);
   textAlign(CENTER,CENTER);
   textSize(25);
   text(text,x,y);
  }
   void shadowAnime(){
     boolean cursorIsOn = ((mouseX >= x-w/2) && (mouseX <= x+w/2) && (mouseY >= y-h/2) && (mouseY <= y+h/2));
     boolean cursorIsOff = !((mouseX >= x-w/2) && (mouseX <= x+w/2) && (mouseY >= y-h/2) && (mouseY <= y+h/2));
     if(cursorIsOn){
      cursor(HAND);
      if(transCoeff < 10){ 
      transCoeff += 0.2;
    }else{
      transCoeff = 10;
      cursor(ARROW);
    }
    pushMatrix();
    fill(128); //shadows color
    translate(-transCoeff,transCoeff);
    rect(x,y,w,h,90);
    popMatrix();
    }
    if(cursorIsOff){
      cursor(ARROW); // SET DEFAULT CURSOR IMAGE
      transCoeff = 0;
    }
  }
  
  boolean isClicked(){
    boolean result = false;
    if(mousePressed && (mouseX >= x-w/2) && (mouseX <= x+w/2) && (mouseY >= y-h/2) && (mouseY <= y+h/2)){
       result = true;
  }
  return result;
}

  void hideButton(){
   x = 10000;
  }
}
