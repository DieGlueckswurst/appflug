class ApplicationDeadlineService {
  static DateTime deadline = DateTime(2022, 11, 26);

  static int getDaysUntilDeadline() {
    return deadline.difference(DateTime.now()).inDays;
  }
}
