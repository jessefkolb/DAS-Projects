import controlP5.*;
import java.util.Map;
import java.util.Random;

//Global variables

ControlP5 cp5;
DropdownList d1;
CheckBox checkbox;
HashMap<PVector,Integer> terainSim = new HashMap<PVector,Integer>();
PVector v1;
int cnt;
int seed;

Squares s;
Hexagons h;
Base b;

int startPressed;
int squareOrHex;
int fillColor1, fillColor2, fillColor3;

//The three main classes

class Base
{
  int maxSteps; //The maximum number of steps
  int stepsTaken; //The number of steps already taken
  int stepRate;
  float stepDistance; //The distance of each step
  float stepSize; //The scale for each step, to add borders/padding around each shape
  boolean isStroke; //Whether or not to use a stroke when drawing a shape
  boolean isConstrained;
  boolean isSimulated;
  boolean isSeed;
  int bXl, bXr, bYt, bYb; //The boundaries of the viewable area.
   
  Base()
  {
      bXl = 350;
      bXr = 1100;
      bYt = 100;
      bYb = 900;
  }
}

class Squares 
{
  float x;
  float y;
  
  Squares() 
  {
    x = 735;
    y = 500;
  }
  
  void Draw() 
  {
    if(b.isStroke == false)
    {
      noStroke();
    }
    else
    {
      stroke(0);
    }
    rectMode(CENTER);
    fill(fillColor1, fillColor2, fillColor3);
    rect(x,y, b.stepSize, b.stepSize);
  }
  
  void Update()
  {
    for(int i=0; i < b.stepRate; i++) {
     
      v1 = new PVector(x,y);
      
       if(terainSim.isEmpty())
       {
          terainSim.put(v1, 1);
       }
       else if(terainSim.containsKey(v1))
       {
          terainSim.put(v1, terainSim.get(v1)+1);
       }
       else
       {
          terainSim.put(v1, 1);
       }
      
      if(terainSim.get(v1) < 4)
      {
        fillColor1 = 160; 
        fillColor2 = 126; 
        fillColor3 = 84;
      }
      else if(terainSim.get(v1) < 7)
      {
        fillColor1 = 143; 
        fillColor2 = 170; 
        fillColor3 = 64;
      }
      else if(terainSim.get(v1) < 10)
      {
        fillColor1 = 134; 
        fillColor2 = 134; 
        fillColor3 = 134;
      }
      else
      {
        if(terainSim.get(v1) * 20 <= 255)
        {
          fillColor1 = terainSim.get(v1) * 20; 
          fillColor2 = terainSim.get(v1) * 20; 
          fillColor3 = terainSim.get(v1) * 20;
        }
        else
        {
          fillColor1 = 255; 
          fillColor2 = 255; 
          fillColor3 = 255;
        }
      }
       
      if(b.isSimulated == false)
      {
        fillColor1 = 138; 
        fillColor2 = 0; 
        fillColor3 = 228;
      }
      
      s.Draw();
      
      int choice;
      if(b.isSeed)
      {
        seed+=b.stepsTaken*(-1)/3; // avoids moving in the same direction the entire time
        randomSeed(seed);
      }
      
      choice = int(random(4));
      println("choice: " + choice + " and seed: " + seed);
                     
      if(checkbox.getArrayValue()[0] == 0) //Steps aren't constrained
      {
        if (choice == 0) {
        x+=b.stepSize * b.stepDistance;
        } else if (choice == 1) {
        x-=b.stepSize * b.stepDistance;
        } else if (choice == 2) {
        y+=b.stepSize * b.stepDistance;
        } else if (choice == 3) {
        y-=b.stepSize * b.stepDistance;
        }
        b.stepsTaken++;
      }
      else //Steps are constrained
      {
        if (choice == 0 && x < b.bXr) {
        x+=b.stepSize * b.stepDistance;
        } else if (choice == 1 && x > b.bXl) {
        x-=b.stepSize * b.stepDistance;
        } else if (choice == 2 && y < b.bYb) {
        y+=b.stepSize * b.stepDistance;
        } else if (choice == 3 && y > b.bYt) {
        y-=b.stepSize * b.stepDistance;
        }
        b.stepsTaken++;
      }
        
      if(b.stepsTaken >= b.maxSteps)
      {
        break;
      }
    } 
  }
}

class Hexagons 
{
  float x;
  float y;
  
  Hexagons()
  {
    x = 735;
    y = 500;
  }
  
  void Draw()
  {
    if(b.isStroke == false)
    {
      noStroke();
    }
    else
    {
      stroke(0);
    }
       
    fill(fillColor1, fillColor2, fillColor3);
    beginShape();
    vertex(x-(b.stepSize/2), y+(b.stepSize*sqrt(3)/2));
    vertex(x+(b.stepSize/2), y+(b.stepSize*sqrt(3)/2));
    vertex(x+b.stepSize, y);
    vertex(x+(b.stepSize/2), y-(b.stepSize*sqrt(3)/2));
    vertex(x-(b.stepSize/2), y-(b.stepSize*sqrt(3)/2));
    vertex(x-b.stepSize,y);
    endShape(CLOSE);
  }
  
