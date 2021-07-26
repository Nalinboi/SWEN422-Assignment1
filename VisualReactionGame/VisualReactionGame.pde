float level = 0;  // There are three screens or 'levels' - the main menu, the reaction game, and the results page

color red = color(255,0,0);
color green = color(0,255,0);
color blue = color(0,0,255);

// This is a random time which is between 3-10 seconds after the current time.
float randomAppearTime = millis() + random(3000, 10000); // RandomAppearTime is when the shape randomly changes colour

float shapeClickedTime = 0; // The time the shape is clicked is put in a global variable for the results page to present. 

void setup() {
  size(600, 300); // size of the screen
  textSize(32); // size of all the text in the game
  noStroke(); // No stroke on the shapes
  textAlign(CENTER); // Texts will be centered to the x and y coordinates assigned.
  background(100); // The background colour (a dark grey). We could have 0 for black or 255 for white.
}

void nextLevel() {
  if(level == 0) { // Main menu
    level = 1; // If we are in the main menu, the next level (1) will be the reaction game.
    
    // We store a random time between 3-10 seconds ahead of the current time. 
    randomAppearTime = millis() + random(3000, 10000); // This is when the shape will change colour
    
  } else if (level == 1){ // Reaction game
    level = 2; // If we are in the reaction level, the next level (2) will be the results page.
    shapeClickedTime = millis();
    
  } else { // Results page 
    level = 0; // If we are in the results page, the next level (0) will be the main menu.
  }
}

void keyPressed()
{
  if (keyCode == 32) { // 32 is ascii for spacebar     
    nextLevel(); // If the user presses spacebar, the user will go to the next level
  } 
}

void mouseClicked(){
  nextLevel(); // If the user clicks the screen, the user will go to the next level
}

void draw() {
  if(level == 0) { // If we are at level 0, then draw the main menu
    mainMenu();
  } else if (level == 1) { // If we are at level 1, then draw the reaction game
    level1();
  } else { // If anything else, we should be at level 2, so we draw the results page
    results();
  }
}

void mainMenu() {
  background(100);
  fill(blue); // Fill colour is blue
  //textFont(title);
  text("Main Menu:\n Click or press space to play the game", width/2, height/2-100);
}

void level1() {
  background(100);
  fill(blue);
  text("Click or press Space\n when shape turns Green", width/2, height/2-100);
  if (millis() > randomAppearTime) { // After a random amount of time, change the shape colour
    fill(green);
  }
  else { // Before the random time keep the colour as red
    fill(red);
  }
  rect(20, 110, width-50, height-130); // the rectangle you are supposed to click on for reaction times.
}

void results() {
  background(100);
  float result = shapeClickedTime - (randomAppearTime);
  if(result >= 0) {
    fill(green);
    text("Your reaction time was: \n" + result + "ms\n\nPress space or click to continue", width/2, height/2-100);  
  } else {
    fill(red);
    text("You clicked too early by \n" + result + "ms\n\nPress space or click to continue", width/2, height/2-100);
  }
}
