import 'package:candy_shop/core/common/textForm.dart';
import 'package:candy_shop/features/auth/controller/auth_controller.dart';
import 'package:candy_shop/features/auth/view/Register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Login extends ConsumerWidget {
  Login({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Welcome!",style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
          const SizedBox(height: 20),
          TextForm(title: "email", controller: emailController),
          const SizedBox(height: 10),
          TextForm(title: "password", controller: passwordController),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: (){ref.read(authControllerProvider.notifier).signPasswordEmail(email: emailController.text, password: passwordController.text, context: context);},
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.purple[200]
              ),
              height: 50,
              width: MediaQuery.of(context).size.width/1.1,
              child: const Text("sign in",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),),
            ),
          ),
          const SizedBox(height: 10,),
          GestureDetector(
            onTap: (){ref.read(authControllerProvider.notifier).signGuess();},
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.purple[200]
              ),
              height: 50,
              width: MediaQuery.of(context).size.width/1.1,
              child: const Text("i prefer be a guess",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),),
            ),
          ),
          const SizedBox(height: 15),
          const Text("or",style: TextStyle(fontSize: 16),),
          const SizedBox(height: 15,),
          GestureDetector(
            onTap: ()=>ref.watch(authControllerProvider.notifier).signInWithGoogle(context),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.purple[200]
              ),
              height: 50,
              width: MediaQuery.of(context).size.width/1.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/google.png", height: 25,),
                  const SizedBox(width: 8,),
                  const Text("google",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20,),
          GestureDetector(
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Register(),));},
            child: const Text("I don't have a account"))
        ],
      ),
    );
  }
}