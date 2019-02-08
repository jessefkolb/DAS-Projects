float xo;
float yo;

float positionX;
float positionY;
float positionZ;

float targetX;
float targetY;
float targetZ;
float targetNum;

int color1;
int color2;
int color3;

float zoom = 1;

float r;

float phi;
float theta;

PShape monster;
PShape monsterFrame;

PShape triangle1;
PShape triangle2;
PShape triangle3;
PShape triangle4;
PShape triangle5;
PShape triangle6;
PShape triangle7;
PShape triangle8;
PShape triangle9;
PShape triangle10;
PShape triangle11;
PShape triangle12;

PShape triangleFanHex1;
PShape triangleFanHex2;
PShape triangleFanHex3;
PShape triangleFanHex4;

class Camera
{
  void Update()
  {
      positionX = r * (float)Math.cos(Math.toRadians(phi)) * (float)Math.sin(Math.toRadians(theta));
      positionY = r * (float)Math.cos(Math.toRadians(theta));
      positionZ = r * (float)Math.sin(Math.toRadians(theta)) * (float)Math.sin(Math.toRadians(phi));
  }
    
  void CycleTarget()
  {
    if(targetNum == 1)
    {
      targetX = -400;
      targetNum = 2;
    }
    else if(targetNum == 2)
    {
      targetX = -200;
      targetNum = 3;
    }
    else if(targetNum == 3)
    {
      targetX = 0;
      targetNum = 4;
    }
    else if(targetNum == 4)
    {
      targetX = 300;
      targetNum = 1;
    }
  }
  
  void Zoom(float f)
  {
    f = f * 10;
    float temp = r;
    temp += f;
    
    if(temp > 50 && temp < 800) r = temp;

    println("zoom factor: " + r);
    println("Phi: " + phi + ", Theta: " + theta);
    println("Position: (" + positionX + ", " + positionY + ", " + positionZ + ")");
  }
}

void setup()
{
    size(1600,1000,P3D);
    xo = width/2;
    yo = height/2; 
    r = 500;
    
    targetX = 0;
    targetY = 0;
    targetZ = 0;
    targetNum = 3;
    
    color1=255;
    color2=0;
    color3=0;
    
    Triangles();
    TriangleHexFan();
    perspective(radians(50.0f), width/(float)height, 0.1, 1000);
    monster = loadShape("monster.obj");
    monster.setFill(color(190, 229, 60));
    monster.scale(2,-2, 2);
  
    monsterFrame = loadShape("monster.obj");
    monsterFrame.setFill(color(0, 0, 0, 0));
    monsterFrame.setStroke(true);
    monsterFrame.setStroke(color(0));
    monsterFrame.setStrokeWeight(0.5);
    monsterFrame.scale(4,-4,4);
    textureWrap(REPEAT);
}

void draw()
{
  background(80);
  translate(xo,yo, 0);
  phi = map(mouseX, 0, width-1, -90, 270);
  theta = map(mouseY, 0, height-1, 1, 179);
  
  Camera c = new Camera();
  c.Update();
  camera(positionX + targetX, positionY + targetY, positionZ + targetZ, targetX, targetY, targetZ, 0.0, 1.0, 0.0);  
  drawGrid();
  
  shape(monster);
  shape(monsterFrame, 300, 0);
  
  translate(-400, 0, 0);
  pushMatrix();
  scale(.5,.5,.5);
  drawTriangles();
  popMatrix();
  
  pushMatrix();
  translate(-40, 0, 0);
  scale(.1,.1,.1);
  drawTriangles();
  popMatrix();
  
  pushMatrix();
  translate(40, 0, 0);
  scale(1,2,1);
  drawTriangles();
  popMatrix();
  
  pushMatrix();
  translate(120,0,0);
  drawTriangleHexFan();
  popMatrix();
  
  pushMatrix();
  translate(200,0,0);
  beginShape(TRIANGLE_FAN);
  stroke(0);
  float vx = 0;
  float vy = 0;
  for (float angle=0; angle<=360; angle = angle + 18) 
  {
    fill(255, 0, 0);
    vertex(80, -40); 
    if(angle >=18)
    {
      fill(color1, color2, color3);
      vertex(vx, vy);
    }
    if(angle >=0 && angle < 54){color1=255; color2=165; color3=0;}
    if(angle >=54 && angle < 108){color1=255; color2=255; color3=0;}
    if(angle >=108 && angle < 162){color1=0; color2=255; color3=0;}
    if(angle >=162 && angle < 198){color1=0; color2=255; color3=255;}
    if(angle >=198 && angle < 252){color1=0; color2=0; color3=255;}
    if(angle >=252 && angle < 306){color1=255; color2=0; color3=255;}
    if(angle >=306 && angle < 360){color1=255; color2=0; color3=255;}
    if(angle==360){color1=255; color2=0; color3=0;}
    
    vx = 40 + cos(radians(angle))*40;
    vy = -40 + sin(radians(angle))*40;
    
    
    fill(color1, color2, color3);
    vertex(vx, vy); //Last vertex plotted
  }
  endShape();
  popMatrix();
}

