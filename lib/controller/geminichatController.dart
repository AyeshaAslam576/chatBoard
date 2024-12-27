import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Message{
  final bool isUser;
  final String messages;
  final DateTime date;
  const Message({required this.isUser,required this.messages,required this.date});
}
class Messages extends StatelessWidget {
  final bool isUser;
  final String messages;
  final String date;
  const Messages({super.key,required this.isUser,required this.messages,required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 10).copyWith(

          left:isUser? 100:10,
          right: isUser?10:100,
      ),
      decoration: BoxDecoration(

        color: isUser?Color(0xffd606a6):Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(messages,style: GoogleFonts.sen(textStyle: TextStyle(
              color: isUser?Colors.white:Colors.black,
              fontSize: 15)),),
          Align(
              alignment: Alignment.bottomRight,
              child: Text(date,
                style: GoogleFonts.sen( textStyle: TextStyle(
                color: isUser?Colors.white:Colors.black,
              )),
              )
          ),
        ],
      ),
    );
  }
}
