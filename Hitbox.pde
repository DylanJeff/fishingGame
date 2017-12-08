class Hitbox
{
  public int x, y, w, h;//x = X Position, y = Y Position,  w = Width, h = Height
  
  public Hitbox(int x, int y, int w, int h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;    
  }
  
  public boolean intersects(Hitbox other)
  {
    if(x+w > other.x &&
       x < (other.x + other.w) &&
       y < (other.y + other.h) &&
       y+h > other.y)
       {
         return true;
       }
    return false;
  }
  
  public void updateXY(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
  
  
}