void drawGrid()
{
  stroke(255); 
  for(int i = 400; i >= -400; i -= 40)
  {
    line(400, 0, i, -400, 0, i);
    line(i, 0, -400, i, 0, 400);
  }
  
  stroke(255, 0, 0);
  line(-400, 0, 400, 0);
  
  stroke(0, 0, 255);
  line(0, 0, -400, 0, 0, 400);
}

void Triangles()
{
  triangle1 = createShape();
  triangle1.beginShape();
  triangle1.vertex(20, -20, 20);
  triangle1.vertex(-20, -20, 20);
  triangle1.vertex(-20, 20, 20);
  triangle1.endShape();
  triangle1.setFill(color(255, 255, 0));
  triangle1.setStroke(false);
  
  triangle2 = createShape();
  triangle2.beginShape();
  triangle2.vertex(20, -20, 20);
  triangle2.vertex(20, 20, 20);
  triangle2.vertex(-20, 20, 20);
  triangle2.endShape();
  triangle2.setFill(color(0, 255, 0));
  triangle2.setStroke(false);
  
  triangle3 = createShape();
  triangle3.beginShape();
  triangle3.vertex(20, -20, -20);
  triangle3.vertex(-20, -20, -20);
  triangle3.vertex(-20, 20, -20);
  triangle3.endShape();
  triangle3.setFill(color(30, 100, 100));
  triangle3.setStroke(false);
  
  triangle4 = createShape();
  triangle4.beginShape();
  triangle4.vertex(20, -20, -20);
  triangle4.vertex(20, 20, -20);
  triangle4.vertex(-20, 20, -20);
  triangle4.endShape();
  triangle4.setFill(color(255,0,255));
  triangle4.setStroke(false);
  
  triangle5 = createShape();
  triangle5.beginShape();
  triangle5.vertex(20, 20, 20);
  triangle5.vertex(20, 20, -20);
  triangle5.vertex(-20, 20, -20);
  triangle5.endShape();
  triangle5.setFill(color(255,188,0));
  triangle5.setStroke(false);
  
  triangle6 = createShape();
  triangle6.beginShape();
  triangle6.vertex(-20, 20, 20);
  triangle6.vertex(20, 20, 20);
  triangle6.vertex(-20, 20, -20);
  triangle6.endShape();
  triangle6.setFill(color(120, 212, 203));
  triangle6.setStroke(false);
  
  triangle7 = createShape();
  triangle7.beginShape();
  triangle7.vertex(-20, 20, 20);
  triangle7.vertex(-20, -20, 20);
  triangle7.vertex(-20, -20, -20);
  triangle7.endShape();
  triangle7.setFill(color(255, 0, 0));
  triangle7.setStroke(false);
  
  triangle8 = createShape();
  triangle8.beginShape();
  triangle8.vertex(-20, 20, 20);
  triangle8.vertex(-20, 20, -20);
  triangle8.vertex(-20, -20, -20);
  triangle8.endShape();
  triangle8.setFill(color(0, 206, 247));
  triangle8.setStroke(false);
  
  triangle9 = createShape();
  triangle9.beginShape();
  triangle9.vertex(20, 20, 20);
  triangle9.vertex(20, -20, 20);
  triangle9.vertex(20, -20, -20);
  triangle9.endShape();
  triangle9.setFill(color(150));
  triangle9.setStroke(false);
  
  triangle10 = createShape();
  triangle10.beginShape();
  triangle10.vertex(20, 20, 20);
  triangle10.vertex(20, 20, -20);
  triangle10.vertex(20, -20, -20);
  triangle10.endShape();
  triangle10.setFill(color(0, 0, 255));
  triangle10.setStroke(false);
  
  triangle11 = createShape();
  triangle11.beginShape();
  triangle11.vertex(20, -20, 20);
  triangle11.vertex(20, -20, -20);
  triangle11.vertex(-20, -20, -20);
  triangle11.endShape();
  triangle11.setStroke(false);
  triangle11.setFill(color(255, 255, 255));
  
  triangle12 = createShape();
  triangle12.beginShape();
  triangle12.vertex(-20, -20, 20);
  triangle12.vertex(20, -20, 20);
  triangle12.vertex(-20, -20, -20);
  triangle12.endShape();
  triangle12.setStroke(false);
  triangle12.setFill(color(0));
}

