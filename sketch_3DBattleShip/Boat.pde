class Boat{
  
  PVector start;
  PVector direction;
  int boatLength;
  
  boolean printBoatHitDebug = true;
  boolean alive = true;
  
  Boat(int len, float dirx, float diry, float dirz, float stax, float stay, float staz){
   boatLength = len;
   direction = new PVector(dirx, diry,dirz);
   start = new PVector(stax, stay,staz);
   
  }
  
  Boat(int len, PVector dir, PVector sta){
    start = sta;
    direction = dir;
    boatLength = len;
  }
  
  public void gotHit(){
    alive = false;
  }
  
  public boolean isAlive(){
    return alive;
  }
  
  public int getLength(){
    return boatLength;
  }
  
  public boolean checkHit(Plane missile){//true for hit; false for miss
    PVector tempNum = missile.calcTValue(start,direction);
    if(tempNum.y == 0){
      if(tempNum.x == 0){//hit all along the boat
        if(printBoatHitDebug) println("Parallet hit");
        return true;
      }else {//parallel to the boat
        if(printBoatHitDebug) println("Parallet miss");
        return false;
      }
    }
    float t = -tempNum.x / tempNum.y;
    
    for(int i=0 ; i<boatLength; i++){
      if(i ==t){
        if(printBoatHitDebug) println("normal hit");
         return true;//t value is equal to 0 or 1 or 2 and so on for better boats(thus a hit)
      }
    }
    
    if(printBoatHitDebug) println("normal miss");
    return false;//t val did not hit the boat
  } //end of check hit function
  
}
