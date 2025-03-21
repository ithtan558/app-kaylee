extension KayleeDateTimeExtension on DateTime {
  DateTime combineWithTime({DateTime? time}) {
    if (time == null) return this;
    return DateTime(year, month, day, time.hour, time.minute);
  }

  DateTime toDate12AM() => DateTime(year, month, day);

  DateTime toDate12PM() => DateTime(year, month, day, 23, 59, 59);

  DateTime findLastDateOfMonthOfCurrent({int max = 31}) {
    final currentDate = this;
    final maxDate = DateTime(currentDate.year, currentDate.month, max);
    if (maxDate.month > currentDate.month) {
      return findLastDateOfMonthOfCurrent(max: max - 1);
    }
    return maxDate;
  }

  DateTime findFirstDayOfMonthOfCurrent() {
    return subtract(Duration(days: day - 1));
  }

  DateTime findLastDateOfLastMonthFromCurrent() {
    return subtract(Duration(days: day));
  }

  DateTime findFirstDayOfLastMonthFromCurrent({max}) {
    final lastDate = findLastDateOfLastMonthFromCurrent();
    return lastDate.subtract(Duration(days: lastDate.day - 1));
  }
}
