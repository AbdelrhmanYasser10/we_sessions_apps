import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_session1/chat_application/shared/cubits/app_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                BlocConsumer<AppCubit, AppState>(
                  listener: (context, state) {
                    if(state is GetImageSuccessfully){
                      AppCubit.get(context).cropImage();
                    }
                  },
                  builder: (context, state) {
                    var cubit = AppCubit.get(context);
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        cubit.finalImage == null
                            ? const CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(
                                  "https://www.pngitem.com/pimgs/m/575-5759580_anonymous-avatar-image-png-transparent-png.png",
                                ),
                              )
                            : CircleAvatar(
                                radius: 64,
                                backgroundImage: FileImage(
                                  File(cubit.finalImage!.path),
                                ),
                              ),
                        Positioned(
                          bottom:-10,
                          right:-10,
                          child: Container(
                            decoration:const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                            ),
                            child: IconButton(
                              onPressed: () {
                                cubit.pickImage();
                              },
                              icon: Icon(
                                cubit.finalImage!=null?Icons.edit:Icons.add,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 50.0,
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: "Username",
                  ),
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Username cannot be empty";
                    }
                    return null;
                  },

                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                  validator: (value) {
                    if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!)){
                      return "Invalid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                  validator: (value) {
                    RegExp regex =
                    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    } else {
                      if (!regex.hasMatch(value)) {
                        return 'Enter valid password';
                      } else {
                        return null;
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 50.0,
                ),
                BlocConsumer<AppCubit, AppState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    var cubit = AppCubit.get(context);
    return state is RegisterLoading ?
    const Center(
      child: CircularProgressIndicator(
        color: Colors.black,
      ),
    )
    :ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size(
                      double.infinity,
                      55.0
                    )
                  ),
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        cubit.register(
                            email: _emailController.text,
                            password:_passwordController.text,
                            username: _usernameController.text,
                        );
                      }
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                );
  },
),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
