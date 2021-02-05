//handle different graph type by michael and Xiaowei
class ChartType {
  public int x, y;
  public int h;
  public int w;
  String command;
//coded by Xiaowei command for choosing whether to show barchart or graph
  ChartType(int xpos, int ypos, String command2) {
    x = xpos;
    y = ypos;
    this.command = command2;
    if (command=="table") {
      w=100;
      h=500;
    } else {
      w=150;
      h=35;
    }
  }
//coded by michael, design of widgets
  void draw() {
    fill(color(15, 7, 111));
    rect(x-10, y, w, h);
    fill(255, 255, 255);
    text(command, x, y+h/1.5);
  }

  String getChartType() {
    return command;
  }
}
