//Timer class was created by Daniel Shiffman and borrowed from the class example for this [1]
//More information can be found here: http://learningprocessing.com/examples/chp10/example-10-05-OOP-Timer

class Timer {

  int savedTime; // When Timer started
  int totalTime; // How long Timer should last

  Timer(int tempTotalTime) {
    totalTime = tempTotalTime;
  }

  // Starting the timer
  void start() {
    // When the timer starts it stores the current time in milliseconds.
    savedTime = millis();
  }
  
  int giveTime(){
    return savedTime;
  }
  // The function isFinished() returns true if 5,000 ms have passed. 
  // The work of the timer is farmed out to this method.
  boolean isFinished() { 
    // Check how much time has passed
    int passedTime = millis()- savedTime;
    if (passedTime > totalTime) {
      return true;
    } else {
      return false;
    }
  }
}

/*
[1] Karen Cochrane. ex8 Timer Class. (2023). Retrieved 2/22/2024 from https://learn.uwaterloo.ca/d2l/le/content/983488/viewContent/5361468/View
*/
