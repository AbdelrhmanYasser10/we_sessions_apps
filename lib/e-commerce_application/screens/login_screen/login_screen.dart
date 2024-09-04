import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/widgets/my_text_form_field.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "LOGIN",
              style: GoogleFonts.manrope(
                textStyle:TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              "Login to buy our special products",
              style: GoogleFonts.manrope(
                textStyle:TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            MyTextFormField(
              title: "E-mail",
              labelText: "E-mail",
              prefixIcon: Icon(
                Icons.email_outlined,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            MyTextFormField(
              title: "Password",
              labelText: "Password",
              prefixIcon: Icon(
                Icons.lock_outline,
              ),
              isPassword: true,
            ),
          ],
        ),
      ),
    );
  }
}
