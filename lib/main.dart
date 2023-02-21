import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jobsy_flutter/Blocs/Authentication/authentication_bloc.dart';
import 'package:jobsy_flutter/Repositories/Repo.dart';
import 'package:jobsy_flutter/Ui/Authentication/SplashPage.dart';
import 'package:jobsy_flutter/Ui/Authentication/auth.dart';
import 'package:jobsy_flutter/Ui/Home/HomePage.dart';
import 'package:jobsy_flutter/Ui/Utilities/SharedPreferenceManager.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late AuthenticationBloc? authenticationBloc;

  @override
  void initState() {
   
    authenticationBloc = AuthenticationBloc(
        homeRepo: HomeRepo(),
        sharedPreferencesManager: SharedPreferencesManager())
      ..add(AppStarted());
       super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authenticationBloc!,
      child: MaterialApp(
        scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.stylus,
          PointerDeviceKind.touch,
          PointerDeviceKind.trackpad,
          PointerDeviceKind.unknown,
        }),
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationUnitialized) {
              return const SplashPage();
            } else if (state is AuthenticationAuthenticated) {
              return const HomePage();
            } else if (state is AuthenticationUnauthenticated) {
              return const SplashPage();
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
