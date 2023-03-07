import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/textForm.dart';
import '../controller/auth_controller.dart';

class Register extends ConsumerWidget {
  Register({super.key});
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController =TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Register",style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
            const SizedBox(height: 15,),
            TextForm(title: "name", controller: nameController),
            const SizedBox(height: 10),
            TextForm(title: "email", controller: emailController),
            const SizedBox(height: 10),
            TextForm(title: "password", controller: passwordController),
            const SizedBox(height: 10),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                ref.read(authControllerProvider.notifier).createUser(context: context,email: emailController.text, password: passwordController.text, name: nameController.text, isAuthenticated: true);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.purple[200]
                ),
                height: 50,
                width: MediaQuery.of(context).size.width/1.1,
                child: const Text("create my user",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
              ),
            ),
          ]
        ),
      )
    );
  }
}