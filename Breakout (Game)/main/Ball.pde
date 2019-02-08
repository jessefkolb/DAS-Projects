class Ball {
  //Declare position, velocity, diameter, speed, score
  
  private PVector velocity;
  PVector position;
  boolean inBounds;
  float r;
  
  Ball()
  {
    //Initialize position, velocity, diameter, speed
    inBounds = true;
    r = 7.5;
    velocity = new PVector(1.3, -3.5);
    position = new PVector(width/2+5, height - 60);
  }
  
  void update()
  {
   
    if(position.x > width-65 || position.x < 65)
    {
      velocity.x *= -1;
    }
    if(position.y <= 65)  
    {
      velocity.y *= -1;
    }
    if(position.y > height)
    {
      inBounds = false;
    }

    position.x += velocity.x;
    position.y += velocity.y;
    
    this.draw();
    //update the position
  }


  
  PVector getVelocity()
  {
    return velocity;
  }
  
  void draw ()
  {
    //draw an ellipse, or draw with the shader via GameState
    noStroke();
    fill(140, 140, 230);
    ellipse(position.x + velocity.x, position.y + velocity.y, r*2, r*2);
  }
}
