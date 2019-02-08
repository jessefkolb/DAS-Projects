class Box {
 
  float topLeftVertex_x;
  float topLeftVertex_y;
  float w;
  float h;
  boolean isAlive;
  boolean isWall;
  
  PImage img;
  
  int count = 0;
  
  //top left corner
 //width and height
 //bools for alive and wall
 //vector for image's source location
 Box(float x1, float y1, float x2, float y2, boolean wall_, boolean alive_, PImage pimg){

   topLeftVertex_x = x1;
   topLeftVertex_y = y1;
   
   w = x2;
   h = y2;
   
   isWall = wall_;
   isAlive = alive_;   
   img = pimg;
 }

 void draw()
 {   
     if(isAlive)
     {
        //rect(topLeftVertex_x, topLeftVertex_y, w, h);
        beginShape();
        texture(img);
        vertex(topLeftVertex_x, topLeftVertex_y, topLeftVertex_x, topLeftVertex_y);
        vertex(topLeftVertex_x+25, topLeftVertex_y, topLeftVertex_x+25, topLeftVertex_y);
        vertex(topLeftVertex_x+25, topLeftVertex_y+25, topLeftVertex_x+25, topLeftVertex_y+25);
        vertex(topLeftVertex_x, topLeftVertex_y+25, topLeftVertex_x, topLeftVertex_y+25);
        endShape();
        
     }
     else if(isWall)
     {
       beginShape();
       texture(img);
       vertex(topLeftVertex_x, topLeftVertex_y, topLeftVertex_x, topLeftVertex_y);
       vertex(topLeftVertex_x+w, topLeftVertex_y, topLeftVertex_x+w, topLeftVertex_y);
       vertex(topLeftVertex_x+w, topLeftVertex_y+h, topLeftVertex_x+w, topLeftVertex_y+h);
       vertex(topLeftVertex_x, topLeftVertex_y+h, topLeftVertex_x, topLeftVertex_y+h);
       endShape();
       //rect(topLeftVertex_x, topLeftVertex_y, w, h);
     }
     
 }
}
