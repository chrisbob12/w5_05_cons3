/*
 * Creative Coding
 * Week 5, 05 - Text agents
 * by Indae Hwang and Jon McCormack
 * Copyright (c) 2014 Monash University
 *
 * This sketch creates a simple agent-based simulation using text and objects
 * The sketch reads in characters from the keyboard and dynamically creates
 * new objects for each character.
 *
 */
ArrayList<AniCharacter> aniChars;

PFont font1;
PFont font2;
PFont font3;
PFont font4;
PFont font5;
PFont font6;

Table scrabbleBag;
Table styles;
int total;
int total2;

int currentCount;
int counta;
int countb;

int population;

void setup() {
  size(800, 500);
  font1 = loadFont("Acclamation-48.vlw");
  font2 = loadFont("HeftyFont-48.vlw");
  font3 = loadFont("KlavenItal-48.vlw");
  font4 = loadFont("TalonBold-48.vlw");
  font5 = loadFont("TimesHeavy-48.vlw");
  font6 = loadFont("BastionItal-48.vlw");
  textFont(font1);
  //textMode(SHAPE);

  scrabbleBag = loadTable("scrabbleBag.csv", "header");
  println(scrabbleBag.getRowCount() + "total rows in scrabbleBag");
  styles = loadTable("styles.csv", "header");
  println(styles.getRowCount() + "total rows in styles");
  
  //this section to get total number of tiles
  for (TableRow row : scrabbleBag.rows ()) {
    total = total + row.getInt("numTile");

  }// end for loop for total tiles

  //this section to get total number of styles
  for (TableRow row : styles.rows ()) {
    total2 = total2 + row.getInt("freq");
    //println(total);
  }// end for loop for total tiles


  aniChars = new ArrayList<AniCharacter>();

  smooth(8); // enable antialiasing

  counta = 1;
  countb = 0;
  population = 0;
} //end setup


void draw() {

  background(255);
  population = aniChars.size();
  for (int i = aniChars.size ()-1; i >= 0; i--) {
    AniCharacter tempObj = aniChars.get(i);
    //println(tempObj.x, tempObj.y, tempObj.fontno);//,tempObj.floatno);
    tempObj.run(); // run each char
  }
} // end draw


void keyReleased() {

  // generate random number up to total no. tiles in bag
  char tileChar = charGen();
  int style = styleGen();//to set colours and panel
  int tileVal = tileVal();
  println("style is ",style);
  println("tileVal is ",tileVal);
  
  // the if condition allows you to remove characters with backspace
  counta = counta+1;
  countb = counta%3;
  println("***counta = ", counta);
  println("***countb = ", countb);

  if (8 == int(key) && aniChars.size() > 0) {
    println("c");
    aniChars.remove(aniChars.size()-1);
  } else { 
    aniChars.add( new AniCharacter(random(width), random(height), tileChar, countb, style, aniChars.size(), tileVal));
  } //end else

  if (aniChars.size() > 0) {
    int i = aniChars.size()-1;
    println("array size =", aniChars.size());
    AniCharacter tempObj = aniChars.get(i);
    println(tempObj.x, tempObj.y, tempObj.fontno, "i =", i);
  }
} //end keyReleased

//================================================================
char charGen() {//char tileChar){

  int tempTota = 0;//running total of current 
  int tempTotb = 0;//one step behind tempTota
  char tileChar = 'z';
  String tile = "z";
  int tempKey = 0;
  int tileValue = 0;

  tempKey = int(random(total))+1;
  println("tempKey = ", tempKey);

  for (TableRow row : scrabbleBag.rows ()) {
    tempTota = tempTota + row.getInt("numTile");
    //testa = row.getInt("tileValue");    
    if ((tempKey > tempTotb)&&(tempKey <= tempTota)) {
      tile = row.getString("tile");
      if (random(1.0)>0.5) { //set proportion of lowercase characters
        tile = tile.toLowerCase();
      }
      tileChar = tile.charAt(0);
      println("tile is ", tileChar);
    }//end if testing random number against cumulative tile total
    tempTotb = tempTota;
  }// end for loop scanning tile values

  return tileChar;
}//end charGen

int styleGen() {//

  int tempTota = 0;//running total of current 
  int tempTotb = 0;//one step behind tempTota
  int style = 0;
  int tempKey = 0;
  int tileVal = 0;

  tempKey = int(random(total2))+1;
  //println("tempKey = ", tempKey);

  for (TableRow row : styles.rows ()) {
    tempTota = tempTota + row.getInt("freq");
    if ((tempKey > tempTotb)&&(tempKey <= tempTota)) {
      style = row.getInt("style");
      //tileChar = tile.charAt(0);
      //println("tileVal is ", style);
    }//end if testing random number against cumulative style total
    tempTotb = tempTota;
  }// end for loop scanning tile values

  return style;
}//end styleGen

int tileVal() {//char tileChar){

  int tempTota = 0;//running total of current 
  int tempTotb = 0;//one step behind tempTota
  int tileVal = 0;
  int tempKey = 0;
  int tileValue = 0;

  tempKey = int(random(total))+1;
  //println("tempKey = ", tempKey);
  for (TableRow row : scrabbleBag.rows ()) {
    tempTota = tempTota + row.getInt("tileVal");
    //testa = row.getInt("tileValue");    
    if ((tempKey > tempTotb)&&(tempKey <= tempTota)) {
      tileVal = row.getInt("tileVal");
      //println("tile is ", tileChar);
    }//end if testing random number against cumulative tile total
    tempTotb = tempTota;
  }// end for loop scanning tile values

  return tileVal;
}//end tileVal generation

