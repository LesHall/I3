// Inventor's Invention Inventer
// abbreviated as III I3 or I^3
// 
// Copyright (c) 2019 Lester Crossman Hall
// Originated by Les Hall and friends (including "The Kids" of all ages). 
// Programming started 4 JAN 2019.
// Released under Creative Commons Share Alike Commercial Alowed with Traceback. 
//   Traceback is my modification meaning you must notify and link the author from whom you copied. 
//   This way (with Traceback) we can fully navigate the map of all authors of the code. 
// 



// includes



// declarations



// global variables
  int maxEntries = 7;
String filename = "10.txt";
int subsetLines = 1000;
String[] lines = {};
String[] sentences = {};
String[] words = {};
String[] dictionary = {};
int index = 0;
int[] bgColor = {0, 0, 0};
int[] textColor = {255-bgColor[0], 255-bgColor[1], 255-bgColor[2]};
int rateOfFrames = 4;
int numDisplayed = 32;
int sizeOfText = 32;
int fadeAmount = 2;
int fadeHeight = numDisplayed/2;
boolean rainbowText = !true;
boolean greenText = true;



void setup() {
  
  // initialize graphics stuff
  size(800, 1000, P3D);
  background(bgColor[0], bgColor[1], bgColor[2]);
  fill(textColor[0], textColor[1], textColor[2]);
  stroke(textColor[0], textColor[1], textColor[2]);
  sizeOfText = height/numDisplayed;
  textSize(sizeOfText);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  frameRate(rateOfFrames);
  
  // read in the text file
  lines = loadStrings(filename);
  
  // shorten to subset to reduce delays
  sentences = subset(lines, 1, subsetLines);
  
  // add sentence diagraming here; for now just

  // squash into a list of words
  // begin by looping through the sentences
  for (int sentence = 0; sentence < sentences.length; sentence++) {
    // separate each sentence into tokens (words)
    String[] tokens = split(sentences[sentence], ' ');
    // make room for the new words
    if (tokens.length > 0) {
      expand(words, tokens.length);
    }
    // put the words into the words array
    for (int token = 0; token < tokens.length; token++) {
      words = (String[]) append(words, tokens[token]);
    }
  }
  
  // sort the words and assign them to the dictionary array
  dictionary = sort(words);
  
  // add remove punctuation from the dictionary
  
  // add remove duplicate words from the dictionary
}



void draw() {
  
  // display Authors
  //textAlign(LEFT, BOTTOM);
  //textSize(sizeOfText/2);
  //text("Les Hall and The Kids", 0, height);
  //textSize(sizeOfText);
  //textAlign(CENTER, CENTER);
  
  // select entries to display
  int numEntries = ceil( random(maxEntries) );
  String[] entries = {};
  for (int e = 0; e < numEntries; e++) {
    entries = (String[]) append(entries, dictionary[ceil(random(dictionary.length))]);
  }

  // set positions on window
  int horizontal = width/2;
  int vertical = floor(sizeOfText * (index % numDisplayed) + sizeOfText/2 );
  
  // fade away part of the screen
  fill(bgColor[0], bgColor[1], bgColor[2], fadeAmount);
  stroke(bgColor[0], bgColor[1], bgColor[2], fadeAmount);
  for(int v = 0; v < fadeHeight; v++) {
    rect(horizontal, vertical-(v-1)*sizeOfText, width, fadeHeight*sizeOfText);
  }

  // shift the text color
  for (int c = 0; c < 3; c++) {
    textColor[c] = textColor[c] + floor(random(32) - 16);
    if (textColor[c] < 0) {
      textColor[c] = 255 + textColor[c];
    }
    textColor[c] %= 256;
  }

  // set the drawing colors
  if (rainbowText) {
    fill(textColor[0], textColor[1], textColor[2]);
    stroke(textColor[0], textColor[1], textColor[2]);
  }
  if (greenText) {
    // set text back to green for clarity
    fill(0, 255, 0);
    stroke(0, 255, 0);
  }

  // print the currently proposed invention to the console
  println(entries);
  // print the currently proposed invention to the screen
  String proposal = "";
  for (int e = 0; e < numEntries; e++) {
    proposal += entries[e] + " ";
  }
  text(proposal, horizontal, vertical);
  
  // go to next dictionary entry next frame
  index++;
  index %= (dictionary.length);
}
