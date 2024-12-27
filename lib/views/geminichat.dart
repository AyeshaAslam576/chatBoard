import 'dart:io';
import 'package:fluttergemini/controller/geminichatController.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'messages.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Geminichat extends StatefulWidget {
  const Geminichat({super.key});

  @override
  State<Geminichat> createState() => _GeminichatState();
}

class _GeminichatState extends State<Geminichat> {
  final String API_KEY = "AIzaSyBB-ZIJ5j7Lz-DpcTpN6RwZwmN1O_KAiII";
  final List<Message> messages=[];
final TextEditingController inputController=TextEditingController();
  Future<void> getGeminiCall() async {
    final userMessage=inputController.text;
    setState(() {
      messages.add(Message(isUser: true, messages: userMessage, date: DateTime.now()));
    });
    try {
      final apiKey = Platform.environment['API_KEY'] ?? API_KEY;
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
      );



      final response = await model.generateContent([Content.text(userMessage)]);
      setState(() {
        messages.add(Message(isUser: false, messages: response.text??"", date: DateTime.now()));
      });
      print(response.text);
    } catch (e, stacktrace) {
      print('An error occurred: $e');
      print('Stacktrace: $stacktrace');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Ai assistant",style:
        GoogleFonts.sen
          ( textStyle: TextStyle(
            color: Colors.white
        )
        ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.pink,  // Pink shade
                Colors.blue,  // Blue shade
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("asset/butterfly.png",),fit: BoxFit.fill),
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10, ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
        Expanded(
          child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context,index){
          final newMessage=messages[index];
          return Messages(isUser: newMessage.isUser,
              messages: newMessage.messages, date: DateFormat("HH:mm").format(newMessage.date));
        }),
        ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      cursorColor: Colors.white,
                      controller: inputController,
                      style:  GoogleFonts.sen
                        ( textStyle: TextStyle(
                          color: Colors.white
                      )
                      ),
                      decoration:  InputDecoration(

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide(color: Colors.white)
                        ) ,
                         focusedBorder:OutlineInputBorder(
                             borderRadius: BorderRadius.circular(40),
                             borderSide: BorderSide(color: Colors.white)
                         )  ,
                         fillColor: Colors.transparent,
                         filled: true,
                        hintText: "Enter the text",
                        hintStyle:   GoogleFonts.sen
                          ( textStyle: TextStyle(
                            color: Colors.white
                        )
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0,vertical: 20),
                    child: IconButton(
                      onPressed: () {
                        getGeminiCall();
                        inputController.clear();
                      },
                      icon: Icon(Icons.send),
                      iconSize: 30,
                      color: Colors.white,
                      style: IconButton.styleFrom(
                        backgroundColor: Color(0xffd606a6),
                        shape: CircleBorder(),
                      ),
                    ),

                  )


                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}