import de.bezier.guido.*;
public final static int NUM_ROWS = 20; 
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList<MSButton>mines; //ArrayList of just the minesweeper buttons that are mined
void setup(){
    size(400,400);
    textAlign(CENTER,CENTER);
    Interactive.make(this);
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    mines = new ArrayList<MSButton>();
    for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){
    buttons[r][c] = new MSButton(r,c);
    }
    }
    setMines();
}
public void setMines(){
    while(mines.size() < buttons.length){
    int r = (int)(Math.random()*NUM_ROWS);
    int c = (int)(Math.random()*NUM_COLS);
    if(!mines.contains(buttons[r][c])){
    mines.add(buttons[r][c]);
    //System.out.println(r+","+c);
    }
    } 
}
public void draw(){
    background(0);
    if(isWon() == true)
    displayWinningMessage();
}
public boolean isWon(){ 
    int countr = 0;
    int countc = 0;
    for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){
    if(mines.contains(buttons[r][c]) && buttons[r][c].isFlagged() == true)
    countr++;
    else if(buttons[r][c].clicked == true)
    countc++;
    }
    }
    if(countr == mines.size() && countc == ((NUM_ROWS*NUM_COLS) - mines.size()))
    return true;
    return false;
}
public void displayLosingMessage(){
    text("Loser!!",250,250);
}
public void displayWinningMessage(){
    text("Winner!!",250,250);
}
public boolean isValid(int r, int c){
    if (r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
    return true;
    else
    return false;
}
public int countMines(int row, int col){
    int numMines = 0;
    for(int r = row; r < row+1; r++){
    for(int c = col; c < col+1; c++){
    if(isValid(r,c-1) == true && mines.contains(buttons[r][c-1]))
    numMines++;
    if(isValid(r-1,c-1) == true && mines.contains(buttons[r-1][c-1]))
    numMines++;
    if(isValid(r+1,c-1) == true && mines.contains(buttons[r+1][c-1]))
    numMines++;
    if(isValid(r+1,c+1) == true && mines.contains(buttons[r+1][c+1]))
    numMines++;
    if(isValid(r-1,c+1) == true && mines.contains(buttons[r-1][c+1]))
    numMines++;
    if(isValid(r,c+1) == true && mines.contains(buttons[r][c+1]))
    numMines++;
    if(isValid(r-1,c) == true && mines.contains(buttons[r-1][c]))
    numMines++;
    if(isValid(r+1,c) == true && mines.contains(buttons[r+1][c]))
    numMines++;
    }
    }
    return numMines;
}
public class MSButton{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
public MSButton (int row, int col){
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add(this); // register it with the manager
    }
    // called by manager
public void mousePressed(){
    if(mouseButton == RIGHT && flagged == true)
    flagged = false;
    clicked = false;
    if(mouseButton == RIGHT && flagged == false)
    flagged = true;
    else if(mines.contains(this))
    displayLosingMessage();
    else if(countMines(myRow, myCol) > 0)
    setLabel(countMines(myRow,myCol));
    else
    if(isValid(myRow,myCol-1) == true && buttons[myRow][myCol-1].clicked == true)
    buttons[myRow][myCol-1].mousePressed();
    if(isValid(myRow-1,myCol-1) == true && buttons[myRow-1][myCol-1].clicked == true)
    buttons[myRow-1][myCol-1].mousePressed(); 
    if(isValid(myRow+1,myCol-1) == true && buttons[myRow+1][myCol-1].clicked == true)
    buttons[myRow+1][myCol-1].mousePressed(); 
    if(isValid(myRow+1,myCol) == true && buttons[myRow+1][myCol].clicked == true)
    buttons[myRow+1][myCol].mousePressed(); 
    if(isValid(myRow-1,myCol+1) == true && buttons[myRow-1][myCol+1].clicked == true)
    buttons[myRow-1][myCol+1].mousePressed(); 
    if(isValid(myRow+1,myCol) == true && buttons[myRow+1][myCol].clicked == true)
    buttons[myRow+1][myCol].mousePressed();  
    if(isValid(myRow,myCol) == true && buttons[myRow][myCol].clicked == true)
    buttons[myRow][myCol].mousePressed(); 
    if(isValid(myRow-1,myCol) == true && buttons[myRow-1][myCol].clicked == true)
    buttons[myRow-1][myCol].mousePressed(); 
}
public void draw(){    
        if (flagged)
            fill(0);
        else if(clicked && mines.contains(this)) 
            fill(255,0,0);
        else if(clicked)
            fill(200);
        else 
            fill(100);
        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = "" + newLabel;
    }
    public boolean isFlagged()
    {
      return flagged;
    }
}
