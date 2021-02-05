//handle different graph type by michael and Xiaowei

class Command {
  public int x, y;
  public int h;
  String command ="";
//coded by xiaowei command variables for choosing whether to perform command
  Command(int xpos, int ypos, String command2) {
    x = xpos; 
    y = ypos;
    command = command2;
    h=35;
  }
//coded by michael, design of widgets
  void draw() {
    fill(color(15, 7, 111));
    rect(x-5, y, textWidth(command)+10, h);
    fill(255, 255, 255);
    text(command, x, y+h/1.5);
  }

  String getCommand(int mX, int mY) {
    if ((mX > x) && (mX < (x + textWidth(command))) && ((mY > y) && (mY < (y + h)))) {
      return command;
    } else {
      return "";
    }
  }
}