  void Update()
  {
    for(int i=0; i < b.stepRate; i++) {  
      
      int intx = (int)x;
      int inty = (int)y;
      
      v1 = new PVector(intx,inty);
      
       if(terainSim.isEmpty())
       {
          terainSim.put(v1, 1);
       }
       else if(terainSim.containsKey(v1))
       {
          terainSim.put(v1, terainSim.get(v1)+1);
       }
       else
       {
          terainSim.put(v1, 1);
       }
       
       if(terainSim.get(v1) < 4)
       {
        fillColor1 = 160; 
        fillColor2 = 126; 
        fillColor3 = 84;
       }
      else if(terainSim.get(v1) < 7)
      {
        fillColor1 = 143; 
        fillColor2 = 170; 
        fillColor3 = 64;
      }
      else if(terainSim.get(v1) < 10)
      {
        fillColor1 = 134; 
        fillColor2 = 134; 
        fillColor3 = 134;
      }
      else
      {
        if(terainSim.get(v1) * 20 <= 255)
        {
          fillColor1 = terainSim.get(v1) * 20; 
          fillColor2 = terainSim.get(v1) * 20; 
          fillColor3 = terainSim.get(v1) * 20;
        }
        else
        {
          fillColor1 = 255; 
          fillColor2 = 255; 
          fillColor3 = 255;
        }
      }
      
      if(b.isSimulated == false)
      {
        fillColor1 = 138; 
        fillColor2 = 100; 
        fillColor3 = 255;
      }
      
      h.Draw();
   
      int choice;
      if(b.isSeed)
      {
        seed+=b.stepsTaken*(-1)/3; // avoids moving in the same direction the entire time
        randomSeed(seed);
      }
      choice = int(random(0,6));
      println("choice: " + choice + " and seed: " + seed);
      
      if(checkbox.getArrayValue()[0] == 0)
      {
        if (choice == 0) {
         x+=((3*b.stepSize)/2) * b.stepDistance;
         y+=((sqrt(3)*b.stepSize)/2) * b.stepDistance;               
        } 
        else if (choice == 1) {
         y+=(sqrt(3)*b.stepSize) * b.stepDistance;
        } 
        else if (choice == 2) 
         {
          y+=((sqrt(3)*b.stepSize)/2) * b.stepDistance;
          x-=((3*b.stepSize)/2) * b.stepDistance;
        } 
        else if (choice == 3) 
        {
          y-=((sqrt(3)*b.stepSize)/2) * b.stepDistance;
          x-=((3*b.stepSize)/2) * b.stepDistance;
        } 
        else if (choice == 4) 
        {
         y-=(sqrt(3)*b.stepSize) * b.stepDistance;
        } 
        else if (choice == 5)
        {
         x+=((3*b.stepSize)/2) * b.stepDistance;
         y-=((sqrt(3)*b.stepSize)/2) * b.stepDistance;
        }
        
        b.stepsTaken++;
      }
      
      else
      {
        if (choice == 0 && x < b.bXr && y < b.bYb) {
         x+=((3*b.stepSize)/2) * b.stepDistance;
         y+=((sqrt(3)*b.stepSize)/2) * b.stepDistance;               
        } 
        else if (choice == 1 && y < b.bYb) {
         y+=(sqrt(3)*b.stepSize) * b.stepDistance;
        } 
        else if (choice == 2 && x > b.bXl && y < b.bYb) 
         {
          y+=((sqrt(3)*b.stepSize)/2) * b.stepDistance;
          x-=((3*b.stepSize)/2) * b.stepDistance;
        } 
        else if (choice == 3 && x > b.bXl && y > b.bYt) 
        {
          y-=((sqrt(3)*b.stepSize)/2) * b.stepDistance;
          x-=((3*b.stepSize)/2) * b.stepDistance;
        } 
        else if (choice == 4 && y > b.bYt) 
        {
         y-=(sqrt(3)*b.stepSize) * b.stepDistance;
        } 
        else if (choice == 5 && x < b.bXr && y > b.bYt)
        {
         x+=((3*b.stepSize)/2) * b.stepDistance;
         y-=((sqrt(3)*b.stepSize)/2) * b.stepDistance;
        }
        
        b.stepsTaken++;
      }
    
     if(b.stepsTaken >= b.maxSteps)
     {
        break;
     }
   }
 }
}

//Processing functions

