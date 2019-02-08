class Paddle {
  //position vector
  //diameter
  //flags for moving left or right
  //set the speed
  //set the yoffset
  
  boolean movingLeft;
  boolean movingRight;
  
  PVector position;
  public float move;
  float diameter;
  
  float speed;
  boolean t;
  
  PVector gsPosition;
  
  Paddle()
  {
    position = new PVector(width/2, height+20);
    movingLeft = false;
    movingRight = false;
    move = 0;
    this.draw();
    //Set the initial position and diameter
  }
  
  float move()
  {
    //return the change in x based off of movement flags
    return speed;
  }

  boolean moveable(Ball b)
  {
    //Check that the distance between the centers 
    //  is less than the sum of the radii.
    return t;
  }


  void draw()
  {
    //Draw an arc using the CHORD parameter from theta past PI to theta shy of 2*PI
    //Add the radius to the y position and subtract the y offset. 
     //System.out.println(move2);
     
     if(movingRight && move < 150) move+=5;
     else if(movingLeft && move > -150) move-=5;
     
     gsPosition = new PVector(position.x+move, position.y);
     
     ellipse(position.x + move, position.y, 100, 100);
    //arc(p.x, p.y, 120, 50, PI, 2*PI, CHORD);
  }
  
  void keyPressed()
  {
        if(keyCode == RIGHT || key == 'd')
        {
          movingRight = true;
        }
        else if(keyCode == LEFT || key == 'a')
        {
          movingLeft = true;
        }
    //call the paddle's keyPressed command
  }
  void keyReleased()
  {
        if(keyCode == RIGHT || key == 'd')
        {
          movingRight = false;
        }
        else if(keyCode == LEFT || key == 'a')
        {
          movingLeft = false;
        }
    //call the paddle's keyReleased command
  }
  
}
