/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void textareaNameDisplay_change(GTextArea source, GEvent event) { //_CODE_:textareaNameDisplay:274944:
  if (printG4P)println("textareaNameDisplay - GTextArea >> GEvent." + event + " @ " + millis());
} //_CODE_:textareaNameDisplay:274944:

public void textfieldMainInput_change(GTextField source, GEvent event) { //_CODE_:textfieldNameInput:900139:
  textfieldNameInput.setPromptText("Enter Team Name");
  if (printG4P)println("textfieldNameInput - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:textfieldNameInput:900139:

public void buttonSubTeam_click1(GButton source, GEvent event) { //_CODE_:buttonSubTeam:657550:
  //submit a new team
  String name = textfieldNameInput.getText();
  
  //check for repeat in name
  boolean repeatedName = false;
  for(int i =0; i < teams.size(); i++){
    if(teams.get(i).getTeamName().equals(name) ){//if a team already has the inputed name
      repeatedName= true;
      i = teams.size();
    }
  }
  
  if(!repeatedName){
    //adds the text to the 
    if ( textareaNameDisplay.getText().equals(" ") ) {
      textareaNameDisplay.setText(name);
    } else {
      textareaNameDisplay.appendText(name+"\t");
    }
    createNewTeam(name);
    textfieldNameInput.setText("");
  } else {//there has been a repeated in names so no new team is made
    textfieldNameInput.setText("");
    textfieldNameInput.setPromptText("The name that you entered is a the same as another team's name");
  }
  
  if (printG4P)println("buttonName - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:buttonSubTeam:657550:

public void checkboxCarrier_clicked(GCheckbox source, GEvent event) { //_CODE_:checkboxCarrier:371468:
  boatsInUse[0] = checkboxCarrier.isSelected();
  if (printG4P)println("checkboxCarrier - GCheckbox >> GEvent." + event + " @ " + millis());
} //_CODE_:checkboxCarrier:371468:

public void checkboxBattleship_clicked(GCheckbox source, GEvent event) { //_CODE_:checkboxBattleship:543967:
  boatsInUse[1] = checkboxBattleship.isSelected();
  if (printG4P)println("checkboxBattleship - GCheckbox >> GEvent." + event + " @ " + millis());
} //_CODE_:checkboxBattleship:543967:

public void checkboxSubmarine_clicked(GCheckbox source, GEvent event) { //_CODE_:checkboxSubmarine:881325:
  boatsInUse[3] = checkboxSubmarine.isSelected();
  if (printG4P)println("checkbox3 - GCheckbox >> GEvent." + event + " @ " + millis());
} //_CODE_:checkboxSubmarine:881325:

public void checkboxCruiser_clicked(GCheckbox source, GEvent event) { //_CODE_:checkboxCruiser:815699:
  boatsInUse[2] = checkboxCruiser.isSelected();
  if (printG4P)println("checkbox4 - GCheckbox >> GEvent." + event + " @ " + millis());
} //_CODE_:checkboxCruiser:815699:

public void checkboxPatrolship_clicked(GCheckbox source, GEvent event) { //_CODE_:checkboxPatrolship:478172:
  boatsInUse[4] = checkboxPatrolship.isSelected();
  if (printG4P)println("checkbox5 - GCheckbox >> GEvent." + event + " @ " + millis());
} //_CODE_:checkboxPatrolship:478172:

public void buttonStartFromMain_click(GButton source, GEvent event) { //_CODE_:buttonStartFromMain:703574:
  if (printG4P)println("buttonStartFromMain - GButton >> GEvent." + event + " @ " + millis());
  if ( !(teams.size()>1 && (boatsInUse[0] || boatsInUse[1] || boatsInUse[2] || boatsInUse[3] || boatsInUse[4]) ) ) {
    return;
  }
  
  windowBoatPlacement.setVisible(true);
  pickingTeam = 0;
  labelTeamPla.setText(teams.get(pickingTeam).getTeamName() );
  for (int i =0; i<5; i++) {//number of boats=5
    if (boatsInUse[i]) {
      pickingBoat = i;
      labelBoatPla.setText("Set the location of your " + boatNames[i]);
      i=5;
    }
  }
} //_CODE_:buttonStartFromMain:703574:

synchronized public void winPla_draw(PApplet appc, GWinData data) { //_CODE_:windowBoatPlacement:203391:
  appc.background(230);
} //_CODE_:windowBoatPlacement:203391:

public void textfieldBoatLoc_change(GTextField source, GEvent event) { //_CODE_:textfieldBoatLoc:356781:
  textfieldBoatLoc.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  if (printG4P)println("textfieldBoatLoc - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:textfieldBoatLoc:356781:

public void buttonEnterBoat_click(GButton source, GEvent event) { //_CODE_:buttonEnterBoat:374460:
  String positionEnter = textfieldBoatLoc.getText();
  String parts[] = positionEnter.split(",");
  boolean correctFormat = true;
  int cords[] = new int[3];
  if (parts.length == 3) {
    for (int i = 0; i<parts.length; i++) {
      try {
        cords[i] = Integer.parseInt(parts[i]) ;
      } 
      catch(Exception e) {
        correctFormat = false;
        println("Exception catch when taking user input:" + parts[i]);
      }//end of try-catch
    }//end of for
  } else {
    correctFormat = false;
  }//end of if-else for checking the number of cords given
  //Submitted boat
  if (correctFormat) {
    int xdi = 0;
    int ydi = 0;
    int zdi = 0;
    int tempPic = dropListPlaceDir.getSelectedIndex();
    if (tempPic == 0) {
      xdi = 1;
    } else if (tempPic==1) {
      ydi = 1;
    } else {
      xdi = 1;
    }
    teams.get(pickingTeam).addBoat(boatNames[pickingBoat], cords[0], cords[1], cords[2], xdi, ydi, zdi);
    //move boat and move team then move game mode
    boolean cycleTeam = true;
    for (int i = pickingBoat+1; i <5; i ++) {
      if (boatsInUse[i]) {
        cycleTeam = false;
        pickingBoat = i;
        i=5;
      }
    }//end of for - cycle boats
    if (cycleTeam) {
      for (int i =0; i<5; i++) {//number of boats=5
        if (boatsInUse[i]) {
          pickingBoat = i;
          //label is set later
          i=5;
        }
      }
      if (pickingTeam+1 == teams.size()) {
        //start the game
        labelTeamFiring.setText( teams.get(0).getTeamName() + " Team is firing");
        windowBoatPlacement.setVisible(false); 
        windowFiring.setVisible(true);
      } else {
        pickingTeam++;
      }
    }
    labelTeamPla.setText(teams.get(pickingTeam).getTeamName() );
    labelBoatPla.setText("Set the location of your " + boatNames[pickingBoat]);
  } else {//incorrect boat corriate entered
    textfieldBoatLoc.setText("");
    textfieldBoatLoc.setLocalColorScheme(GCScheme.RED_SCHEME);
  }





  if (printG4P)println("buttonEnterBoat - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:buttonEnterBoat:374460:

public void dropListPalceDir_click1(GDropList source, GEvent event) { //_CODE_:dropListPlaceDir:984675:
  if (printG4P)println("dropListPlaceDir - GDropList >> GEvent." + event + " @ " + millis());
} //_CODE_:dropListPlaceDir:984675:

synchronized public void winAtt_draw(PApplet appc, GWinData data) { //_CODE_:windowFiring:588789:
  appc.background(230);
} //_CODE_:windowFiring:588789:

public void textfieldFiring_change1(GTextField source, GEvent event) { //_CODE_:textfieldFiring:886010:
  if (printG4P)println("textfieldFiring - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:textfieldFiring:886010:

public void buttonFire_click1(GButton source, GEvent event) { //_CODE_:buttonFire:548510:
  if (printG4P)println("buttonFire - GButton >> GEvent." + event + " @ " + millis());

  //read text convert into int[4]
  String parts[] = textfieldFiring.getText().split(",");
  int componets[] = new int[4];
  boolean correctFormat = true;
  if (parts.length == 4) {
    for (int i = 0; i<parts.length; i++) {
      try {
        componets[i] = Integer.parseInt(parts[i]) ;
      } 
      catch(Exception e) {
        correctFormat = false;
        println("Exception catch when taking user input:" + parts[i]);
      }//end of try-catch
    }//end of for
  } else {
    correctFormat = false;
  }//end of if-else for checking the number of cords given


  //then convert into a plane
  if (correctFormat) {
    Plane attPlane = new Plane(componets[0], componets[1], componets[2], componets[3]);

    //check which ships were hit
    attackWithPlane(teams.get(teamFiring), attPlane);//points awarded in this funciton


    //rotate teams
    if (teamFiring+1 == teams.size()) {
      //start the game
      teamFiring=0;
    } else {
      teamFiring++;
    }
    
    labelTeamFiring.setText( teams.get(teamFiring).getTeamName() + " Team is firing");
    
  }
} //_CODE_:buttonFire:548510:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Sketch Window");
  textareaNameDisplay = new GTextArea(this, 20, 160, 260, 170, G4P.SCROLLBARS_NONE);
  textareaNameDisplay.setOpaque(true);
  textareaNameDisplay.addEventHandler(this, "textareaNameDisplay_change");
  textfieldNameInput = new GTextField(this, 20, 100, 270, 30, G4P.SCROLLBARS_NONE);
  textfieldNameInput.setPromptText("Enter Team Name");
  textfieldNameInput.setOpaque(true);
  textfieldNameInput.addEventHandler(this, "textfieldMainInput_change");
  buttonSubTeam = new GButton(this, 320, 100, 80, 30);
  buttonSubTeam.setText("Submit Team");
  buttonSubTeam.addEventHandler(this, "buttonSubTeam_click1");
  togGroup1 = new GToggleGroup();
  togGroup2 = new GToggleGroup();
  checkboxCarrier = new GCheckbox(this, 310, 180, 120, 20);
  checkboxCarrier.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  checkboxCarrier.setText("Carrier");
  checkboxCarrier.setOpaque(false);
  checkboxCarrier.addEventHandler(this, "checkboxCarrier_clicked");
  checkboxCarrier.setSelected(true);
  checkboxBattleship = new GCheckbox(this, 310, 200, 120, 20);
  checkboxBattleship.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  checkboxBattleship.setText("Battleship");
  checkboxBattleship.setOpaque(false);
  checkboxBattleship.addEventHandler(this, "checkboxBattleship_clicked");
  checkboxBattleship.setSelected(true);
  checkboxSubmarine = new GCheckbox(this, 310, 240, 120, 20);
  checkboxSubmarine.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  checkboxSubmarine.setText("Submarine");
  checkboxSubmarine.setOpaque(false);
  checkboxSubmarine.addEventHandler(this, "checkboxSubmarine_clicked");
  checkboxSubmarine.setSelected(true);
  checkboxCruiser = new GCheckbox(this, 310, 220, 120, 20);
  checkboxCruiser.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  checkboxCruiser.setText("Cruiser");
  checkboxCruiser.setOpaque(false);
  checkboxCruiser.addEventHandler(this, "checkboxCruiser_clicked");
  checkboxCruiser.setSelected(true);
  checkboxPatrolship = new GCheckbox(this, 310, 260, 120, 20);
  checkboxPatrolship.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  checkboxPatrolship.setText("Patrol ship");
  checkboxPatrolship.setOpaque(false);
  checkboxPatrolship.addEventHandler(this, "checkboxPatrolship_clicked");
  checkboxPatrolship.setSelected(true);
  labelShips = new GLabel(this, 310, 160, 130, 20);
  labelShips.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  labelShips.setText("What ship do you want?");
  labelShips.setOpaque(false);
  buttonStartFromMain = new GButton(this, 310, 300, 130, 40);
  buttonStartFromMain.setText("PLACE BOATS");
  buttonStartFromMain.setTextBold();
  buttonStartFromMain.setLocalColorScheme(GCScheme.RED_SCHEME);
  buttonStartFromMain.addEventHandler(this, "buttonStartFromMain_click");
  windowBoatPlacement = GWindow.getWindow(this, "Boat Placement", 0, 0, 480, 480, JAVA2D);
  windowBoatPlacement.noLoop();
  windowBoatPlacement.addDrawHandler(this, "winPla_draw");
  labelBoatPlacement = new GLabel(windowBoatPlacement, 40, 30, 230, 70);
  labelBoatPlacement.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  labelBoatPlacement.setText("Where do you want to place your boat?");
  labelBoatPlacement.setOpaque(false);
  textfieldBoatLoc = new GTextField(windowBoatPlacement, 40, 170, 230, 70, G4P.SCROLLBARS_NONE);
  textfieldBoatLoc.setPromptText("Boat Location in format: x,y,z");
  textfieldBoatLoc.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  textfieldBoatLoc.setOpaque(true);
  textfieldBoatLoc.addEventHandler(this, "textfieldBoatLoc_change");
  buttonEnterBoat = new GButton(windowBoatPlacement, 70, 280, 140, 50);
  buttonEnterBoat.setText("Submit Location");
  buttonEnterBoat.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  buttonEnterBoat.addEventHandler(this, "buttonEnterBoat_click");
  labelTeamPla = new GLabel(windowBoatPlacement, 40, 110, 230, 20);
  labelTeamPla.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  labelTeamPla.setText("Team");
  labelTeamPla.setOpaque(false);
  labelBoatPla = new GLabel(windowBoatPlacement, 40, 140, 230, 20);
  labelBoatPla.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  labelBoatPla.setText("My label");
  labelBoatPla.setOpaque(false);
  dropListPlaceDir = new GDropList(windowBoatPlacement, 280, 170, 70, 80, 3);
  dropListPlaceDir.setItems(loadStrings("list_984675"), 0);
  dropListPlaceDir.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  dropListPlaceDir.addEventHandler(this, "dropListPalceDir_click1");
  labelBoatDir = new GLabel(windowBoatPlacement, 280, 140, 80, 20);
  labelBoatDir.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  labelBoatDir.setText("Boat Direction");
  labelBoatDir.setOpaque(false);
  windowFiring = GWindow.getWindow(this, "ATTACK", 0, 0, 480, 480, JAVA2D);
  windowFiring.noLoop();
  windowFiring.addDrawHandler(this, "winAtt_draw");
  labelTeamFiring = new GLabel(windowFiring, 130, 70, 160, 20);
  labelTeamFiring.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  labelTeamFiring.setText("____ Team is firing");
  labelTeamFiring.setLocalColorScheme(GCScheme.RED_SCHEME);
  labelTeamFiring.setOpaque(false);
  textfieldFiring = new GTextField(windowFiring, 110, 120, 240, 30, G4P.SCROLLBARS_NONE);
  textfieldFiring.setPromptText("Plane equation in form a,b,c,d (ax+by+cz+d)");
  textfieldFiring.setLocalColorScheme(GCScheme.RED_SCHEME);
  textfieldFiring.setOpaque(true);
  textfieldFiring.addEventHandler(this, "textfieldFiring_change1");
  buttonFire = new GButton(windowFiring, 110, 190, 240, 80);
  buttonFire.setText("FIRE");
  buttonFire.setTextBold();
  buttonFire.setLocalColorScheme(GCScheme.RED_SCHEME);
  buttonFire.addEventHandler(this, "buttonFire_click1");
  windowBoatPlacement.loop();
  windowFiring.loop();
}

// Variable declarations 
// autogenerated do not edit
GTextArea textareaNameDisplay; 
GTextField textfieldNameInput; 
GButton buttonSubTeam; 
GToggleGroup togGroup1; 
GToggleGroup togGroup2; 
GCheckbox checkboxCarrier; 
GCheckbox checkboxBattleship; 
GCheckbox checkboxSubmarine; 
GCheckbox checkboxCruiser; 
GCheckbox checkboxPatrolship; 
GLabel labelShips; 
GButton buttonStartFromMain; 
GWindow windowBoatPlacement;
GLabel labelBoatPlacement; 
GTextField textfieldBoatLoc; 
GButton buttonEnterBoat; 
GLabel labelTeamPla; 
GLabel labelBoatPla; 
GDropList dropListPlaceDir; 
GLabel labelBoatDir; 
GWindow windowFiring;
GLabel labelTeamFiring; 
GTextField textfieldFiring; 
GButton buttonFire; 