void setup() 
{
  size(1200, 1000);
    
  cp5 = new ControlP5(this);
  s = new Squares();
  h = new Hexagons();
  b = new Base();
  
  b.stepsTaken = 0;
  startPressed = -1;
  cnt = 0;
  
  background(140,170,210);
  
  cp5.addButton("START")
    .setValue(0)
    .setColorBackground(color(34,139,34)) 
    .setPosition(20,20)
    .setSize(200,50);
    
  d1 = cp5.addDropdownList("SHAPE")
      .setPosition(20,100)
      .setItemHeight(20)
      .setBarHeight(40)
      .setWidth(200)
      .addItem("Squares", 0)
      .addItem("Hexagons", 1);

  cp5.addSlider("MAXIMUM_STEPS")
      .setPosition(20,250)
      .setRange(100,50000)
      .setSize(200,20)
      .setCaptionLabel("MAXIMUM STEPS");
      
  cp5.addTextlabel("label1")
       .setText("Maximum Steps")
       .setPosition(20,239);

  cp5.getController("MAXIMUM_STEPS").getCaptionLabel().setVisible(false);
       
  cp5.addSlider("STEP_RATE")
      .setPosition(20,300)
      .setRange(1,1000)
      .setSize(200,20)
      .setCaptionLabel("STEP RATE");

  cp5.addTextlabel("label2")
       .setText("Step Rate")
       .setPosition(20,289);

  cp5.getController("STEP_RATE").getCaptionLabel().setVisible(false);  
  
  cp5.addSlider("STEP_SIZE")
      .setPosition(20,400)
      .setRange(10,30)
      .setSize(200,20)
      .setCaptionLabel("STEP SIZE");

  cp5.addTextlabel("label3")
       .setText("Step Size")
       .setPosition(20,389);

  cp5.getController("STEP_SIZE").getCaptionLabel().setVisible(false);

  cp5.addSlider("STEP_SCALE")
      .setPosition(20,450)
      .setRange(1,1.5)
      .setSize(200,20)
      .setCaptionLabel("STEP SCALE");
      
  cp5.addTextlabel("label4")
       .setText("Step Scale")
       .setPosition(20,439);
    
  cp5.getController("STEP_SCALE").getCaptionLabel().setVisible(false);
      
  checkbox = cp5.addCheckBox("checkBox")
                .setPosition(20,500)
                .setColorForeground(color(120))
                .setColorActive(color(0,255,245))
                .setColorLabel(color(255))
                .setSize(20, 20)
                .setItemsPerRow(1)
                .setSpacingColumn(30)
                .setSpacingRow(20)
                .addItem("CONSTRAIN STEPS", 0)
                .addItem("SIMULATE TERRAIN", 0)
                .addItem("USE STROKE", 0)
                .addItem("USE RANDOM SEED", 0);
                
  cp5.addTextfield("SEED_VALUE")
      .setPosition(20,670)
      .setInputFilter(ControlP5.INTEGER)
      .setCaptionLabel("SEED VALUE                                                     Default: 42");;
}

void draw()
{
  if(startPressed > 0)
  {
    if(cp5.get(Textfield.class, "SEED_VALUE").getText() != null && !cp5.get(Textfield.class, "SEED_VALUE").getText().isEmpty()) 
    {
      seed = Integer.parseInt(cp5.get(Textfield.class, "SEED_VALUE").getText());
    }
    else
    {
      seed = 42; //Avoids crashing
    }
    
    if(squareOrHex == 0 && b.stepsTaken <= b.maxSteps)
    {
        s.Update(); 
    }
    else if(squareOrHex == 1 && b.stepsTaken <= b.maxSteps)
    {
        h.Update();
    }   
  }
  
  rectMode(CORNER);
  fill(100);
  rect(0, 0, 280, height);
}

//UI functions

public void START()
{
   background(140,170,210);
   s = new Squares();
   h = new Hexagons();
   startPressed++;
   b.stepsTaken = 0;
   terainSim.clear();
   seed=0;
}

public void MAXIMUM_STEPS(float value)
{
  b.maxSteps = (int)value;
}

public void STEP_RATE(float value)
{
  b.stepRate = (int)value;
}

public void STEP_SIZE(float value)
{
  b.stepSize = value;
}

public void STEP_SCALE(float value)
{
  b.stepDistance = value;
}

void controlEvent(ControlEvent theEvent) {

  if(theEvent.isFrom(d1))
  {
      squareOrHex = (int)d1.getValue();
      println("squareOrHex : "+d1.getValue());
  }
  
  if(theEvent.isFrom(checkbox))
  {
    println(checkbox.getArrayValue());
    
    for(int i=0; i < checkbox.getArrayValue().length; i++)
    {
      int n = (int)checkbox.getArrayValue()[i]; //n will either be 0 (not checked) or 1 (checked)
      
      if(i == 0 && n == 0) //Color is NOT checked
      {
        b.isConstrained = false;
      }
      else if(i == 0 && n == 1) //Color is checked
      {
        b.isConstrained = true;
      }
      else if(i == 1 && n == 0) //Gradual is NOT checked
      {
        b.isSimulated = false;
      }
      else if(i == 1 && n == 1) //Gradual is checked
      {
        b.isSimulated = true;
      }
      else if(i == 2 && n == 0) //Gradual is NOT checked
      {
        b.isStroke = false;
      }
      else if(i == 2 && n == 1) //Gradual is checked
      {
        b.isStroke = true;
      }
      else if(i == 3 && n == 0) //Gradual is NOT checked
      {
        b.isSeed = false;
      }
      else if(i == 3 && n == 1) //Gradual is checked
      {
        b.isSeed = true;
      }
    }
  }

  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
  } 
  else if (theEvent.isController()) {
    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
  }
}
