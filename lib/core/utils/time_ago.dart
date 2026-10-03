/// "just now", "5 min ago", "3 h ago", "2 d ago".
String formatTimeAgo(DateTime from, {DateTime? now}) {
  final elapsed = (now ?? DateTime.now()).difference(from);
  if (elapsed.inSeconds < 60) return 'just now';
  if (elapsed.inMinutes < 60) return '${elapsed.inMinutes} min ago';
  if (elapsed.inHours < 24) return '${elapsed.inHours} h ago';
  return '${elapsed.inDays} d ago';
}
