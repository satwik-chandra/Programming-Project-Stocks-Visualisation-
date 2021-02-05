//the mainline just converts the csv file into an array stored in an array list so that we dont have to explicitly set the size of the array. then it gets those string objects to print in on a black background
// Mainline oranised by Satwik and Haoyu
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.Date;
import java.util.Collections;

// screensize
final int SCREENX = 1800;
final int SCREENY = 1000;
ArrayList<Textbox> textboxes = new ArrayList<Textbox>();
ArrayList<Command> commands = new ArrayList<Command>();
String command="";// serach or refresh or exit
PFont font; // initialising the font variable
String[] allLines; // all the lines of the data
Textbox companyTB; // Textbox to enter the company name
Textbox startDateTB; // textbox to enter the startDate
Textbox endDateTB;// text box to enter the end date
int pageStartIndex=0; // this indicates the index of the data in a new page in the data table
ArrayList<DataPoint> tickerDatas; // the datas
String chartType="linechart";

ChartType lineChart ; // chart type for line chart
ChartType histogram ; // chart type for histogram
ChartType table;

Option lowData; // option for the low data
Option highData; // option for the high data
Option openData; // option for the open data
Option closeData; // option for the close data
Option adjustedData; // option for the adjusted data
Option allData; // option for the all data

// boolean conditions for showing the graph of diff types graphs
boolean low=true;
boolean high=true;
boolean open=true;
boolean close=true;
boolean adjusted=true;
boolean all=true;
void settings()
{
  size(SCREENX, SCREENY);
}
void setup() {
  // COMPANY TEXTBOX
  companyTB = new Textbox(200, 103, 200, 35);
  allLines = loadStrings("daily_prices1k.csv");
  // PASSWORD TEXTBOX
  // CONFIGURED USING THE CLASS CONSTRACTOR
  startDateTB = new Textbox(200, 153, 200, 35);
  startDateTB.BorderWeight = 1;
  startDateTB.BorderEnable = true;
  // PASSWORD TEXTBOX
  // CONFIGURED USING THE CLASS CONSTRACTOR
  endDateTB = new Textbox(200, 203, 200, 35);
  endDateTB.BorderWeight = 1;
  endDateTB.BorderEnable = true;
  // positions for the textboxes of three diff commands
  Command searchOpt = new Command(90, 270, " search");
  Command refreshOpt = new Command(225, 270, "refresh ");
  Command exitOpt = new Command(365, 270, "  exit  ");
  // positions for the textboxes of the two diff types of graphs
  lineChart = new ChartType(1690, 1, "linechart");
  histogram= new ChartType(1690, 31, "barchart");
  table= new ChartType(0, 0, "table");
  tickerDatas = new ArrayList<DataPoint>();
  // show the input box
  textboxes.add(companyTB);  
  textboxes.add(startDateTB);
  textboxes.add(endDateTB);
  // show the options box
  commands.add(searchOpt);
  commands.add(refreshOpt);
  commands.add(exitOpt);
  // positions for the diff showing options
  lowData = new Option(70, 370, "low_price");
  highData= new Option(220, 370, "high_price");
  openData= new Option(370, 370, "open_price");
  closeData= new Option(70, 420, "close_price ");
  adjustedData= new Option(220, 420, " adj_price");
  allData= new Option(370, 420, "     All  ");
}

