String lastSeenMessage(lastSeen) {
  DateTime now = DateTime.now();
  Duration differenceDuration = now.difference(
    DateTime.fromMillisecondsSinceEpoch(lastSeen),
  );

  String finalMessage = differenceDuration.inSeconds > 59
      ? differenceDuration.inMinutes > 59
      ? differenceDuration.inHours > 23
      ? differenceDuration.inDays > 30
      ? differenceDuration.inDays > 365
      ? "${differenceDuration.inDays~/365} ${differenceDuration.inDays~/365 == 1 ? 'year' : 'years'}"
      : "${differenceDuration.inDays~/30} ${differenceDuration.inDays~/30 == 1 ? 'month' : 'months'}"
      : "${differenceDuration.inDays} ${differenceDuration.inDays == 1 ? 'day' : 'days'}"
      : "${differenceDuration.inHours} ${differenceDuration.inHours == 1 ? 'hour' : 'hours'}"
      : "${differenceDuration.inMinutes} ${differenceDuration.inMinutes == 1 ? 'minute' : 'minutes'}"
      : 'few moments';

  return finalMessage;
}

String printDuration(int time1, int time2) {
  DateTime now = DateTime.now();
  Duration duration = DateTime.fromMillisecondsSinceEpoch(time2).difference(
    DateTime.fromMillisecondsSinceEpoch(time1),
  );
  String negativeSign = duration.isNegative ? '-' : '';
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
  return "$twoDigitMinutes:$twoDigitSeconds";
}
