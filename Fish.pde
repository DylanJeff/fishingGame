class Fish
{
  float x, y, deltaX, deltaY;
  PImage left, right;
  boolean caught;
  
  Hitbox hitbox;
  
  public Fish(float x, float y)
  {
    this.x = x;
    this.y = y;
    deltaX = 0;
    deltaY = 0;
    
    left = loadImage("fish_left.png");
    right = loadImage("fish_right.png");
    
    caught = false;
    
    hitbox = new Hitbox((int)x, (int)y, 25, 25);
  }
  
  public void update()
  {
    //Position changing
    y += deltaY;
    
    //Hitbox updating(Keep at the bottom)
    hitbox.updateXY((int)x, (int)y);
  }
  
  public void render()
  {
    if(!caught)
    {
      if(deltaX < 0)
      image(left, x, y);
      else
      image(right, x, y);
    }
  }
  
  public void setDeltaX(float deltaX)
  {
    this.deltaX = deltaX;
  }
  
  public void setDeltaY(float deltaY)
  {
    this.deltaY = deltaY;
  }
  
  public Hitbox getHitbox()
  {
    return hitbox;
  }
  
  public boolean getFishState()
  {
    return caught;
  }
  
  public void setFishState(boolean state)
  {
    caught = state;
  }
    
}