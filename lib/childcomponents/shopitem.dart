import 'package:flutter/cupertino.dart';

class ShopItem {
  final String image;
  final int price;
  final String title;
  final String description;
  final TextEditingController quantity;

  ShopItem(
      {required this.title,
      required this.image,
      required this.price,
      required this.description,
      required this.quantity});

  static List<ShopItem> lsItems = [
    ShopItem(
      title: 'Ask the Audience',
      image: 'assets/icon/ask.png',
      price: 10,
      description: 'used to calculate the correct answer rate',
      quantity: TextEditingController(text: "1"),
    ),
    ShopItem(
      title: '50:50',
      image: 'assets/icon/50-50.png',
      price: 50,
      description: 'eliminate haft of the wwrong answers',
      quantity: TextEditingController(text: "1"),
    ),
    ShopItem(
      title: 'Overcome',
      image: 'assets/icon/pass.png',
      price: 75,
      description: 'skip and pass the question',
      quantity: TextEditingController(text: "1"),
    ),
    ShopItem(
      title: 'Life',
      image: 'assets/icon/heart-infinity.png',
      price: 100,
      description: 'everlasting in 30 minus',
      quantity: TextEditingController(text: "1"),
    )
  ];
}
