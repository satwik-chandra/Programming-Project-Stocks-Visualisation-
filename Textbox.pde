//CLASS BUILT BY MICHAEL
public class Textbox {
  public int X = 0, Y = 0, H = 35, W = 200;
  public int TEXTSIZE = 24;
  // Colors
  public color Background = color(255, 255, 255);
  public color Foreground = color(0, 0, 0);
  public color BackgroundSelected = color(125, 125, 125);
  public color Border = color(0, 0, 0);
  //border widths
  public boolean BorderEnable = true;
  public int BorderWeight = 1;
  //text variables
  public String Text = "";
  public int TextLength = 0;
  private boolean selected = false;

  Textbox(int x, int y, int w, int h) {
    X = x; 
    Y = y; 
    W = w; 
    H = h;
  }

  void draw() {
    // Drawing the background
    if (selected) {
      fill(BackgroundSelected);
    } else {
      fill(Background);
    }

    if (BorderEnable) {
      strokeWeight(BorderWeight);
      stroke(Border);
    } else {
      noStroke();
    }

    rect(X, Y, W, H);

    // Drawing the text itself
    fill(Foreground);
    textSize(TEXTSIZE);
    text(Text, X + (textWidth("a") / 2), Y + TEXTSIZE);
  }

  // If key code is enter return 1 else return 0
  boolean KEYPRESSED(char KEY, int KEYCODE) {
    if (selected) {
      if (KEYCODE == (int)BACKSPACE) {
        BACKSPACE();
      } else if (KEYCODE == 32) {
        // SPACE
        addText(' ');
      } else if (KEYCODE == (int)ENTER) {
        return true;
      } else {
        // check if key is a letter or number
        boolean isKeyCapitalLetter = (KEY >= 'A' && KEY <= 'Z');
        boolean isKeySmallLetter = (KEY >= 'a' && KEY <= 'z');
        boolean isKeyNumber = (KEY >= '0' && KEY <= '9');
        boolean isSlash = (KEY=='-');
        if (isKeyCapitalLetter || isKeySmallLetter || isKeyNumber||isSlash) {
          addText(KEY);
        }
      }
    }

    return false;
  }

  private void addText(char text) {
    // Keep the text width in the boundaries of the textbox
    if (textWidth(Text + text) < W) {
      Text += text;
      TextLength++;
    }
  }
  // Backspace function for deleting what was written if backspace key was pressed
  private void BACKSPACE() {
    if (TextLength - 1 >= 0) {
      Text = Text.substring(0, TextLength - 1);
      TextLength--;
    }
  }

  // Function for testing is the point over the textbox
  private boolean overBox(int x, int y) {
    if (x >= X && x <= X + W) {
      if (y >= Y && y <= Y + H) {
        return true;
      }
    }

    return false;
  }
  // Function for testing if the textbox was clicked
  void PRESSED(int x, int y) {
    if (overBox(x, y)) {
      selected = true;
    } else {
      selected = false;
    }
  }
}
