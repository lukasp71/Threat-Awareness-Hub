import "package:flutter/material.dart";
import "package:senior_project/screens/authenticate/register.dart";
import "package:senior_project/screens/authenticate/sign_in.dart";

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _Authenticate();
}

class _Authenticate extends State<Authenticate> {
  bool showSignIn = true;
  toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn();
    } else {
      return Register();
    }
  }
}
