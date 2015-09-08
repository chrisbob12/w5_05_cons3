// AniCharacter class
//
// 
class AniCharacter {

  float x, y;
  float nOff_x;
  float nOff_y;
  float dynamic;
  float dynamic_c;
  float size_font;
  float size_shape;
  char letter;
  int fontno;
  int style;
  int ID;
  int tileVal;
  float targetx;

  AniCharacter(float x_, float y_, char c_, int fontno_, int style_, int ID_, int tileVal_) {

    x = x_;
    y = y_;
    nOff_x = random(3000);
    nOff_y = random(3000);

    letter = c_;
    size_font = random(24, 54);
    size_shape = size_font + random(10, 50);
    dynamic_c = random(-0.1, 0.1);
    fontno = fontno_;
    style = style_;
    ID = ID_;
    tileVal = tileVal_;
  }

  //================================================================
  void run() {

    switch(fontno) {
    case 0:
      textFont(font1);
      break;
    case 1:
      textFont(font2);
      break;
    case 2:
      textFont(font3);
      break;   
    case 3:
      textFont(font4);
      break;
    case 4:
      textFont(font5);
      break;
    case 5:
      textFont(font6);
      break;
    } //end fontno switch

    // speed of motion
    //first create a modifier for y speed to make lines
    //at 1/4 and 3/4 height of panel 'sticky'
    float theta = map(y, 0, height, 0, 4*PI); //4*PI works too, and 8
    //println("theta = ",theta," cos theta = ", cos(theta));
    float nOff_yMod = (cos(theta)+1)/2;
    //println("nOff_yMod = ",nOff_yMod);
    //float nOff_y2 = nOff_y*nOff_yMod;


    nOff_y += 0.0010*nOff_yMod;

    y = height*noise(nOff_y);

    //*****Lateral Motion*****
    //int population = aniChars.size;
    float distance = 0;
    float factor2 = 0;
    float factor3 = 0;
    float xMod = 0;

    //scan through other agents to find closest & most attractive
    for (int i = aniChars.size ()-1; i >= 0; i--) {
      if (i != ID) {
        AniCharacter tempObj = aniChars.get(i);
        distance = x - tempObj.x + textWidth(letter)/2;
        //factor2 = (tempObj.tileVal/10)*distance/width;
        factor2 = ((tempObj.tileVal-5)/5)*distance/width;
        if (factor2 < factor3) {
          xMod = factor2;
          factor3 = factor2;
        } // end if to find minimum
      }
      nOff_x += 0.0003*xMod;
      x = width*noise(nOff_x);
    }


    //*****end of Lateral Motion*****
    visual();
  }

  /*
   * visual
   * draw the char with special cases for some letters
   */
  void visual() {

    textSize(size_font);
    float textWidth =  textWidth(letter);
    float ascent = textAscent();

    if (letter == ' ') {
      fill(0);
      text(letter, x-textWidth/2, y+ascent/2);
    } else {

      switch(style) {
      case 1:
        fill(0);
        //noStroke();
        text(letter, x-textWidth/2, y+ascent/2);
        break;

      case 2:
        fill(255, 0, 0);
        //noStroke();
        text(letter, x-textWidth/2, y+ascent/2);
        break;

      case 3:
        rectMode(CENTER);
        fill(0);
        noStroke();
        rect(x, y, textWidth*1.2, ascent*1.2 );
        fill(255);
        //noStroke();
        text(letter, x-textWidth/2, y+ascent/2);
        //fill(255);
        break;

      case 4:
        rectMode(CENTER);
        fill(255, 0, 0);
        noStroke();
        rect(x, y, textWidth*1.2, ascent*1.2 );
        fill(255);
        //noStroke();
        text(letter, x-textWidth/2, y+ascent/2);
        //fill(255);
        break;
      } //end switch for styles
    } //end else for non whitespace chars
  } //end visual
}

