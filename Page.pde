class Page // https://www.reddit.com/r/processing/comments/7n6jxq/want_to_experiment_with_a_visualnovellike/
{
  int[] outcomes = new int[5];
  String[] choices = new String[5];
  String content;
  PImage backdrop;
  Gif Char;
  //////etc
  
  Page(int[] pages, String[] options, String text, PImage back, Gif character)
  {
    this.outcomes = pages;
    this.choices = options;
    this.content = text;
    this.backdrop = back;
    this.Char = character;
  }

  int goToPage(int userInput)
  {
    return outcomes[userInput];
  }
  
  void displayPage()
  {
    println("I'm working");
    image(backdrop,0,0, 1920, 1080);
    fill(255);
    rect(300, 1500, 1500, 400);
    for (int i = 0; i < choices.length; i++){
      text(choices[i], 800, 1400 + (100*i));
    }
    text("help", 500, 1600);
    image(Char, 300, 1600, 245, 270);
  }
}
