import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

class BottomBar extends StatefulWidget {
  final Function(int)? changePage;
  const BottomBar({super.key, this.changePage});
  @override
  _BottomBar createState() => _BottomBar();
}

class _BottomBar extends State<BottomBar> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BubbleBottomBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index!;
            widget.changePage!(currentIndex);
          });
        },
        opacity: 0,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        fabLocation: null, //new
        hasNotch: true, //new
        hasInk: true, //new, gives a cute ink effect
        inkColor: Colors.black12, //optional, uses theme color if not specified
        items: const <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              title: Text("Home")),
          BubbleBottomBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.search_sharp,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.search_sharp,
                color: Colors.grey,
              ),
              title: Text("Search")),
          BubbleBottomBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.category,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.category,
                color: Colors.grey,
              ),
              title: Text('Categories')),
          BubbleBottomBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.bookmark_border,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.bookmark_border,
                color: Colors.grey,
              ),
              title: Text("BookMark"))
        ]);
  }
}
