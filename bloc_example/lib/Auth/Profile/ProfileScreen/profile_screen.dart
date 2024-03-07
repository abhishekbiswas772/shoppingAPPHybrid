import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEA3A60),
      body: SafeArea(
        child: Column(
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
                        fontWeight: FontWeight.w700,
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
                    border: Border.all(width: 1, color: Colors.black),
                    shape: BoxShape.circle),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Text("Abhishek",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                      height: 40,
                      width: 150,
                      child: TextButton(
                          onPressed: () {},
                          child: const Text("Sign out",
                              style: TextStyle(color: Colors.white))),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blue[400],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
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
        ),
      ),
    );
  }
}
