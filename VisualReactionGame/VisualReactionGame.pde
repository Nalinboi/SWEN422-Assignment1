import java.util.*;

float level = 0;  // There are three screens or 'levels' - the main menu, the reaction game, and the results page

color red = color(255,0,0);
color green = color(0,255,0);
color blue = color(0,0,255);

color black = color(0);
color white = color(255);

// This is a random time which is between 3-10 seconds after the current time.
float randomAppearTime = millis() + random(2000, 8000); // RandomAppearTime is when the shape randomly changes colour

float shapeClickedTime = 0; // The time the shape is clicked is put in a global variable for the results page to present. 

float currentResult = 0;
ArrayList<Float> reactionTimeResults = new ArrayList<Float>();

String colorOrBlack = "COLOR";
String squareOrCircle  = "SQUARE";

void setup() {
  size(1500, 750); // size of the screen
  //fullScreen();
  textSize(32); // size of all the text in the game
  noStroke(); // No stroke on the shapes
  textAlign(CENTER); // Texts will be centered to the x and y coordinates assigned.
  background(black); // The background colour (a dark grey). We could have 0 for black or 255 for white.
}

void reset(){
  // This is a random time which is between 3-10 seconds after the current time.
  randomAppearTime = millis() + random(2000, 8000); // RandomAppearTime is when the shape randomly changes colour
  
  shapeClickedTime = 0; // The time the shape is clicked is put in a global variable for the results page to present. 
  
  currentResult = 0;
  reactionTimeResults = new ArrayList<Float>();
}

void nextLevel() {
  if(level == 0) { // Main menu
    reset();
    level = 1; // If we are in the main menu, the next level (1) will be the reaction game.
    
    // We store a random time between 3-10 seconds ahead of the current time. 
    randomAppearTime = millis() + random(2000, 8000); // This is when the shape will change colour
    
  } else if (level == 1){ // Reaction game
    level = 2; // If we are in the reaction level, the next level (2) will be the results page.
    shapeClickedTime = millis(); // We put results here as this method is only called once on an event, rather than forever in the draw sections
      
    currentResult = shapeClickedTime - (randomAppearTime);
    if(currentResult > 0){ 
      reactionTimeResults.add(0, currentResult); // We append the result to the list of results if it was valid
    }
    
    
  } else { // Results page 
    level = 1; // If we are in the results page, the next level (1) will be the game again.
    randomAppearTime = millis() + random(2000, 8000); // This is when the shape will change colour
  }
}

void keyPressed()
{
  if (keyCode == 32) { // 32 is ascii for spacebar     
    nextLevel(); // If the user presses spacebar, the user will go to the next level
  } else if (keyCode == 27) { // 27 is ascii for escape - here you should use this to go to the main menu     
    nextLevel(); //
  }

  if (level == 0) {
    if (keyCode == 90) { // 90 ascii for "z"
      colorOrBlack = "COLOR";
      println("z");
    } else if (keyCode == 88) { // 120 ascii for "x"
      colorOrBlack = "BLACK";
      println("x");
    } else if (keyCode == 78) { // 78 ascii for "n"
      squareOrCircle  = "SQUARE";
      println("n");
    } else if (keyCode == 77) { // 78 ascii for "M"
      squareOrCircle  = "CIRCLE";
      println("m");
    }
  }
}

//void mouseClicked(){
//  nextLevel(); // If the user clicks the screen, the user will go to the next level
//}

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
  background(white); // have to keep calling this so a new screen is rendered
  fill(black); // Fill colour is blue
  //textFont(title);
  text("Main Menu:\n Click or press space to play the game", width/2, 100); // the title
  
  
  textSize(64); // FIRST OPTION, GREEN AND RED
  fill(green);
  text("Green", width/5, 300);
  fill(red);
  text("Red", width/5, 400);
  
  
  fill(black); // SECOND OPTION, BLACK AND WHITE
  text("Black", 2*width/5, 300);
  text("White", 2*width/5, 400);  
  textSize(32);
  
  //THIRD OPTION, SQUARE
  rect((3*width/5)-100, 325-100, 200, 200); // the rectangle you are supposed to click on for reaction times.
  
  //FOURTH OPTION, CIRCLE
  ellipse((4*width/5), 325, 200, 200); // the rectangle you are supposed to click on for reaction times.
  
  stroke(red); // RED OUTLINE TO SHOW WHAT OPTION IS THE SELECTED ONE
  strokeWeight(6);
  int selection1 = colorOrBlack.equals("COLOR") ? 1 : 2;  // EITHER SELECTES GREEN AND RED OR BLACK AND WHITE
  int selection2 = squareOrCircle.equals("SQUARE") ? 3 : 4;   // EITEHR SELECTES POSITIONING FOR SQUARE OR CIRCLE. 
  //println(colorOrBlack);
  noFill();
  rect((selection1*width/5)-120, 325-120, 240, 240); // the rectangle selecting the first option
  rect((selection2*width/5)-120, 325-120, 240, 240); // the rectangle selecting the first option
  noStroke();
  fill(black); 
}

void level1() {
  background(white);
  fill(black);
  text("Click or press Space\n when shape turns Green", width/2, 100);
  if (millis() > randomAppearTime) { // After a random amount of time, change the shape colour
    fill(green);
  }
  else { // Before the random time keep the colour as red
    fill(red);
  }
  //rect(20, 110, width-50, height-130); // the rectangle you are supposed to click on for reaction times.
  rect((width/2)-150, (height/2)-150, 300, 300); // the rectangle you are supposed to click on for reaction times.
}

void results() {
  background(white); 
  if(currentResult >= 0) {
    fill(green);
    text("Your reaction time was: \n" + currentResult + "ms: ", width/2, 100);  // We can have in seconds or milli seconds
  } else {
    fill(red);
    text("You clicked too early by " + currentResult + "ms\n(Try again)", width/2, 100);
  }
  
  int resultsListSize = (reactionTimeResults.size() < 5) ? reactionTimeResults.size() : 5;  
  
  fill(black);
  text("Previous valid results: ", (width/2)-200, 250);
  for (int i = 0; i < resultsListSize; i++) {
    text((i+1) + ") " + reactionTimeResults.get(i) + "ms", (width/2)-200, 300 + (i*50));
  }
  stroke(2);
  line(width/2, 200, width/2, 600);    
  noStroke(); // No stroke on the shapes

  if (resultsListSize == 5) {
      text("Summary of \nall good results: ", (width/2)+200, 200);
      text("Fastest: " + Collections.max(reactionTimeResults), (width/2)+200, 300);
      text("Slowest: " + Collections.min(reactionTimeResults), (width/2)+200, 350);
      text("Average: " + calculateAverage(), (width/2)+200, 400);
      //text("Deviation: ", (width/2)+200, 450);
  }
}

float calculateAverage(){
  float sum = 0;
  for(float f : reactionTimeResults) {
    sum += f;
  }
  return sum/reactionTimeResults.size();
}
