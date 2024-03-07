import 'package:bloc_example/Auth/AuthLogic/bloc/authentication_bloc.dart';
import 'package:bloc_example/Utils/Images/image_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldMessengerState> _profileKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthenticationBloc>(context).add(AuthProfileDetailsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEA3A60),
      body: SafeArea(
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationSuccessState) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/signup", (route) => false);
            } else {
              _profileKey.currentState?.showSnackBar(const SnackBar(
                content: Text("Fail to sign out user"),
                duration: Duration(milliseconds: 200),
              ));
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthProfileDetailsEvent());
            }
          },
          builder: (context, state) {
            if (state is AuthenticationInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AuthenticationSuccessState) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(Icons.arrow_back_outlined,
                              color: Colors.black)),
                      const Text("Profile Details",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 25)),
                      const SizedBox(width: 55)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 45.0),
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Colors.black.withOpacity(0.2)),
                          shape: BoxShape.circle),
                      child: ImageServiceUtil.getProfileImageWidgetFromName(
                          state.firebaseUser.email.toString(), 120),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 15),
                    child: Text(state.firebaseUser.displayName.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600)),
                  ),
                  const Spacer(),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.40,
                          left: 20,
                          right: 20),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.blue[400],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))),
                            height: 40,
                            width: 150,
                            child: TextButton(
                                onPressed: () {
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(AuthSignOutUser());
                                },
                                child: const Text("Sign out",
                                    style: TextStyle(color: Colors.white))),
                          ),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.blue[400],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))),
                            height: 40,
                            width: 150,
                            child: TextButton(
                                onPressed: () {},
                                child: const Text("Delete Account",
                                    style: TextStyle(color: Colors.white))),
                          )
                        ],
                      ))
                ],
              );
            } else if (state is AuthenticationFailureState) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_amber_rounded, size: 40),
                    SizedBox(
                      height: 3,
                    ),
                    Text("Some Error Happended,",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_amber_rounded, size: 40),
                    SizedBox(
                      height: 3,
                    ),
                    Text("Some Error Happended,",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
