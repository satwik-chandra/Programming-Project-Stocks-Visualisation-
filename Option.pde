// //handle different graph type by michael and Xiaowei 

class Option {
  public int x, y;
  public int h;
  public int w;
  public String command;
//coded by xiaowei command for choosing what filter option
  Option(int xpos, int ypos, String command2) {
    x = xpos; 
    y = ypos;
    this.command = command2;
    w=130;
    h=35;
  }
//coded by michael, design of widgets
  void draw() {
    fill(color(15, 7, 111));
    rect(x-10, y, w+10, h);
    fill(255, 255, 255);
    text(command, x, y+h/1.5);
  }
}
