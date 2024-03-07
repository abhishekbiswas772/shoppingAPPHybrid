import 'package:bloc_example/Auth/AuthLogic/bloc/authentication_bloc.dart';
import 'package:bloc_example/Auth/AuthPresent/auth_screen_signup.dart';
import 'package:bloc_example/Routes/app_routes.dart';
import 'package:bloc_example/Shopping/Details/bloc/details_logic_bloc.dart';
import 'package:bloc_example/Shopping/Details/DetailsPresent/product_details.dart';
import 'package:bloc_example/Shopping/Home/HomeLogic/bloc/home_logic_bloc.dart';
import 'package:bloc_example/Shopping/Home/HomePresent/home_screen.dart';
import 'package:bloc_example/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  ChatApp({super.key});
  final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(),
          ),
          BlocProvider<HomeLogicBloc>(create: (_) => HomeLogicBloc()),
          BlocProvider<DetailsLogicBloc>(create: (_) => DetailsLogicBloc())
        ],
        child: MaterialApp(
          title: "Doctor Appointment App",
          debugShowCheckedModeBanner: false,
          home: const AuthFlow(),
          onGenerateRoute: appRouter.onGenerateRoute,
        ));
  }
}

class AuthFlow extends StatelessWidget {
  const AuthFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // For testing
              return const ShoppingHome();
            } else {
              return const AuthScreenSignup();
            }
          }),
    );
  }
}
