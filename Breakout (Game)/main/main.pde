import controlP5.*;

/*
SHADER AND IMAGE SOURCES:

Background: http://glslsandbox.com/e#50241.0
Texture: https://opengameart.org/node/9746

*/


ControlP5 cp5;
GameState gs;
int w, h;
boolean playing;
boolean paused;
Button play;
boolean initialize;
PImage button;
PShader blur;
float t;

void setup()
{
  //set the size and renderer to P2D
  //Call init()
  size(500,500, P2D);
  blur = loadShader("test.glsl");
  t = 0;

  button = loadImage("play.png");
  paused = false;
  cp5 = new ControlP5(this); 
    cp5.addButton("PLAY")
    .setValue(0)
    .setPosition(width/2-50,height/2+100)
    .setSize(100,50)
    .setImage(button);
  init();
}

void init()
{
  //set w, h, gs, play
  initialize = true;
  gs = new GameState(width, height, "shader", "texture");
  playing = false;
}

void draw() 
{  
  
   t+=0.01;

  if(initialize)
  {
    //background(0);
    blur.set("time", t);
    filter(blur);
    gs.update();
    gs.draw();
    initialize = false;
  }
  
  if(!playing)
  {
    cp5.show();
  }
  
  else if(paused)
  {
    textSize(32);
    text("Paused", width/2 - 40, height/2);
  }
  
  else if(gs.gameOver)
  {
    textSize(32);
    text("Game Over", width/2-85, height/2);
    playing = false;
    
  } 
  else if(gs.win)
  {
    textSize(32);
    text("You Win!", width/2-80, height/2);
    playing = false;
  }
  else
  {
    cp5.hide();
    //background(0);
    blur.set("time", t);
    filter(blur);
    gs.draw();
    gs.update();
  }

}

public void PLAY()
{
  init();
  playing = true;
  //gs.gameOver = false;
  //
}

void keyPressed(){
  
  if(key == 'p') paused = !paused;
  
  gs.keyPressed();
  //call the GameState's keyPressed command
  //press 'p' to pause/unpause (via toggle())
  //if(key == '`') saveFrame("screenshots/screenshot-####.png");
}
void keyReleased(){
  //call the GameState's keyReleased command
  gs.keyReleased();
}
