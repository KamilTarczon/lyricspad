import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController textEditingController = TextEditingController();
TextEditingController titleEditingController = TextEditingController();
TextEditingController _sylabsEditingController = TextEditingController();

class CurentProject extends StatefulWidget {
  const CurentProject({super.key});

  @override
  State<CurentProject> createState() => _CurrentProject();
}

class _CurrentProject extends State<CurentProject> {
  saveToFile() async {
    String name = titleEditingController.text;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int howMuch = prefs.getKeys().length;
    howMuch++;

    if ((prefs.getKeys().contains(name)) && name.isNotEmpty) {
      await prefs.setString(name, textEditingController.text);
    } else {
      await prefs.setString("$howMuch", textEditingController.text);
    }
  }

  readFromFile(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString(name);
    if (action != null) {
      textEditingController.text = action;
    }
  }

  numberOfSylabs() async {
    int numberOfSylabs = 0;
    String check = "!";

    const List<String> vowels = ['a', 'e', 'i', 'o', 'u', 'ó', 'y', 'ą', 'ę'];

    List<String> listSylabs = [];
    for (String senctence in textEditingController.text.split('\n')) {
      numberOfSylabs = 0;

      if (senctence.isEmpty) {
        listSylabs.add("\n");
      } else {
        for (String word in senctence.split(' ')) {
          if (word.isNotEmpty) {
            if (word.length >= 3) {
              word.runes.forEach((int rune) {
                String letter = String.fromCharCode(rune);
                if (vowels.contains(letter) && !vowels.contains(check)) {
                  numberOfSylabs++;
                }
                check = letter;
              });
            } else {
              numberOfSylabs++;
            }
          }
        }
        listSylabs.add("$numberOfSylabs \n");
      }
    }
    String toSet = '';
    for (String word in listSylabs) {
      toSet = toSet + word;
    }
    _sylabsEditingController.text = toSet;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TextFormField(
            controller: titleEditingController,
            maxLines: 1,
            maxLength: 40,
            decoration: const InputDecoration(
                hintText: "Tytuł:", icon: Icon(Icons.title)),
          ),
          Container(
              margin: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        child: TextFormField(
                      controller: _sylabsEditingController,
                      maxLines: 9999,
                    )),
                  ),
                  Expanded(
                      flex: 15,
                      child: Container(
                        child: TextFormField(
                          controller: textEditingController,
                          maxLines: 9999,
                        ),
                      ))
                ],
              ))
        ],
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: saveToFile,
          splashColor: Colors.yellow,
          child: const Icon(Icons.save),
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          onPressed: numberOfSylabs,
          splashColor: Colors.yellow,
          child: const Icon(Icons.music_note),
        )
      ]),
    );
  }
}
