String getCreatedDateStr(DateTime datetime) {
  final now = DateTime.now();
  final difference = now.difference(datetime).inMinutes;

  if (difference < 1) {
    return "방금";
  } else if (difference < 60) {
    return "$difference분전";
  } else if (difference < 1440) {
    final hours = (difference / 60).round();
    return "$hours시간전";
  } else {
    final days = (difference / (24 * 60)).round();
    return "$days일전";
  }
}
