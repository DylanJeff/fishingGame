class Player
{
  int x, y, delta;
  PImage boat, boat_left, boat_right, line, hook, fish;
  boolean lineExtending, hookOccupied;
  Hitbox hitbox, hookHitbox;
  
  public Player(int x, int y)
  {
    this.x = x;
    this.y = y;
    
    boat_left = loadImage("player.png");
    boat_right = loadImage("player_right.png");
    boat = boat_left;
    line = loadImage("string.png");
    hook = loadImage("hook.png");
    fish = loadImage("fish_up.png");
    
    line.height = 0;
    lineExtending = false;
    hookOccupied = false;
    
    hitbox = new Hitbox(x+10, y+11, 83, 54);
    hookHitbox = new Hitbox(x+43, y+80+line.height+7, 10, 13);
  }
  
  public void update()
  {
    //Position change
    x += delta;
    
    //Line and Hook controls
    if(lineExtending)
    {
      line.height += 5;
    }
    else
    {
      if(line.height > 5)
      {
        line.height -= 5;
      }   
    }
    
    //Hitbox updating(Keep at the bottom)
    hitbox.updateXY(x+10, y+11);
    hookHitbox.updateXY(x+43, y+80+line.height+7);
  }
  
  public void render()
  { 
    image(boat, x, y);
    image(line, x, y+80);
    image(hook, x, y+80+line.height);
    
    if(hookOccupied)
    {
      image(fish, x+36, y+80+line.height+7);
    }
  }
  
  public void goLeft()
  {
    if(x > 0)
    delta = -2;
    else
    delta = 0;
    
    boat = boat_left;
  }
  
  public void goRight()
  {
    if(x < 287)
    delta = 2;
    else
    delta = 0;
    
    boat = boat_right;
  }
  
  public void halt()
  {
    delta = 0;
  }
  
  public void extendLine()
  {
    lineExtending = true;
  }
  
  public void compressLine()
  {
    lineExtending = false;
  }
  
  public Hitbox getHitbox()
  {
    return hitbox;
  }
  
  public Hitbox getHookHitbox()
  {
    return hookHitbox;
  }
  
  public boolean getHookState()
  {
    return hookOccupied;
  }
  
  public void setHookState(boolean state)
  {
    hookOccupied = state;
  }
  
  public int fishRetrieved()
  {
    //Check if caught fish is retrieved
    if(hookOccupied && line.height == 5)
    {
      hookOccupied = false;
      return 1;
    }
    return 0;
  }
  
  public int getX()
  {
    return x;
  }
  
}