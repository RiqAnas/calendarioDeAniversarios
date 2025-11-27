class Calc {
  static int ageCalc(DateTime date) {
    final today = DateTime(date.year, DateTime.now().month, DateTime.now().day);

    if (date.isBefore(today) || birthday(date)) {
      return DateTime.now().year - date.year;
    } else {
      return (DateTime.now().year - date.year) - 1;
    }
  }

  static bool birthday(DateTime date) {
    if (DateTime.now().day == date.day && DateTime.now().month == date.month) {
      return true;
    } else {
      return false;
    }
  }
}
