class Box {
  Body body;
  float w;
  float h;

  Box(float x, float y) {
    w = random(8,16);
    h = w;
    makeBody(new Vec2(x,y),w,h);
  }

  void killBody() {
    box2d.destroyBody(body);
  }


  boolean done() {
    Vec2 pos = box2d.getBodyPixelCoord(body);  
    if (pos.y > height+w*h) {
      killBody();
      return true;
    }
    if (pos.y < 0-w*h) {
      killBody();
      return true;
    }
    if (pos.x < 0-w*h) {
      killBody();
      return true;
    }
    if (pos.x >500 +w*h) {
      killBody();
      return true;
    }
    return false;
  }

  void attract(float x,float y) {
    Vec2 worldTarget = box2d.coordPixelsToWorld(x,y);   
    Vec2 bodyVec = body.getWorldCenter();
    worldTarget.subLocal(bodyVec);
    worldTarget.normalize();
    worldTarget.mulLocal((float) 50);
    body.applyForce(worldTarget, bodyVec);
  }


  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(175);
    stroke(0);
    rect(0,0,w,h);
    popMatrix();
  }

  void makeBody(Vec2 center, float w_, float h_) {

    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = random(3);

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);
  }
}