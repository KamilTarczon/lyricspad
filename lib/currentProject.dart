import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController textEditingController = TextEditingController();
TextEditingController titleEditingController = TextEditingController();

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

    if ((prefs.getKeys().contains(name))) {
      await prefs.setString("$howMuch", textEditingController.text);
    } else {
      await prefs.setString(name, textEditingController.text);
    }
  }

  readFromFile(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString(name);
    if (action != null) {
      textEditingController.text = action;
    }
  }

  numberOfSylabs() {
    textEditingController.text.replaceAll('\n', "10");
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
          TextFormField(
            controller: textEditingController,
            maxLines: 9999,
            decoration: const InputDecoration(label: Text("tekst tu:")),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: saveToFile,
        splashColor: Colors.yellow,
        child: const Icon(Icons.save),
      ),
    );
  }
}
