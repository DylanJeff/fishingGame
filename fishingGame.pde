enum Scenes
{
  SPLASH, GAME, OVER;
}

PImage backgroundImage;

Scenes currentScene;

Player player;
Shark shark1;
Fish[][] fishes;

int textFlash;

int fishCaught;

void setup()
{
  size(400, 600);
  background(207,238,245);
  
  backgroundImage = loadImage("sea.png");
  
  currentScene = Scenes.SPLASH;
  
  player = new Player(150, 120);
  shark1 = new Shark(300, 1000);
  fishes = createFishes();
  
  textFlash = 0;
  
  fishCaught = 0;
}

void draw()
{
  background(207,238,245);
  image(backgroundImage, 0, 0);
  switch(currentScene)
  {
    case SPLASH:
      updateSplash();
      drawSplash();
      break;
      
    case GAME:
      updateGame();
      drawGame();
      break;
      
    case OVER:
      updateOver();
      drawOver();
      break;
  }
}

void updateSplash()
{
  textFlash++;
  if(textFlash == 81)
  {
    textFlash = 0;
  }
}

void drawSplash()
{
  textSize(32);
  textAlign(CENTER);
  
  if(textFlash > 30)
  {
    text("Press SPACE\nto start", 200, 400);
  }
  
  player.render();
        
}

void updateGame()
{
  player.update();
  fishCaught += player.fishRetrieved();//Score detection
  shark1.update(player);
  
  for(Fish[] row : fishes)
  {
    for(Fish f : row)
    {
      f.update();
      
      //Collision with hook check
      if(f.getHitbox().intersects(player.getHookHitbox()) && !f.getFishState())///If the hitboxes of the
      //hook and the fish intersect AND the fish isn't already caught
      {
        if(!player.getHookState())//If the hook is not occupied already
        {
          player.setHookState(true);
          f.setFishState(true); 
        }
      }
      
      //Collision with player check
      if(f.getHitbox().intersects(player.getHitbox()) && !f.getFishState())///If the hitboxes of the
      //player and the fish intersect AND the fish isn't already caught
      {
        currentScene = Scenes.OVER;
      }
    }    
  }
  
  if(player.getHitbox().intersects(shark1.getHitbox()))//If the hitboxes of the player and the shark intersect
  {
    currentScene = Scenes.OVER;
  }
  
  //Check if all the fish in the current batch have been caught
  if(checkFishGone())
  {
    fishes = createFishes();
  }
}

void drawGame()
{
  player.render();
  shark1.render();
  
  for(Fish[] row : fishes)
  {
    for(Fish f : row)
    {
      f.render(); 
    }    
  }
  
  textSize(14);
  fill(18, 106, 165);
  text("Fish Caught: "+fishCaught, 280, 20);
}

void updateOver()
{
  
}

void drawOver()
{
  textSize(32);
  fill(255);
  text("You caught\n"+fishCaught+"\nfish!",200, 200);
  text("Press SPACE\nto try again", 200, 400);
}

void keyPressed()
{
  switch(currentScene)
  {
    case SPLASH:
      break;
      
    case GAME:
      if(key == 'a')
      {
        player.goLeft();
      }
      if(key == 'd')
      {
        player.goRight();
      }
      if(key == ' ')
      {
        player.extendLine();
      }
      break;
      
    case OVER:
      break;
  }
  
}

void keyReleased()
{
  switch(currentScene)
  {
    case SPLASH:
      if(key == ' ')
      {
        currentScene = Scenes.GAME;
      }
      break;
      
    case GAME:
      if(key == 'a' || key == 'd')
      {
        player.halt();
      }
      if(key == ' ')
      {
        player.compressLine();
      }
      break;
      
    case OVER:
    if(key == ' ')
      {
        currentScene = Scenes.SPLASH;
        setup();
      }
      break;
  }
}

Fish[][] createFishes()
{
  Fish[][] fishArray = new Fish[2][2];
  
  int arrayX = (int)random(50, 300);
  
  for(int i = 0; i < 2; i++)
  {
    for(int j = 0; j < 2; j++)
    {
      fishArray[i][j] = new Fish(arrayX+(i*25), 600+(j*25));
      fishArray[i][j].setDeltaY(-0.3);
    }
  }
  
  return fishArray;
}

boolean checkFishGone()
{
  for(Fish[] row : fishes)
  {
    for(Fish f : row)
    {
      if(!f.getFishState())
      {
        return false;
      }
    }
  }
  return true;
}
 