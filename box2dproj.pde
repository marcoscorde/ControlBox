import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;

PFont tit;
PFont tex;
float f;

ArrayList<Box> boxes;
ArrayList<Player> player;

void setup() {
  size(500,700);
  smooth();
  tit = createFont("Phosphate-Inline",70);
  tex = createFont("Avenir",20);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -20);
  boxes = new ArrayList<Box>();
  player = new ArrayList<Player>();

  f = 2;

}
int pantalla = 0;
void draw() {
  background(255);
  switch(pantalla){
    case 0:
    inicio();
    break;
    case 1:
    juego();
    break;
  }
}


void juego(){
  background(255);
  box2d.step();
  float m = millis();
  f= f+(m*0.0000001);
  
  if (random(2) < 0.1) {
    Box p = new Box(random(500),random(700));
    boxes.add(p);
  }
  if (key =='w') {
    for (Box b: boxes) {
     box2d.setGravity(0,f);
    }
  }
  if(key=='s'){
    for(Box b: boxes){
      box2d.setGravity(0,-f);
    }
  }
  if(key=='a'){
    for(Box b: boxes){
      box2d.setGravity(-f,0);
    }
  }
  if(key=='d'){
    for(Box b: boxes){
      box2d.setGravity(f,0);
    }
  }
  for (Box b: boxes) {
    b.display();
  }
   for (Player p: player) {
    p.display();
  }
   for (int i = boxes.size()-1; i >= 30; i--) {
    Box b = boxes.get(i);
    if (b.done()) {
      boxes.remove(i);
    }
  }
  for(Player p: player){
    if(p.fin()){
      pantalla = 0;
    }
  }
}


void inicio(){
  fill(0,0,0);
  textSize(80);
  textFont(tit);
  text("ControlBox",10,150);
  textFont(tex);
  text("Evita que las cajas salgan de la pantalla!",10,250);
  line(200,380,200,340);
  triangle(200,335,197,340,203,340);
  text("w",193,335);
  line(150,400,190,400);
  triangle(145,400,150,397,150,403);
  text("a",135,400);
  line(210,400,250,400);
  triangle(255,400,250,397,250,403);
  text("d",254,400);
  line(200,390,200,435);
  triangle(200,440,197,433,203,433);
  text("s",196,453);
  textSize(15);
  text("Utiliza las teclas para cambiar el sentido de atraccion de los objetos", 10,280);
  textSize(24);
  fill(0,0,0,random(255));
  text("pulsa a para continuar",140,600);
  if(key =='a'){
    pantalla = 1;
      player.add(new Player(height/3,width/2));
      
  }
   if (random(1) < 0.1) {
    Box p = new Box(random(width),10);
    boxes.add(p);
  }
  
  

  box2d.step();
  for (Box b: boxes) {
    b.display();
  }


  for (int i = boxes.size()-1; i >= 0; i--) {
    Box b = boxes.get(i);
    if (b.done()) {
      boxes.remove(i);
    }
  }
}