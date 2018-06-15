float a;
float b;
float c;
float d;

class Plane{
 //in form a+b+c+d=0
  Plane(int ai,int bi, int ci,int di){//the i same for input
   a = ai;
   b = bi;
   c = ci;
   d = di;
  }
  
  
  
  PVector calcTValue(PVector point, PVector dir){
   float constant = point.x*a + point.y*b + point.z*c + d;//this is the constants on left side(no the side with 0) 
   float numT = dir.x*a + dir.y*b + dir.z*c;
   
   PVector returnVal = new PVector(constant,numT);
    return returnVal;
  }//end of calcTValue
 
  
}