void draw()
{
  background(48, 139, 206);
  // LABELS designed by Michael
  fill(250, 250, 250);
  textSize(60);
  text("Stock Market", 70, 60);
  textSize(15);
  text("The formate of date is yyyy-MM-dd", 110, 80);
  textSize(24);
  text("Company: ", 70, 130);
  text("Start Date: ", 70, 180);
  text("End Date: ", 70, 230);
  textSize(24);
  text("A programming project built by Michael Sweeney, Xiaowei Yang, Satwik Chandra and Haoyu Wang", 50, 950);
  textSize(50);
  text("Filter Options", 70, 355);

  
  // DRAW THE TEXTBOXES
  // code by michael
  for (Textbox t : textboxes) {
    t.draw();
  }
  for (Command op : commands) {
    op.draw();
  }
  // show all the diff types of graphs
  lineChart.draw();
  histogram.draw();
  lowData.draw();
  highData.draw();
  openData.draw();
  closeData.draw();
  adjustedData.draw();
  allData.draw();    
  lineChart.draw();  //show line chart
  histogram.draw();  //show bar chart
  // determine the command that has been selected
  if (command.equals(" search")) {
    if (!companyTB.Text.equals("")) {
      try {
        if (chartType.equals("linechart")) {
          showLineChartByTicker(companyTB.Text, startDateTB.Text, endDateTB.Text);
          showTable(companyTB.Text, startDateTB.Text, endDateTB.Text);
        } else if (chartType.equals("barchart")) {
          showHistogramByTicker(companyTB.Text, startDateTB.Text, endDateTB.Text);
          showTable(companyTB.Text, startDateTB.Text, endDateTB.Text);
        }
      }
      catch (Exception e) {
        showException();
      }
    } else {
      showError();
    }
  } else if (command.equals("refresh ")) {
    // nothing;
  } else if (command.equals("  exit  ")) {
    exit();
  }
 //HAOYU'S part, show the text of axis
 if( command.equals(" search")){
  float s = -5;
  float v = 80;
  pushMatrix();
  translate(s,v);
  rotate(-HALF_PI);
  textSize(25);
  text("PRICE",0,0);
  popMatrix();
 }
 if( command.equals(" search")){
  float s = 1162;
  float v = 936;
  pushMatrix();
  translate(s,v);
  text("TIME",0,0);
  popMatrix();
 }
//----------------------------------
  
  
  
}
// handle the selection of mouse
// Xiaowei's part
void mousePressed()
{
  if ((mouseX > lineChart.x) && (mouseX < (lineChart.x + lineChart.w)) && ((mouseY > lineChart.y) && (mouseY < (lineChart.y + lineChart.h))))
    chartType=lineChart.getChartType();
  if ((mouseX > histogram.x) && (mouseX < (histogram.x + histogram.w)) && ((mouseY > histogram.y) && (mouseY < (histogram.y + histogram.h))))
    chartType=histogram.getChartType();
  if ((mouseX > histogram.x) && (mouseX < (histogram.x + histogram.w)) && ((mouseY > histogram.y) && (mouseY < (histogram.y + histogram.h))))
    chartType=histogram.getChartType();
  // if the text boxes have been selected,the corresponding image will disappear
  if ((mouseX > highData.x) && (mouseX < (highData.x + highData.w)) && ((mouseY > highData.y) && (mouseY < (highData.y + highData.h))))
    high=!high;
  if ((mouseX > lowData.x) && (mouseX < (lowData.x + lowData.w)) && ((mouseY > lowData.y) && (mouseY < (lowData.y + lowData.h))))
    low=!low;  
  if ((mouseX > openData.x) && (mouseX < (openData.x + openData.w)) && ((mouseY > openData.y) && (mouseY < (openData.y + openData.h))))
    open=!open;
  if ((mouseX > closeData.x) && (mouseX < (closeData.x + closeData.w)) && ((mouseY > closeData.y) && (mouseY < (closeData.y + closeData.h))))
    close=!close;
  if ((mouseX > adjustedData.x) && (mouseX < (adjustedData.x + adjustedData.w)) && ((mouseY > adjustedData.y) && (mouseY < (adjustedData.y + adjustedData.h))))
    adjusted=!adjusted;
  if (!all&&(mouseX > allData.x) && (mouseX < (allData.x + allData.w)) && ((mouseY > allData.y) && (mouseY < (allData.y + allData.h)))) {
    high=true;
    low =true;
    open =true;
    close =true;
    adjusted=true;
    all=true;
  } else if (all&&(mouseX > allData.x) && (mouseX < (allData.x + allData.w)) && ((mouseY > allData.y) && (mouseY < (allData.y + allData.h)))) {
    high=false;
    low =false;
    open =false;
    close =false;
    adjusted=false;
    all=false;
  }
  for (Textbox t : textboxes) {
    t.PRESSED(mouseX, mouseY); //text box mouse action check selected, if not stop input
  }
  for (Command op : commands) {
    String comm = op.getCommand(mouseX, mouseY); // if the mouse is clicked in certatin area a certain command is triggered
    if (!comm.equals("")) {
      command=comm;
    }
  }
}
// handle keyboard input
void keyPressed ()
{
  for (Textbox t : textboxes) {
    if (t.KEYPRESSED(key, (int)keyCode)) {
    }
  }
}

void showError() {
  translate(width/3, 0);
  text("Please enter the company name", width/3, 100);
  translate(-width/3, 0);
}

