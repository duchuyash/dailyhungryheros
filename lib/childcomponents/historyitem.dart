import 'package:flutter/cupertino.dart';

class HistoryItem {
  final int rank;
  final String avatar;
  final String name;
  final int timeago;

  HistoryItem({
    required this.rank,
    required this.avatar,
    required this.name,
    required this.timeago,
  });

  static List<HistoryItem> lsItems = [
    HistoryItem(
      rank: 3,
      avatar: 'assets/img/sakura.png',
      name: 'sakura',
      timeago: 6,
    ),
    HistoryItem(
      rank: 4,
      avatar: 'assets/img/kakashi.png',
      name: 'kakashi',
      timeago: 10,
    ),
    HistoryItem(
      rank: 5,
      avatar: 'assets/img/sasuke.png',
      name: 'sasuke',
      timeago: 13,
    ),
  ];
}
