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
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              child: const Icon(Icons.remove),
              onPressed: () => context.read<CounterBloc>().decrement(),
            ),
            SizedBox(
              width: 50,
            ),
            MultiBlocListener(
              listeners: [
                BlocListener<CounterBloc, int>(
                  listener: (context, state) {
                    // Todo: implement listener
                    if (state > 10) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(milliseconds: 400),
                        content: Text('number ofer than 10'),
                      ));
                    }
                    if (state % 5 == 0) {
                      context.read<ThemeBloc>().changeTheme();
                    }
                  },
                ),
              ],
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
            SizedBox(
              width: 50,
            ),
            FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => context.read<CounterBloc>().increment(),
            ),
          ],
        )
      ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.colorize),
        onPressed: () => context.read<ThemeBloc>().changeTheme(),
      ),
    );
  }
}


// BlocConsumer<CounterBloc, int>(
//                 buildWhen: (previous, current) =>
//                     current % 2 == 0 ? true : false,
//                 builder: (context, state) => Text(
//                       "$state",
//                       style: TextStyle(
//                         fontSize: 40.0,
//                       ),
//                     ),
//                 listenWhen: (previous, current) =>
//                     current % 2 == 0 ? true : false,
//                 listener: (context, state) =>
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       duration: Duration(milliseconds: 400),
//                       content: Text('number habis dibagi 2'),
//                     ))),