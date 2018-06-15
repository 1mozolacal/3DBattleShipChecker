import g4p_controls.*;

ArrayList<Team> teams = new ArrayList<Team>();
public boolean boatsInUse[] = {true,true,true,true,true};//carrier,battleship,cruiser,sub,patrol
public boolean printG4P = false;
public String boatNames[] = {"Carrier","Battle ship","Cruiser","Submarine","Patrol Boat"};


public int pickingTeam;
public int pickingBoat;

public int teamFiring;


void setup(){
  size(480,480);
  createGUI();
  windowBoatPlacement.setVisible(false);
  windowFiring.setVisible(false);
}

void draw(){
  background(200,200,200);
}


void createNewTeam(String name){
  teams.add(new Team(name));
}

void attackWithPlane(Team attacker, Plane missile){
  for(int i=0; i<teams.size();i++){
    teams.get(i).attacked(attacker, missile);
  }
}
