import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:we_session1/e-commerce_application/screens/login_screen/login_screen.dart';
import 'package:we_session1/e-commerce_application/shared/cubit/auth_cubit/auth_cubit.dart';

import '../../shared/network/local/cache_helper/cache_helper.dart';
import '../../shared/widgets/my_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Text(
                "REGISTER",
                style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "Join us to buy our special products",
                style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              MyTextFormField(
                controller: _emailController,
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
                controller: _passwordController,
                title: "Password",
                labelText: "Password",
                prefixIcon: Icon(
                  Icons.lock_outline,
                ),
                isPassword: true,
              ),
              SizedBox(
                height: 20.0,
              ),
              MyTextFormField(
                controller: _usernameController,
                title: "Username",
                labelText: "Username",
                prefixIcon: Icon(
                  Icons.person_2_outlined,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              MyTextFormField(
                controller: _phoneNumberController,
                title: "Phone number",
                labelText: "Phone number",
                prefixIcon: Icon(
                  Icons.phone_outlined,
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) async{
                  if(state is RegisterWithError){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          state.message,
                        ),
                      ),
                    );
                  }
                  if(state is RegisterSuccessfully){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          state.model.message!,
                        ),
                      ),
                    );
                    await CacheHelper.storeInCache("token", state.model.data!.token!);
                  }
                },
                builder: (context, state) {
                  var cubit = AuthCubit.get(context);
                  if (state is RegisterLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      minimumSize: const Size(
                        double.infinity,
                        55.0,
                      ),
                    ),
                    onPressed: () {
                      cubit.register(
                        email: _emailController.text,
                          password: _passwordController.text,
                          username: _usernameController.text,
                          phoneNumber: _phoneNumberController.text,
                      );
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Login",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
