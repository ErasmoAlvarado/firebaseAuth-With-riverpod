import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextForm extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  const TextForm({super.key, required  this.title, required this.controller});

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  final focus = FocusNode();
  @override
  void initState() {
    focus.addListener(() {
      print(focus.hasFocus);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
                curve:Curves.bounceInOut ,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: focus.hasFocus == true
                  ?const Color.fromARGB(44, 189, 189, 189)
                  :Colors.transparent,
                  border: Border.all(
                   width: 1.5,
                  color: focus.hasFocus == true
                    ?const Color.fromARGB(255, 210, 128, 224)
                    :const Color.fromRGBO(189, 189, 189, 0.447)
                  ),
                ),
                width: MediaQuery.of(context).size.width/1.1,
                child: TextField(
                  controller: widget.controller,
                  style: GoogleFonts.quicksand(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: widget.title,
                    suffixIcon: IconButton(onPressed: (){widget.controller.clear();},
                    icon: const Icon(Icons.clear),
                    splashRadius: 20,
                    ),
                    border: InputBorder.none
                  ),
                  focusNode: focus,
                ),
              ),
    );
  }
  @override
  void dispose() {
    focus.dispose();
    super.dispose();
  }
}