import 'package:flutter/material.dart';
import 'package:lyricspad/items.dart';
import 'currentProject.dart';

void main() {
  runApp(const MyApp());
}

PageController pageController = PageController();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LyricsPad',
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lyrics Pad"),
        actions: const [BackButton()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.draw), label: "Obecny Projekt"),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_rounded), label: "Wszystkie Projekty"),
        ],
        currentIndex: _selectedIndex,
        onTap: onTapped,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (page) {
          setState(() {
            _selectedIndex = page;
          });
        },
        children: const [
          CurentProject(),
          itemsScreen(),
        ],
      ),
    );
  }
}
