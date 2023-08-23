import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:themeDataAndBloc/bloc/counter_bloc.dart';
import 'package:themeDataAndBloc/bloc/theme_bloc.dart';
import 'package:themeDataAndBloc/pages/home_httpprovider.dart';
import 'package:themeDataAndBloc/pages/home_httpstateful.dart';
import 'package:themeDataAndBloc/provider/http_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData dark = ThemeData.dark();
  final ThemeData light = ThemeData.light();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
        BlocProvider<CounterBloc>(create: (context) => CounterBloc()),
      ],
      child: BlocBuilder<ThemeBloc, bool>(
          builder: (context, state) => MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: state ? dark : light,
                home: HttpPageStateful(),
                // home: ChangeNotifierProvider(
                //   create: (context) => HttpProvider(),
                //   child: HttpPageProvider(),
                // ),
              )),
    );
  }
}
