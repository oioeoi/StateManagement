import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themeDataAndBloc/bloc/counter_bloc.dart';
import 'package:themeDataAndBloc/bloc/theme_bloc.dart';

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
            child: BlocBuilder<CounterBloc, int>(
              builder: (context, state) {
                return Text(
                  "$state",
                  style: TextStyle(
                    fontSize: 40.0,
                  ),
                );
              },
            ),
          ),
          Container(
            child: Column(
              children: [
                FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () => context.read()<CounterBloc>().increment(),
                ),
                FloatingActionButton(
                  child: const Icon(Icons.remove),
                  onPressed: () => context.read()<CounterBloc>().decrement(),
                ),
                FloatingActionButton(
                  child: const Icon(Icons.colorize),
                  onPressed: () => context.read()<ThemeBloc>().changeTheme(),
                ),
              ],
            ),
          )
        ]));
  }
}
