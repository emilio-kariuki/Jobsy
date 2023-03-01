import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jobsy_flutter/Blocs/Authentication/authentication_bloc.dart';
import 'package:jobsy_flutter/Blocs/Search%20Job/search_job_bloc.dart';
import 'package:jobsy_flutter/Blocs/ShowDetails/show_details_bloc.dart';
import 'package:jobsy_flutter/Ui/Authentication/SplashPage.dart';
import 'package:jobsy_flutter/Ui/Home/HomePage.dart';
import 'package:jobsy_flutter/Ui/Utilities/SharedPreferenceManager.dart';
import 'package:jobsy_flutter/firebase_options.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
    authenticationBloc =
        AuthenticationBloc(sharedPreferencesManager: SharedPreferencesManager())
          ..add(AppStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => authenticationBloc!,
        ),
        BlocProvider(
          create: (context) => SearchJobBloc(),
        ),
         BlocProvider(
          create: (context) => ShowDetailsBloc(),
        ),
      ],
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
