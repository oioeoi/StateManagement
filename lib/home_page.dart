import 'package:flutter/material.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
          Center(
            child: Text(
              "text",
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {},
                ),
                FloatingActionButton(
                  child: const Icon(Icons.remove),
                  onPressed: () {},
                ),
                FloatingActionButton(
                  child: const Icon(Icons.colorize),
                  onPressed: () {},
                ),
              ],
            ),
          )
        ]));
  }
}
