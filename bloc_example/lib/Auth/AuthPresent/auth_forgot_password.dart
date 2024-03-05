import 'package:bloc_example/Auth/AuthLogic/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthForgotScrren extends StatefulWidget {
  const AuthForgotScrren({super.key});

  @override
  State<AuthForgotScrren> createState() => _AuthForgotScrrenState();
}

class _AuthForgotScrrenState extends State<AuthForgotScrren> {
  final TextEditingController _mailController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _authForgotScreenKey =
      GlobalKey<ScaffoldMessengerState>();
  String? otpSecuredText;

  void clearTextFields() {
    _mailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _authForgotScreenKey,
      backgroundColor: const Color(0xFFEA3A60),
      appBar: AppBar(
        elevation: 0,
        // automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFEA3A60),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40, top: 15),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: Image.asset("assets/auth1.png", height: 250)),
                const SizedBox(height: 15),
                Transform.translate(
                  offset: const Offset(0, -20),
                  child: const Text(
                      "Enter the Registered mail id for getting reset password link",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ),
                const SizedBox(height: 10),
                Transform.translate(
                  offset: const Offset(0, -15),
                  child: TextField(
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
                    controller: _mailController,
                  ),
                ),
                const SizedBox(height: 5),
                Transform.translate(
                  offset: const Offset(0, -12),
                  child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                    if (state is AuthenticationInitial) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.blue[400],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0))),
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                            onPressed: () {},
                            child: const Text("Send Password Reset Link",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500))),
                      );
                    } else if (state is AuthenticationEmailLoading &&
                        state.isLoading == true) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return TextButton(
                          onPressed: () {
                            BlocProvider.of<AuthenticationBloc>(context)
                                .add(AuthEmailReset(_mailController.text.trim()));
                          },
                          child: const Text("Send Password Reset Link"));
                    }
                  }, listener: (context, state) {
                    if (state is AuthenticationEmailSuccessEvent) {
                      _authForgotScreenKey.currentState
                          ?.showSnackBar(const SnackBar(
                        content: Text("Link Send Successfully"),
                        duration: Duration(milliseconds: 200),
                      ));
                      clearTextFields();
                      Navigator.of(context).pop();
                    } else if (state is AuthenticationEmailFailureEvent) {
                      _authForgotScreenKey.currentState
                          ?.showSnackBar(const SnackBar(
                        content: Text("Link Send Failed"),
                        duration: Duration(milliseconds: 200),
                      ));
                      Navigator.of(context).pop();
                    }
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mailController.dispose();
    super.dispose();
  }
}