void showException() {
  translate(width/3, 0);
  text("Wrong date input format", width/3, 100);
  translate(-width/3, 0);
}

void showLineChartByTicker(String tickerName, String startTime, String endTime) throws Exception {
  translate(width/3-30, 0);
  textSize(12);
  tickerDatas.clear();
  ArrayList<DataPoint> rawDatas = new ArrayList<DataPoint>();

  for (int i=0; i<allLines.length; i++) {
    String[] oneLine = allLines[i].split(",");
    if (oneLine[0].equals(tickerName)) { // compare to the tickername then add to arraylist
      DataPoint dataPoint = new DataPoint(oneLine);
      rawDatas.add(dataPoint);
    }
  }
  for (DataPoint data : rawDatas) { // select the data in the data range
    data.filterDate(startTime, endTime);
  }

  for (DataPoint data : rawDatas) {
    if (data.isValid) {
      tickerDatas.add(data);
    }
  }

  Collections.sort(tickerDatas); // sort by date ascend

  long minDate ; // start date
  long maxDate ; // end date
  float minFloat = Float.MAX_VALUE;
  float maxFloat = Float.MIN_VALUE;
  //Map the maximum and minimum values to the Y range to ensure image integrity
  if (tickerDatas.size()!=0) {
    minDate = tickerDatas.get(0).date.getTime();
    maxDate = tickerDatas.get(tickerDatas.size()-1).date.getTime();
    for (int i =0; i<tickerDatas.size(); i++) {
      if (tickerDatas.get(i).open_price >maxFloat) {
        maxFloat = tickerDatas.get(i).open_price;
      }
      if (tickerDatas.get(i).close_price >maxFloat) {
        maxFloat = tickerDatas.get(i).close_price;
      }
      if (tickerDatas.get(i).adjusted_close >maxFloat) {
        maxFloat = tickerDatas.get(i).adjusted_close;
      }
      if (tickerDatas.get(i).low >maxFloat) {
        maxFloat = tickerDatas.get(i).low;
      }
      if (tickerDatas.get(i).high >maxFloat) {
        maxFloat = tickerDatas.get(i).high;
      }
      if (tickerDatas.get(i).open_price < minFloat) {
        minFloat = tickerDatas.get(i).open_price;
      }
      if (tickerDatas.get(i).close_price < minFloat) {
        minFloat = tickerDatas.get(i).close_price;
      }
      if (tickerDatas.get(i).adjusted_close < minFloat) {
        minFloat = tickerDatas.get(i).adjusted_close;
      }
      if (tickerDatas.get(i).low < minFloat) {
        minFloat = tickerDatas.get(i).low;
      }
      if (tickerDatas.get(i).high < minFloat) {
        minFloat = tickerDatas.get(i).high;
      }
    }
    //text(tickerName, width/3, 20);
    //Guidance for the colour of the lines
    text("open_price", 50, 20);
    stroke(0, 255, 0);
    line(150, 15, 190, 15);

    text("close_price", 50, 35);
    stroke(255, 255, 0);
    line(150, 20+10, 190, 30);

    text("adjusted_close", 50, 50);
    stroke(255, 0, 0);
    line(150, 50, 190, 50);

    text("low_price", 50, 65);
    stroke(0, 0, 255);
    line(150, 65, 190, 65);

    text("high_price", 50, 20+60);
    stroke(0, 255, 255);
    line(150, 80, 190, 80);
    //sketch the axis
    stroke(0);
    strokeWeight(2);
    line(0, 0, 0, height-90);
    line(0, height-90, width, height-90);
    strokeWeight(1);

    //Map the maximum and minimum values to the Y range to ensure image integrity
    for (int i =0; i<tickerDatas.size()-1; i++) {
      float xPos = map(tickerDatas.get(i).date.getTime(), minDate, maxDate, 50*2, width*2/3-50);
      float openPos = map(tickerDatas.get(i).open_price, maxFloat, minFloat, 20*5, height*9/10-20);
      float closePos = map(tickerDatas.get(i).close_price, maxFloat, minFloat, 20*5, height*9/10-20);
      float adjustedPos = map(tickerDatas.get(i).adjusted_close, maxFloat, minFloat, 20*5, height*9/10-20);
      float lowPos = map(tickerDatas.get(i).low, maxFloat, minFloat, 20*5, height*9/10-20);
      float highPos = map(tickerDatas.get(i).high, maxFloat, minFloat, 20*5, height*9/10-20);
      float xPos2 = map(tickerDatas.get(i+1).date.getTime(), minDate, maxDate, 50*2, width*2/3-50);
      float openPos2 = map(tickerDatas.get(i+1).open_price, maxFloat, minFloat, 20*5, height*9/10-20);
      float closePos2 = map(tickerDatas.get(i+1).close_price, maxFloat, minFloat, 20*5, height*9/10-20);
      float adjustedPos2 = map(tickerDatas.get(i+1).adjusted_close, maxFloat, minFloat, 20*5, height*9/10-20);
      float lowPos2 = map(tickerDatas.get(i+1).low, maxFloat, minFloat, 20*5, height*9/10-20);
      float highPos2 = map(tickerDatas.get(i+1).high, maxFloat, minFloat, 20*5, height*9/10-20);
      if (i==0) {
        text(tickerDatas.get(i).dateStr, xPos, height*9/10-20);
      }
      if (i==tickerDatas.size()-2) { // show the last date's data and date
        if (open) {
          fill(0, 255, 0);
          ellipse(xPos2, openPos2, 2, 2);
          text(tickerDatas.get(i).open_price, xPos2, openPos2);
        }
        if (close) {
          fill(255, 255, 0);
          ellipse(xPos2, closePos2, 2, 2);
          text(tickerDatas.get(i+1).close_price, xPos2, closePos2);
        }
        if (adjusted) {
          fill(255, 0, 0);
          ellipse(xPos2, adjustedPos2, 2, 2);
          text(tickerDatas.get(i+1).adjusted_close, xPos2, adjustedPos2);
          ellipse(xPos2, lowPos2, 2, 2);
        }
        if (low) {
          fill(0, 0, 255);
          text(tickerDatas.get(i+1).low, xPos2, lowPos2);
          ellipse(xPos2, highPos2, 2, 2);
        }
        if (high) {
          fill(0, 255, 255);
          text(tickerDatas.get(i+1).high, xPos2, highPos2);
          text(tickerDatas.get(i+1).dateStr, xPos2, height*9/10-20);
        }
      }
     
      //draw all lines and plot all points in diff conditions
      if (open) {
        stroke(0, 255, 0);
        line(xPos, openPos, xPos2, openPos2);
        fill(0, 255, 0);
        ellipse(xPos, openPos, 2, 2);
        //text(tickerDatas.get(i).open_price, xPos, openPos);
      }
      if (close) {
        stroke(255, 255, 0);
        line(xPos, closePos, xPos2, closePos2);
        fill(255, 255, 0);
        ellipse(xPos, closePos, 2, 2);
        //text(tickerDatas.get(i).close_price, xPos, closePos);
      }
      if (adjusted) {
        stroke(255, 0, 0);
        line(xPos, adjustedPos, xPos2, adjustedPos2);
        fill(255, 0, 0);
        ellipse(xPos, adjustedPos, 2, 2);
        //text(tickerDatas.get(i).adjusted_close, xPos, adjustedPos);
      }
      if (low) {
        stroke(0, 0, 255);
        line(xPos, lowPos, xPos2, lowPos2);
        fill(0, 0, 255);
        ellipse(xPos, lowPos, 2, 2);
        //text(tickerDatas.get(i).low, xPos, lowPos);
      }
      if (high) {
        stroke(0, 255, 255);
        line(xPos, highPos, xPos2, highPos2);
        fill(0, 255, 255);
        ellipse(xPos, highPos, 2, 2);
        //text(tickerDatas.get(i).high, xPos, highPos);
      }
    }
  }
}
//draws table-----Haoyu's Part
void showTable(String tickerName, String startTime, String endTime) throws Exception {
  //translate(width/3-30, 0);
  textSize(12);
  tickerDatas.clear();
  ArrayList<DataPoint> rawDatas = new ArrayList<DataPoint>();
  for (int i=0; i<allLines.length; i++) {
    String[] oneLine = allLines[i].split(",");
    if (oneLine[0].equals(tickerName)) {  // compare to the tickername then add to arraylist
      DataPoint dataPoint = new DataPoint(oneLine);
      rawDatas.add(dataPoint);
    }
  }
  for (DataPoint data : rawDatas) { // select the data in the data range
    data.filterDate(startTime, endTime);
  }

  for (DataPoint data : rawDatas) {
    if (data.isValid) {
      tickerDatas.add(data);
    }
  }

  Collections.sort(tickerDatas); // sort by date ascend
  long minDate ; // start date
  long maxDate ; // end date
  float minFloat = Float.MAX_VALUE;
  float maxFloat = Float.MIN_VALUE;
  //Map the maximum and minimum values to the Y range to ensure image integrity
  if (tickerDatas.size()!=0) {
    minDate = tickerDatas.get(0).date.getTime();
    maxDate = tickerDatas.get(tickerDatas.size()-1).date.getTime();
    for (int i =0; i<tickerDatas.size(); i++) {
      if (tickerDatas.get(i).open_price >maxFloat) {
        maxFloat = tickerDatas.get(i).open_price;
      }
      if (tickerDatas.get(i).close_price >maxFloat) {
        maxFloat = tickerDatas.get(i).close_price;
      }
      if (tickerDatas.get(i).adjusted_close >maxFloat) {
        maxFloat = tickerDatas.get(i).adjusted_close;
      }
      if (tickerDatas.get(i).low >maxFloat) {
        maxFloat = tickerDatas.get(i).low;
      }
      if (tickerDatas.get(i).high >maxFloat) {
        maxFloat = tickerDatas.get(i).high;
      }
      if (tickerDatas.get(i).open_price < minFloat) {
        minFloat = tickerDatas.get(i).open_price;
      }
      if (tickerDatas.get(i).close_price < minFloat) {
        minFloat = tickerDatas.get(i).close_price;
      }
      if (tickerDatas.get(i).adjusted_close < minFloat) {
        minFloat = tickerDatas.get(i).adjusted_close;
      }
      if (tickerDatas.get(i).low < minFloat) {
        minFloat = tickerDatas.get(i).low;
      }
      if (tickerDatas.get(i).high < minFloat) {
        minFloat = tickerDatas.get(i).high;
      }
    }
    textSize(60);
    text(tickerName, width/3, 50);
    //Guidance for the colour of the lines
    int line=500;
    textSize(20);
    stroke(0);
    strokeWeight(2);
    line(-570, line-30, 0, line-30);
    line(-570, 910, 0, 910);
    fill(255);

    text("open price", -570, line-10);
    stroke(0);
    strokeWeight(2);
    line(-570, line, 0, line);
    line(-460, line-30, -460, 910);

    text("close price", -455, line-10);
    line(-345, line-30, -345, 910);
    stroke(0);
    strokeWeight(2);

    text("adjusted close", -333, line-10);
    line(-180, line-30, -180, 910);
    stroke(0);
    strokeWeight(2);

    text("high", -164, line-10);
    line(-105, line-30, -105, 910);
    stroke(0);

    text("low", -72, line-10);
    stroke(0);
    strokeWeight(2);
    line(-570, line-30, 0, line-30);
    line+=20;

    for (int i =0; i<tickerDatas.size(); i++) {    
      if (line<920) {
        text(tickerDatas.get(i).open_price, -555, line);
        text(tickerDatas.get(i).close_price, -442 , line);
        text(tickerDatas.get(i).adjusted_close, -300, line);
        text(tickerDatas.get(i).high, -178, line);
        text(tickerDatas.get(i).low, -90, line);
      }
      line += 20;
    }
  }
}
// draw the histogram
void showHistogramByTicker(String tickerName, String startTime, String endTime) throws Exception {
  translate(width/3-30, 0);
  textSize(12);
  tickerDatas.clear();
  ArrayList<DataPoint> rawDatas = new ArrayList<DataPoint>();
  for (int i=0; i<allLines.length; i++) {
    String[] oneLine = allLines[i].split(",");
    if (oneLine[0].equals(tickerName)) {  // compare to the tickername then add to arraylist
      DataPoint dataPoint = new DataPoint(oneLine);
      rawDatas.add(dataPoint);
    }
  }
  for (DataPoint data : rawDatas) { // select the data in the data range
    data.filterDate(startTime, endTime);
  }

  for (DataPoint data : rawDatas) {
    if (data.isValid) {
      tickerDatas.add(data);
    }
  }
  
  Collections.sort(tickerDatas); // sort by date ascend

  long minDate ;
  long maxDate ;
  float minFloat = Float.MAX_VALUE;
  float maxFloat = Float.MIN_VALUE;
  if (tickerDatas.size()!=0) {
    minDate = tickerDatas.get(0).date.getTime();
    maxDate = tickerDatas.get(tickerDatas.size()-1).date.getTime();
    //Map the maximum and minimum values to the Y range to ensure image integrity
    for (int i =0; i<tickerDatas.size(); i++) {
      if (tickerDatas.get(i).open_price >maxFloat) {
        maxFloat = tickerDatas.get(i).open_price;
      }
      if (tickerDatas.get(i).close_price >maxFloat) {
        maxFloat = tickerDatas.get(i).close_price;
      }
      if (tickerDatas.get(i).adjusted_close >maxFloat) {
        maxFloat = tickerDatas.get(i).adjusted_close;
      }
      if (tickerDatas.get(i).low >maxFloat) {
        maxFloat = tickerDatas.get(i).low;
      }
      if (tickerDatas.get(i).high >maxFloat) {
        maxFloat = tickerDatas.get(i).high;
      }
      if (tickerDatas.get(i).open_price < minFloat) {
        minFloat = tickerDatas.get(i).open_price;
      }
      if (tickerDatas.get(i).close_price < minFloat) {
        minFloat = tickerDatas.get(i).close_price;
      }
      if (tickerDatas.get(i).adjusted_close < minFloat) {
        minFloat = tickerDatas.get(i).adjusted_close;
      }
      if (tickerDatas.get(i).low < minFloat) {
        minFloat = tickerDatas.get(i).low;
      }
      if (tickerDatas.get(i).high < minFloat) {
        minFloat = tickerDatas.get(i).high;
      }
    }

    textSize(60);
    text(tickerName, width/3, 50);
    //Guidance for the colour of the lines
    textSize(12);
    text("open_price", 50, 20);
    stroke(0, 255, 0);
    line(150, 15, 190, 15);

    text("close_price", 50, 35);
    stroke(255, 255, 0);
    line(150, 20+10, 190, 30);

    text("adjusted_close", 50, 50);
    stroke(255, 0, 0);
    line(150, 50, 190, 50);

    text("low_price", 50, 65);
    stroke(0, 0, 255);
    line(150, 65, 190, 65);

    text("high_price", 50, 20+60);
    stroke(0, 255, 255);
    line(150, 80, 190, 80);
    //sketch the axis
    stroke(0);
    strokeWeight(2);
    line(0, 0, 0, height-90);
    line(0, height-90, width, height-90);
    strokeWeight(1);

    for (int i =0; i<tickerDatas.size(); i++) {
      float xPos = map(tickerDatas.get(i).date.getTime(), minDate, maxDate, 50*2, width*2/3-50);
      float openPos = map(tickerDatas.get(i).open_price, maxFloat, minFloat, 20*5, height*9/10-20);
      float closePos = map(tickerDatas.get(i).close_price, maxFloat, minFloat, 20*5, height*9/10-20);
      float adjustedPos = map(tickerDatas.get(i).adjusted_close, maxFloat, minFloat, 20*5, height*9/10-20);
      float lowPos = map(tickerDatas.get(i).low, maxFloat, minFloat, 20*5, height*9/10-20);
      float highPos = map(tickerDatas.get(i).high, maxFloat, minFloat, 20*5, height*9/10-20);

      if (i==0||i==tickerDatas.size()-1) {
        text(tickerDatas.get(i).dateStr, xPos, height*9/10);
      }
      //draw all lines and plot all points in diff conditions
      if (open) {
        fill(0, 255, 0);  
        rect(xPos, openPos, 5, height*9/10-20-openPos);
        //text(tickerDatas.get(i).open_price, xPos, openPos);
      }
      if (close) {
        fill(255, 255, 0);
        rect(xPos+5, closePos, 5, height*9/10-20-closePos);
        //text(tickerDatas.get(i).close_price, xPos, closePos);
      }

      if (adjusted) {
        fill(255, 0, 0);
        rect(xPos+10, adjustedPos, 5, height*9/10-20-adjustedPos);
        //text(tickerDatas.get(i).adjusted_close, xPos, adjustedPos);
      }

      if (low) {
        fill(0, 0, 255);
        rect(xPos+15, lowPos, 5, height*9/10-20-lowPos );
        //text(tickerDatas.get(i).low, xPos, lowPos);
      }

      if (high) {
        fill(0, 255, 255);
        rect(xPos+20, highPos, 5, height*9/10-20-highPos);
        //text(tickerDatas.get(i).high, xPos, highPos);
      }
    }
  }
}