void drawTriangles()
{
  shape(triangle1);
  shape(triangle2);
  shape(triangle3);
  shape(triangle4);
  shape(triangle5);
  shape(triangle6);
  shape(triangle7);
  shape(triangle8);
  shape(triangle9);
  shape(triangle10);
  shape(triangle11);
  shape(triangle12);
}

void TriangleHexFan()
{
  triangleFanHex1 = createShape();
  triangleFanHex1.beginShape();
  triangleFanHex1.fill(255, 0, 0);
  triangleFanHex1.vertex(0, -35, 0);
  triangleFanHex1.fill(255, 255, 0);
  triangleFanHex1.vertex(20, 0, 0);
  triangleFanHex1.fill(0, 255, 0);
  triangleFanHex1.vertex(60, 0, 0);
  triangleFanHex1.endShape();
  
  triangleFanHex2 = createShape();
  triangleFanHex2.beginShape();
  triangleFanHex2.fill(255, 0, 0);
  triangleFanHex2.vertex(0, -35, 0);
  triangleFanHex2.fill(0, 255, 0);
  triangleFanHex2.vertex(60, 0, 0);
  triangleFanHex2.fill(0, 255, 255);
  triangleFanHex2.vertex(80, -35, 0);
  triangleFanHex2.endShape();
  
  triangleFanHex3 = createShape();
  triangleFanHex3.beginShape();
  triangleFanHex3.fill(255, 0, 0);
  triangleFanHex3.vertex(0, -35, 0);
  triangleFanHex3.fill(0, 255, 255);
  triangleFanHex3.vertex(80, -35, 0);
  triangleFanHex3.fill(0, 0, 255);
  triangleFanHex3.vertex(60, -70, 0);
  triangleFanHex3.endShape();
  
  triangleFanHex4 = createShape();
  triangleFanHex4.beginShape();
  triangleFanHex4.fill(255, 0, 0);
  triangleFanHex4.vertex(0, -35, 0);
  triangleFanHex4.fill(0, 0, 255);
  triangleFanHex4.vertex(60, -70, 0);
  triangleFanHex4.fill(255, 0, 255);
  triangleFanHex4.vertex(20, -70, 0);
  triangleFanHex4.endShape();
}

void drawTriangleHexFan()
{
  shape(triangleFanHex1);
  shape(triangleFanHex2);
  shape(triangleFanHex3);
  shape(triangleFanHex4);
}

void mouseWheel(MouseEvent event)
{
  Camera c = new Camera();
  c.Zoom(event.getCount());
}

void keyPressed()
{
    if(key==' ')
    {
      Camera c = new Camera();
      c.CycleTarget();
    }
}
