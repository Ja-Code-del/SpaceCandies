class FuelBar{
float x,y,w,h,decreaseRate;
color fuelStatus;
  FuelBar(float $w, float $decreaseRate){
   x = 0;
   y = 0;
   h = 15;
   w = $w;
   decreaseRate = $decreaseRate;
   fuelStatus = #1EFF05;
  }
  
  void displayFuelBar(){
    rectMode(CORNER);
    fill(fuelStatus);
    rect(x,y,w,h);
    //println(w);
  }
  
  void fuelBarManager(Rain r){ //method to decrease the fuel bar
    if(r.y+3*r.len/2 > height){
     w -= decreaseRate; 
    }
     if(w < width && w > width/2){
     fuelStatus = #190019;
   }else if(w < width/2 && w > 0){
    fuelStatus = #FF210D; 
   }else if(w < 0){
     end = true;
   }
  }
  
  void resetFuelBar(){
    fuelStatus = #1EFF05;
    w = width;
  }
  
  void setDecreaseRate(float $decrease){
   decreaseRate = $decrease; 
  }
  
}
