import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_simple_app/modules/login/login_screen.dart';
import 'package:social_simple_app/modules/register/register_cubit/register_cubit.dart';
import 'package:social_simple_app/modules/register/register_cubit/register_states.dart';

import '../../shared/components/components.dart';

class RegisterScreeen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            showToast(message: 'Successful Register', color: ToastState.SUCESS);
            navigateAndFinish(context: context, widget:  LoginScreen());
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: keyForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'REGISTER',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'Register now to communicate with friends',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultTextFromField(
                          label: 'Name',
                          prefixIcon: Icons.person,
                          controller: nameController,
                          textInputType: TextInputType.name,
                          validatorMethod: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the name';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultTextFromField(
                          label: 'Email Address',
                          prefixIcon: Icons.email,
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          validatorMethod: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the email';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultTextFromField(
                          label: 'Password',
                          obscure: cubit.isObscure,
                          prefixIcon: Icons.lock,
                          suffixIcon: cubit.icon,
                          controller: passwordController,
                          suffixOnPressed: () {
                            cubit.changePasswordVisibility();
                          },
                          textInputType: TextInputType.visiblePassword,
                          validatorMethod: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the password';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultTextFromField(
                          label: 'Phone',
                          prefixIcon: Icons.phone_android,
                          controller: phoneController,
                          textInputType: TextInputType.phone,
                          validatorMethod: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the phone';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20.0,
                      ),
                      state is RegisterLoadingState
                          ? const Center(child: CircularProgressIndicator())
                          : defaultButton(
                              text: 'Register',
                              onPressed: () {
                                // print(nameController.text);
                                // print(emailController.text);
                                // print(passwordController.text);
                                // print(phoneController.text);

                                if (keyForm.currentState!.validate()) {
                                  cubit.userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                      context: context);
                                }
                              }),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
