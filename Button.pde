class Button {
 String text;
 float x,y,h,w;
 color btColor,txtColor;
  Button(String $text, float $x, float $y, float $h, color $btColor,color $txtColor){
    text = (" "+$text+" ");
    x = $x;
    y = $y;
    h = $h;
    w = 4*textWidth(text);
    btColor = $btColor;
    txtColor = $txtColor;
    
  }
  void displayButton(){
   textFont(fontForEnd);
   fill(btColor);
   stroke(#202124);
   rectMode(CENTER);
   rect(x,y,w,h,80);
   fill(txtColor);
   textAlign(CENTER,CENTER);
   textSize(25);
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
