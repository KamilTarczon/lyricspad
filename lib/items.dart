import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import "currentProject.dart";
import "main.dart";

class itemsScreen extends StatefulWidget {
  const itemsScreen({super.key});

  @override
  State<itemsScreen> createState() => _itemsScreen();
}

class _itemsScreen extends State<itemsScreen> {
  int? itemCount;
  List items = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List> toList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getKeys().toList();
  }

  Future<void> readFromFile(String Name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString(Name);
    if (action != null) {
      textEditingController.text = action;
      titleEditingController.text = Name;
      pageController.jumpToPage(0);
    }
  }

  Future<void> deleteFile(String Name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(Name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List>(
            future: toList(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Błąd"),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                final result = snapshot.data;
                if (result != null) {
                  return ListView.builder(
                    itemCount: result.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                result[index],
                                textAlign: TextAlign.center,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        deleteFile(result[index]);
                                      },
                                      icon: Icon(Icons.delete)),
                                  IconButton(
                                      onPressed: () async {
                                        readFromFile(result[index]);
                                      },
                                      icon: Icon(Icons.download))
                                ],
                              )
                            ]),
                      );
                    },
                  );
                }
              }
              return const Center(
                child: Text("japierdole"),
              );
            }));
  }
}
