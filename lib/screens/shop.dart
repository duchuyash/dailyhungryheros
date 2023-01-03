import 'package:dailyhungryheros/childcomponents/top-nav-shop.dart';
import 'package:dailyhungryheros/screens/mainscreen.dart';
import 'package:dailyhungryheros/screens/shop_diamonds.dart';
import 'package:dailyhungryheros/screens/shop_help.dart';
import 'package:flutter/material.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  List<Widget> lstScreen = [
    const Shop_Help(),
    const Shop_Diamonds(),
  ];

  var selectedIndex = 0;
  // ignore: non_constant_identifier_names
  void OntabSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Color.fromARGB(255, 234, 124, 124),
            ),
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                selectedIndex == 0
                    ? const TopNavShop(
                        ask: 1,
                        haft: 1,
                        pass: 1,
                      )
                    : Container(),
              ],
            )),
      ),
      body: lstScreen[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: selectedIndex == 0
                      ? const MaterialStatePropertyAll<Color>(
                          Color.fromARGB(255, 234, 124, 124))
                      : MaterialStatePropertyAll<Color>(
                          Color.fromARGB(255, 234, 124, 124).withOpacity(0.3)),
                ),
                onPressed: () => OntabSelected(0),
                icon: Image.asset(
                  'assets/icon/lifesaver.png',
                  width: 32,
                ),
                label: const Text(
                  'Buy helps',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: selectedIndex == 1
                      ? const MaterialStatePropertyAll<Color>(
                          Color.fromARGB(255, 234, 124, 124))
                      : MaterialStatePropertyAll<Color>(
                          Color.fromARGB(255, 234, 124, 124).withOpacity(0.3)),
                ),
                onPressed: () => OntabSelected(1),
                icon: Image.asset(
                  'assets/icon/diamond.png',
                  width: 32,
                ),
                label: const Text(
                  'Buy diamonds',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
