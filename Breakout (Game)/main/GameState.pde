class GameState {
  //create a PShader (fragment shader) and PImage (texture)
  //create some helper variables (s,w,h)
  //time variable
  
  //Declare a: Ball, Paddle, Box[] walls, and Box[] level
  
  Box[] level = new Box[60];
  Box[] walls = new Box[3];
  Paddle paddle = new Paddle();
  Ball ball = new Ball();
  PImage img = loadImage("link.jpg");
  PVector V;
  PVector R;
  PVector N;
  
  int score;
  
  boolean win;
  boolean gameOver;

  GameState(int w_, int h_, String glsl, String texture)
  {
    //set variables
    //create ball, paddle, walls, level   
    gameOver = false;
    win = false;
    score = 0;
    level0();
    makeWalls(img);
  }

  Box[] level0()
  {
    //Create a grid of boxes
    for(int i=0; i<10; i++)
    {
        for(int j=0; j<6; j++)
        {
          level[i+(j*10)] = new Box((i*30) + (width/5), (j*30 + (height/4)), 25, 25, false, true, img);
        }
    }
    return level;
  }

  void update()
  {
     ball.update();
     paddle.draw();
     checkWin();
     if (!ball.inBounds) gameOver = true;
  }
  
  void collisions(){
    //collide walls, levels, and ball-paddle
  }
  
  void draw()
  {
    //draw shader, draw boxes, check/print score/win
    
    String s = "Score: " + Integer.toString(score);
    
    textSize(20);
    noStroke();
    text(s, 60, height/2 - 150);
    
     for(int i=0; i<60; i++)
      {
        if(level[i].isAlive) level[i].draw();
      }
      
      for(int i=0; i<3; i++)
      {
        walls[i].draw();
      }
      
      ballBoxCollisions();
      ballPaddleCollisions();
  }
  
  Box[] makeWalls(PImage img)
  {
    //Make 3 boxes (left, top, right) as walls
    
    walls[0] = new Box(0, 0, width, 50, true, false, img); //top wall
    walls[1] = new Box(0, 0, 50, height, true, false, img); //left wall
    walls[2] = new Box(width-50, 0, 50, height, true, false, img); //right wall
    
    return walls;
  }
  
  void ballPaddleCollisions()
  {
        /*System.out.println(V);
        V = ball.getVelocity();
        
        N = new PVector(V.x, V.y);
        customNormalize(N);
        
        println("Normal: " + N);
        println("Velocity: " + V);
        
        float d = V.dot(N); //dot(V,N)
        d*=2; //2 * (dot(V,N))
        println(d);
        
        N = N.mult(d); //2 * (dot(V,N)) * N
        println("Normal after mult: " + N);
        
        float vsubnx = V.x - N.x;
        float vsubny = V.y - N.y;
        
        R = new PVector(vsubnx, vsubny);
        println("Reflection: " + R);
        
        if(Math.abs(ball.position.y - paddle.gsPosition.y) < (ball.r + 50))
        {
          if(Math.abs(ball.position.x - paddle.gsPosition.x) < ball.r + 50)
          {
            V.x = R.x;
            V.y = R.y;
            //Doesn't work
          }
        }*/
        
    if(ball.position.y + ball.r > paddle.gsPosition.y-40)
    {
      if(ball.position.x >= paddle.gsPosition.x-5 && ball.position.x <= paddle.gsPosition.x+5)
      {
        if(ball.position.x >= paddle.gsPosition.x)
        {
          ball.velocity.y *= -1;
          ball.velocity.x = 0.1;
        }
        if(ball.position.x <= paddle.gsPosition.x)
        {
          ball.velocity.y *= -1;
          ball.velocity.x = -0.1;
        }
      }
      else if(ball.position.x >= paddle.gsPosition.x+5 && ball.position.x <= paddle.gsPosition.x+20)
      {
        ball.velocity.y *= -1;
        ball.velocity.x = 1;
      }
      else if(ball.position.x >= paddle.gsPosition.x-20 && ball.position.x <= paddle.gsPosition.x-5)
      {
        ball.velocity.y *= -1;
        ball.velocity.x = -1;
      }
      else if(ball.position.x >= paddle.gsPosition.x+20 && ball.position.x <= paddle.gsPosition.x+50)
      {
        ball.velocity.y *= -1;
        ball.velocity.x = 2;
      }
      else if(ball.position.x >= paddle.gsPosition.x-50 && ball.position.x <= paddle.gsPosition.x-20)
      {
        ball.velocity.y *= -1;
        ball.velocity.x = -2;
      }
    }
  }

  void ballBoxCollisions()
  {
    for(int i=0; i<60; i++)
    {
      if((ball.position.x + ball.r >= level[i].topLeftVertex_x && ball.position.x <= level[i].topLeftVertex_x) && level[i].isAlive)
      {
        if(ball.position.y >= level[i].topLeftVertex_y && ball.position.y <= level[i].topLeftVertex_y+25)
        {
          //Coming in from the left
          ball.velocity.x *= -1;
          System.out.println(i + " from the left");
          level[i].isAlive = false;
          if(!level[i].isAlive) System.out.println(i + " is dead");
          score += 10;
        }
      }
      
      if(ball.position.x - ball.r <= level[i].topLeftVertex_x+25 && ball.position.x >= level[i].topLeftVertex_x+25 && level[i].isAlive)
      {
        if(ball.position.y >= level[i].topLeftVertex_y && ball.position.y <= level[i].topLeftVertex_y+25)
        {
          //Coming in from the right
          ball.velocity.x *= -1;
          System.out.println(i + " from the Right");
          level[i].isAlive = false;
          if(!level[i].isAlive) System.out.println(i + " is dead");
          score += 10;
        }
      }
      
      if(ball.position.y + ball.r >= level[i].topLeftVertex_y && ball.position.y <= level[i].topLeftVertex_y && level[i].isAlive)
      {
        if(ball.position.x >= level[i].topLeftVertex_x && ball.position.x <= level[i].topLeftVertex_x+25)
        {
          //Coming in from the top
          ball.velocity.y *= -1;
          System.out.println(i + " from the Top");
          level[i].isAlive = false;
          if(!level[i].isAlive) System.out.println(i + " is dead");
          score += 10;
        }
      }
      
      if(ball.position.y - ball.r <= level[i].topLeftVertex_y+25 && ball.position.y >= level[i].topLeftVertex_y+25 && level[i].isAlive)
      {
        if(ball.position.x >= level[i].topLeftVertex_x && ball.position.x <= level[i].topLeftVertex_x+25)
        {
          //Coming in from the bottom
          ball.velocity.y *= -1;
          System.out.println(i + " from the Bottom");
          level[i].isAlive = false;
          if(!level[i].isAlive) System.out.println(i + " is dead");
          score += 10;
        }
      }
    }    
  }
  
  void checkWin()
  {
    if (score >= 600)
    {
      win = true;
    }
  }
  
  boolean hasAlive(Box[] boxes){
    //Check to see if the level has a box left
    return true;
  }
  
  PVector customNormalize(PVector N)
  {
    float length = (float)Math.sqrt((N.x*N.x) + (N.y*N.y));
    if(length !=0)
    {
      N.x = N.x/length;
      N.y = N.y/length;
    }
    return N;
  }
  
  void keyPressed(){
    paddle.keyPressed();
    //call the paddle's keyPressed command
  }
  void keyReleased(){
    paddle.keyReleased();
    //call the paddle's keyReleased command
  }
}
