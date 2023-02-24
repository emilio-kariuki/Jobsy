import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsy_flutter/Blocs/Authentication/authentication_bloc.dart';
import 'package:jobsy_flutter/Blocs/Login/auth_bloc.dart';
import 'package:jobsy_flutter/Firebase/Authentication.dart';
import 'package:jobsy_flutter/Ui/Authentication/Widget/InputField.dart';
import 'package:jobsy_flutter/Ui/Home/HomePage.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';
import 'package:jobsy_flutter/Ui/Utilities/Responsive.dart';
import 'package:jobsy_flutter/Ui/Utilities/SharedPreferenceManager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  var tweenLeft =
      Tween<Offset>(begin: const Offset(2, 0), end: const Offset(0, 0))
          .chain(CurveTween(curve: Curves.ease));
  var tweenRight =
      Tween<Offset>(begin: const Offset(0, 0), end: const Offset(2, 0))
          .chain(CurveTween(curve: Curves.ease));

  AnimationController? _animationController;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late AuthenticationBloc _authenticationBloc;

  bool isChecked = false;
  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
          firebaseAuthentication: FirebaseAuthentication(), authenticationBloc: _authenticationBloc)
        ..add(AuthStarted()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.loose,
          children: [
            Responsive.isDesktop(context) || Responsive.isTablet(context)
                ? Row(
                    children: [
                      //slider widget
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage("lib/Assets/marker.jpg"),
                                fit: BoxFit.cover)),
                      ),

                      //authentication widgets
                      Responsive.isDesktop(context) ||
                              Responsive.isTablet(context)
                          ? Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width / 2,
                              color: bgColor,
                              child: Center(
                                child: Container(
                                  color: bgColor,
                                  padding: const EdgeInsets.all(42),
                                  width:
                                      MediaQuery.of(context).size.width / 3.6,
                                  height:
                                      MediaQuery.of(context).size.height / 1.2,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 60,
                                      ),
                                      Image.asset(
                                        "lib/Assets/jobsy.jpeg",
                                        height: 100,
                                        width: 100,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Flexible(
                                        child: Stack(
                                          children: [
                                            SlideTransition(
                                              position: _animationController!
                                                  .drive(tweenRight),
                                              child: Stack(
                                                  fit: StackFit.loose,
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    _loginScreen(context),
                                                  ]),
                                            ),
                                            SlideTransition(
                                              position: _animationController!
                                                  .drive(tweenLeft),
                                              child: Stack(
                                                  fit: StackFit.loose,
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    _registerScreen(context),
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width,
                              color: bgColor,
                              child: Center(
                                child: Container(
                                  color: bgColor,
                                  padding: Responsive.isDesktop(context) ||
                                          Responsive.isTablet(context)
                                      ? const EdgeInsets.all(42)
                                      : const EdgeInsets.all(10),
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 60,
                                      ),
                                      Image.asset(
                                        "lib/Assets/jobsy.jpeg",
                                        height: 100,
                                        width: 100,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Flexible(
                                        child: Stack(
                                          children: [
                                            SlideTransition(
                                              position: _animationController!
                                                  .drive(tweenRight),
                                              child: Stack(
                                                  fit: StackFit.loose,
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    _loginScreen(context),
                                                  ]),
                                            ),
                                            SlideTransition(
                                              position: _animationController!
                                                  .drive(tweenLeft),
                                              child: Stack(
                                                  fit: StackFit.loose,
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    _registerScreen(context),
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                    ],
                  )
                : Column(
                    children: [
                      //slider widget
                      Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage("lib/Assets/marker.jpg"),
                                fit: BoxFit.cover)),
                      ),

                      //authentication widgets
                      Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        color: bgColor,
                        child: Center(
                          child: Container(
                            color: bgColor,
                            padding: const EdgeInsets.all(42),
                            width: MediaQuery.of(context).size.width / 3.6,
                            height: MediaQuery.of(context).size.height / 1.2,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 60,
                                ),
                                Image.asset(
                                  "lib/Assets/jobsy.jpeg",
                                  height: 100,
                                  width: 100,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Flexible(
                                  child: Stack(
                                    children: [
                                      SlideTransition(
                                        position: _animationController!
                                            .drive(tweenRight),
                                        child: Stack(
                                            fit: StackFit.loose,
                                            clipBehavior: Clip.none,
                                            children: [
                                              _loginScreen(context),
                                            ]),
                                      ),
                                      SlideTransition(
                                        position: _animationController!
                                            .drive(tweenLeft),
                                        child: Stack(
                                            fit: StackFit.loose,
                                            clipBehavior: Clip.none,
                                            children: [
                                              _registerScreen(context),
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  Widget _registerScreen(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is RegisterFailure) {
          _onWidgetDidBuild(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                width: MediaQuery.of(context).size.width * 0.2,
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        if (state is RegisterSuccess) {
          _onWidgetDidBuild(() async {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                width: MediaQuery.of(context).size.width * 0.2,
                content: const Text("Registration Success"),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          });
        }

        
          return Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 0.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InputField(
                    controller: nameController,
                    title: "Name",
                    hintText: "name",
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 5),
                  InputField(
                    controller: emailController,
                    title: "Email",
                    hintText: "email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 5),
                  InputField(
                    controller: passwordController,
                    title: "Password",
                    hintText: "password",
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  state is RegisterLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        )
                      : clickButton(
                          title: "Register",
                          onPressed: () {
                            if (emailController.text.isEmpty ||
                                passwordController.text.isEmpty ||
                                nameController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  content:
                                      const Text("Please fill all the fields"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else {
                              BlocProvider.of<AuthBloc>(context).add(
                                RegisterButtonPressed(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                ),
                              );
                            }
                          },
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Wrap(
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        TextButton(
                          onPressed: () {
                            _animationController!.reverse();
                          },
                          child: Text(
                            "Login",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: primaryColor,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
       
      },
    );
  }

  Widget _loginScreen(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
       
          sharedPreferencesManager: SharedPreferencesManager()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is LoginFailure) {
            _onWidgetDidBuild(() {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  width: MediaQuery.of(context).size.width * 0.2,
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            });
          }

          if (state is LoginSuccess) {
            _onWidgetDidBuild(() {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  width: MediaQuery.of(context).size.width * 0.2,
                  content: const Text("Login Success"),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            });
          }

          return Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 0.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InputField(
                    controller: emailController,
                    title: "Email",
                    hintText: "email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 5),
                  InputField(
                    controller: passwordController,
                    title: "Password",
                    hintText: "password",
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password?",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: primaryColor,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  state is LoginLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        )
                      : clickButton(
                          title: "Login",
                          onPressed: () {
                            if (emailController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              _onWidgetDidBuild(() {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    content: const Text(
                                        "Please fill all the fields"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              });
                            } else {
                              BlocProvider.of<AuthBloc>(context).add(
                                LoginButtonPressed(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                            }
                          },
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Wrap(
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        TextButton(
                          onPressed: () {
                            _animationController!.forward();
                          },
                          child: Text(
                            "Register",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: primaryColor,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }

  Widget clickButton({required String title, required Function() onPressed}) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          // padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
