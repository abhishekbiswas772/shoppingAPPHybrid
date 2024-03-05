import 'package:bloc_example/Auth/AuthLogic/bloc/authentication_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthSignInScreen extends StatefulWidget {
  const AuthSignInScreen({super.key});

  @override
  State<AuthSignInScreen> createState() => _AuthSignInScreenState();
}

class _AuthSignInScreenState extends State<AuthSignInScreen> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void clearTextFields() {
    _mailController.clear();
    _passwordController.clear();
  }

  Widget createAuthSignInBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 15),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: Image.asset("assets/auth2.png", height: 250)),
            const SizedBox(height: 30),
            const Text("Sign In your Account",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            const Text("Enter Your Login Details to\naccess your account",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center),
            const SizedBox(height: 15),
            TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    hintText: 'Email',
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
                controller: _mailController),
            const SizedBox(height: 10),
            TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: _passwordController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black),
                    hintText: 'Password',
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
                    ))),
            const SizedBox(height: 3),
            Transform.translate(
              offset: const Offset(0, -10),
              child: Row(
                children: [
                  const SizedBox(),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/forgot");
                      },
                      child: const Text("Forgot Password ?",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400))),
                ],
              ),
            ),
            const SizedBox(height: 3),
            Transform.translate(
              offset: const Offset(0, -15),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                          AuthSignInUser(
                              _mailController.text, _passwordController.text));
                    },
                    child: const Text("Sign In",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500))),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have account?",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Sign up",
                          style: TextStyle(color: Colors.blue[400])))
                ],
              ),
            )
          ],
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
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFEA3A60),
        leading: null,
      ),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        if (state is AuthenticationInitial ||
            (state is AuthenticationLoadingState && state.isLoading == false)) {
          return createAuthSignInBody();
        } else if (state is AuthenticationLoadingState &&
            state.isLoading == true) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return createAuthSignInBody();
        }
      }, listener: (context, state) {
        if (state is AuthenticationSuccessState) {
          clearTextFields();
          Navigator.of(context).pushNamed("/home");
        } else if (state is AuthenticationFailureState) {}
      }),
    );
  }

  @override
  void dispose() {
    _mailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
