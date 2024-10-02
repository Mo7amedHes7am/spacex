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