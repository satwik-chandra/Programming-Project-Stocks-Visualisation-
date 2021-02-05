// Store the information of a data node each data node represents a record in the CSV file.
// Coded by Haoyu and Satwik
class DataPoint implements Comparable<DataPoint> {
  String ticker;
  float open_price;
  float close_price;
  float adjusted_close;
  float low;
  float high;
  int volume;
  Date date;
  String dateStr;
  public boolean isValid; //boolean condition of the date
  // Each data node represents a record in the CSV file
  DataPoint(String[] str) {
    this.dateStr = str[7];
    this.isValid = false;
    this.ticker = str[0];
    this.open_price = Float.valueOf(str[1]);
    this.close_price = Float.valueOf(str[2]);
    this.adjusted_close = Float.valueOf(str[3]);
    this.low = Float.valueOf(str[4]);
    this.high = Float.valueOf(str[5]);
    this.volume = Integer.valueOf(str[6]);
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    try {
      this.date = sdf.parse(str[7]);
    } 
    catch (ParseException e) {
      e.printStackTrace();
    }
  }
  // filter datapoints that are in a certain time interval
  public void filterDate(String startTime, String endTime) throws Exception {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    Date startDate, endDate;
    if ( startTime.equals("") && !endTime.equals("") ) {
      endDate = sdf.parse(endTime);
      if ( date.compareTo(endDate) <= 0 ) {
        this.isValid = true;
      }
    } else if ( !startTime.equals("") && endTime.equals("") ) {
      startDate = sdf.parse(startTime);
      if ( date.compareTo(startDate) >= 0 ) {
        this.isValid = true;
      }
    } else if ( !startTime.equals("") && !endTime.equals("") ) {
      startDate = sdf.parse(startTime);
      endDate = sdf.parse(endTime);
      if ( date.compareTo(startDate) >= 0 && date.compareTo(endDate) <= 0 ) {
        this.isValid = true;
      }
    } else {
      this.isValid = true;
    }
  }
  // compare two nodes
  public int compareTo(DataPoint o) {
    return date.compareTo(o.date);
  }
}
