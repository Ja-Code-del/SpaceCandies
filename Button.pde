class Button {
 String label;
 float x,y,h,w,transCoeff;
 color buttonColor,labelColor;
 boolean isActive;
 String iconUnicode;
 PFont fontAwesome;
 
 //DEFAULT CONSTRUCTOR
 Button(){
   
 }
 
 //CONSTRUCTOR THAT WIDTH IS SETTED AUTOMATICALLY
  Button(String $text, float $x, float $y, float $h, color $buttonColor,color $txtColor,boolean $status){
    label = (" "+$text+" ");
    x = $x;
    y = $y;
    h = $h;
    w = 4*textWidth(label); //****//
    buttonColor = $buttonColor;
    labelColor = $txtColor;
    isActive = $status;
  }
  
  //CONSTRUCTOR THAT WIDTH CAN BE SET 
  Button(String $text, float $x, float $y, float $h,float $w, color $buttonColor,color $txtColor, boolean $status){
    label = (" "+$text+" ");
    x = $x;
    y = $y;
    h = $h;
    w = $w;
    buttonColor = $buttonColor;
    labelColor = $txtColor;
    transCoeff = 0;
    isActive = $status;
  }
  
  //FOR BUTTON WITH ICONS
  Button(String $text, float $x, float $y, float $h,float $w, color $btColor,color $txtColor,boolean $status, String $iconUnicode){
    label = (" "+$text+" ");
    x = $x;
    y = $y;
    h = $h;
    w = $w;
    buttonColor = $btColor;
    labelColor = $txtColor;
    isActive = $status;
    fontAwesome = createFont("data/FontAwesomeSolid900.otf",32);
    iconUnicode = $iconUnicode;
  }
  
  void displayButton(){
   if(isActive){
   rectMode(CENTER);
   noStroke();
   shadowAnime(); ////Manage the shadow of the button animation
   fill(buttonColor);
   rect(x,y,w,h,90);
   fill(labelColor);
   textAlign(CENTER,CENTER);
   textSize(25);
   text(label,x,y);
   }else{
    println("ERROR : this button is not active, please set isActive parameter to 'true' "); 
   }
  }
  
  void drawIconButton(){
   if(isActive){
   fill(buttonColor);
   //rectMode(CENTER);
   rect(x,y,w,h,90);
   fill(labelColor);
   textFont(fontAwesome);
   textAlign(CENTER,CENTER);
   text(iconUnicode,x,y);
   textSize(height/36);
   text(label,x+w+width/96,y);
   }else{
     println("ERROR : Icon button is not active, please set isActive parameter to 'true' "); 
   }
  }
  
   void shadowAnime(){
     boolean cursorIsOn = ((mouseX >= x-w/2) && (mouseX <= x+w/2) && (mouseY >= y-h/2) && (mouseY <= y+h/2));
     boolean cursorIsOff = !((mouseX >= x-w/2) && (mouseX <= x+w/2) && (mouseY >= y-h/2) && (mouseY <= y+h/2));
     if(cursorIsOn){
      cursor(HAND); //set the cursor image on hand
      if(transCoeff < 10){ 
      transCoeff += 0.3;
    }else{
      transCoeff = 10;
    }
    pushMatrix();
    fill(128); //shadows color
    translate(-transCoeff,transCoeff);
    rect(x,y,w,h,90);
    popMatrix();
    }
    if(cursorIsOff){
      transCoeff = 0;
    }
  }
  
  void setButtonPosition(float $x,float $y){
    x = $x;
    y = $y;
  }
  
  void setButtonStyle(String text,float $w, float $h, color $buttonColor, color $txtColor){ // to set a different style or the style you want, mean dimensions and colors
    w = $w;
    label = text;
    h = $h;
    buttonColor = $buttonColor;
    labelColor = $txtColor;
  }
 
 boolean isClicked(){ // method that listen event and return true if a button is clicked
   boolean result = false;
    if(mousePressed && (mouseX >= x-w/2) && (mouseX <= x+w/2) && (mouseY >= y-h/2) && (mouseY <= y+h/2)){
       result = true;
    }else{
   result =  false; 
  }
  return result;
 }

 void resetButtonPosition(){ // to give to the button its initial position
  if(w == longButtonlength){
    h = height/12;
  }else if(w < longButtonlength){
    h = height/9;
  }
 }


 void getCopyOf(Button b){
 label = b.label;
 x = b.x;
 y = b.y;
 h = b.h; 
 w = b.w;
 buttonColor = b.buttonColor;
 labelColor = b.labelColor;
}

 }
