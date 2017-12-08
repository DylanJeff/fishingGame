class Shark
{
  int x, y, delta;
  PImage shark, down;
  int timer;
  Hitbox hitbox;
  
  public Shark(int x, int y)
  {
    this.x = x;
    this.y = y;
    delta = 0;
    
    shark = loadImage("shark.png");
    down = loadImage("sharkdown.png");
    
    timer = 180;
    
    hitbox = new Hitbox(x, y, 45, 91);
  }
  
  public void update(Player player)
  {
    //Position change
    y += delta;
    
    //Screen boundary detection
    if(y < 170)//Hits the sea ceiling
    {
      delta = 3;
    }
    else if(y > 630)//Goes off the bottom of the screen
    {
      timer = 180;
      reset();
    }
    
    //Spawn timer
    if(timer == 0)
    {
      move(player.getX());
      timer = -1;
    }
    else
    {
      timer--;
    }
    
    //Hitbox updating(Keep at the bottom)
    hitbox.updateXY(x, y);
  }
  
  public void render()
  {
    if(delta < 0)
    image(shark, x, y);
    else
    image(down, x ,y);
  }
  
  private void reset()
  {
    x = 0;
    y = 620;
    delta = 0;
  }
  
  public void move(int playerX)
  {
    x = playerX+50;
    y = 620;
    delta = -3;
  }
  
  public Hitbox getHitbox()
  {
    return hitbox;
  }
}