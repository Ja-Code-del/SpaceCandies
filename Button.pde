class Button {
 String text;
 float x,y,h,w;
  Button(String $text, float $x, float $y, float $h){
    text = (" "+$text+" ");
    x = $x;
    y = $y;
    h = $h;
    w = 4*textWidth(text);
    
  }
  void displayButton(){
   //float k = textWidth(text);
   pushMatrix();
   fill(120);
   translate(-10,10);
   rect(x,y,w,h,75);
   popMatrix();
   fill(#FFFFFF);
   stroke(#202124);
   rectMode(CENTER);
   rect(x,y,w,h,75);
   fill(#000000);
   textAlign(CENTER,CENTER);
   textSize(25);
   //textSize(9*h/10);
   text(text,x,y);
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
