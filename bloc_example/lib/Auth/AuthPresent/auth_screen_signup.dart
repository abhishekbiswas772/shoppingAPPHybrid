import 'package:bloc_example/Auth/AuthLogic/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthScreenSignup extends StatefulWidget {
  const AuthScreenSignup({super.key});

  @override
  State<AuthScreenSignup> createState() => _AuthScreenSignupState();
}

class _AuthScreenSignupState extends State<AuthScreenSignup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void clearTextFields() {
    _emailController.clear();
    _passwordController.clear();
  }

  _launchURL() async {
    const url = 'https://flutter.dev';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget mainBodyPartBeforeAPICall() {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(left: 45, right: 45, top: 10),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: Image.asset("assets/auth1.png", height: 250)),
              const SizedBox(height: 25),
              const Text("Sign In or Sign up",
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 3),
              const Text("select desire log in method",
                  style: TextStyle(fontSize: 14, color: Colors.white)),
              const SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    hintText: 'Mail',
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    )),
                controller: _emailController,
              ),
              const SizedBox(height: 10),
              TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black),
                    prefixIcon: const Icon(
                      Icons.key,
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    )),
                controller: _passwordController,
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: TextButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                          AuthCreateUser(
                              _emailController.text, _passwordController.text));
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    )),
              ),
              const SizedBox(height: 5),
              const Text("Not Have Account, Make One By Clicking Here",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 5),
              Transform.translate(
                offset: const Offset(0, -20),
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/signin");
                    },
                    child: Text("sign in",
                        style: TextStyle(
                            color: Colors.blue[400],
                            fontWeight: FontWeight.w500,
                            fontSize: 15))),
              ),
              const SizedBox(height: 5),
              Transform.translate(
                offset: const Offset(0, -27),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("By registering or skipping this your agree to",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                    Transform.translate(
                      offset: const Offset(0, -14),
                      child: TextButton(
                          onPressed: () {
                            _launchURL();
                          },
                          child: Text("Terms of Services",
                              style: TextStyle(
                                  color: Colors.blue[400], fontSize: 12))),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFEA3A60),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFEA3A60),
        ),
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
          if (state is AuthenticationSuccessState) {
            clearTextFields();
            Navigator.of(context).pushNamed("/home");
          } else if (state is AuthenticationFailureState) {}
        }, builder: (context, state) {
          if (state is AuthenticationInitial ||
              (state is AuthenticationLoadingState &&
                  state.isLoading == false)) {
            return mainBodyPartBeforeAPICall();
          } else if (state is AuthenticationLoadingState &&
              state.isLoading == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return mainBodyPartBeforeAPICall();
          }
        }));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
