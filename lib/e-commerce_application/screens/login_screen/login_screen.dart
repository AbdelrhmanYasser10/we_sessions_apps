import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:we_session1/e-commerce_application/screens/main_layout/main_layout.dart';
import 'package:we_session1/e-commerce_application/screens/registration_screen/register_screen.dart';
import 'package:we_session1/e-commerce_application/shared/cubit/auth_cubit/auth_cubit.dart';
import 'package:we_session1/e-commerce_application/shared/network/local/cache_helper/cache_helper.dart';

import '../../shared/widgets/my_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                height: MediaQuery.of(context).size.height / 6,
              ),
              Text(
                "LOGIN",
                style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "Login to buy our special products",
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
                prefixIcon: const Icon(
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
                prefixIcon: const Icon(
                  Icons.lock_outline,
                ),
                isPassword: true,
              ),
              const SizedBox(
                height: 50.0,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) async{
                  if(state is LoginWithError){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                          content: Text(
                            state.message,
                          ),
                      ),
                    );
                  }
                  if(state is LoginSuccessfully){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          state.model.message!,
                        ),
                      ),
                    );
                    await CacheHelper.storeInCache("token", state.model.data!.token!);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>MainLayout()));
                  }
                },
                builder: (context, state) {
                  var cubit = AuthCubit.get(context);
                  if(state is LoginLoading){
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
                      cubit.login(
                          email: _emailController.text,
                          password: _passwordController.text,
                      );
                    },
                    child: const Text(
                      "Login",
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
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Register",
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
