class Team {

  ArrayList<Boat> fleet = new ArrayList<Boat>();
  int score;
  String name;

  Team(String namei) {
    name = namei;
  }

  public String getTeamName() {
    return name;
  }//end og getName

  public void addBoat(String boatName, int dirX, int dirY, int dirZ, int staX, int staY, int staZ) {
    for (int i = 0; i<5; i++) {
      if (boatName.equals(boatNames[i])) {
        fleet.add( new Boat(6-i, new PVector(dirX, dirY, dirZ), new PVector(staX, staY, staZ) ) );
        i=5;
      }
    }//end of for
  }//end of setBoat


  public void attacked(Team attacker, Plane missile) {
    int addingScore = 0;
    for (int i = 0; i<fleet.size(); i++) {
      if (fleet.get(i).isAlive() ) {
        if (fleet.get(i).checkHit(missile) ) {
          addingScore += fleet.get(i).getLength();
          score-=(8-fleet.get(i).getLength());
        }
      }
    }//end of for loop
    
    if(attacker != this){
      attacker.increaseScore(addingScore);
    }
    
  }

  public void increaseScore(int inc) {
    score+= inc;
  }
}//end of Class Team
