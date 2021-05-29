class NumberBondStatistics {
  int total = 0;
  int correct = 0;
  int wrong = 0;

  String toString() {
    return "$total,$correct,$wrong";
  }

  NumberBondStatistics fromString(String string) {
    List<String> values = string.split(',');
    total = int.parse(values[0]);
    correct = int.parse(values[1]);
    wrong = int.parse(values[2]);
    return this;
  }
}
