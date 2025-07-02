void main() {
  double dist = 25;
  double speed = 40;
  double Hours = dist / speed;
  double Minutes = Hours * 60;
  print("Time to reach office: ${Minutes.toStringAsFixed(2)} minutes");
}
