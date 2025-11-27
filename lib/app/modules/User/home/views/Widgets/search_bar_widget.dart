import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final List<String> _hints = [
    'Search "Plumber"',
    'Search "Electrician"',
    'Search "Scrap Collector"',
    'Search "Machine Repair"',
  ];

  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _hints.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      height: 55,
      decoration: BoxDecoration(
        color: Get.theme.canvasColor,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Get.theme.hintColor, width: .5),
      ),
      child: Row(
        children: [
          SizedBox(width: 5),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(CupertinoIcons.search, color: Get.theme.hintColor),
          ),
          SizedBox(width: 10),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              final offsetAnimation = Tween<Offset>(
                begin: const Offset(0, 1), // from bottom
                end: Offset.zero,
              ).animate(animation);
              return ClipRect(
                child: SlideTransition(position: offsetAnimation, child: child),
              );
            },
            child: Text(
              _hints[_currentIndex],
              key: ValueKey<int>(_currentIndex),
              style: TextStyle(color: Get.theme.hintColor, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
