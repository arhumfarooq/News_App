import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DetailedScreen extends StatefulWidget {
  final String newImage, newsTitle, newsDate, author ,description,content , source;
  const DetailedScreen({super.key, required this.newImage, required this.newsTitle, required this.newsDate, required this.author, required this.description, required this.content, required this.source});

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  @override
  Widget build(BuildContext context) {
      final format = DateFormat("MMMM dd, yyyy"); // corrected yyyy

 final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

DateTime dateTime = DateTime.parse(widget.newsDate);

    return  Scaffold(
      backgroundColor: Colors.black,
appBar: AppBar(
  iconTheme: IconThemeData(color: Colors.white),
  centerTitle: true,
  backgroundColor: Colors.black,
  elevation: 0,
  title:   Text("Content",style: GoogleFonts.poppins(
             fontSize: 18,
             color: Colors.white,
             fontWeight: FontWeight.w700
             
             ),),
),

body: Stack(
  children: [
    Container(
      
      height: screenHeight*0.45,
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),
        topRight: Radius.circular(30)
        
        ),
        child: CachedNetworkImage(imageUrl: widget.newImage,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        ),
      ),
    ),

    Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Container(
     
      height: screenHeight*0.6,
      margin: EdgeInsets.only(top: screenHeight*.4),
      padding: EdgeInsets.only(left: 20,right: 20,top: 20),
      decoration: BoxDecoration(
        color: Colors.black,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),
          topRight: Radius.circular(30)
      )
      ),
      child: ListView(
        children: [
      Text(widget.newsTitle,style: GoogleFonts.poppins(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.w700
      
      ),),
      SizedBox(
      
        height: screenHeight*.02,
      ),
      
        Text("Author: "+widget.author,style: GoogleFonts.poppins(
      fontSize: 10,
      color: Colors.white,
      fontWeight: FontWeight.w600
      
      
      ),),
      
          SizedBox(
      
        height: screenHeight*.01,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      Text(widget.source,style: GoogleFonts.poppins(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.w600
      
      ),),
      Text(format.format(dateTime),style: GoogleFonts.poppins(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.w600
      
      ),),
        ],
      ),
      
        
      Text("Description: ",style: GoogleFonts.poppins(
             fontSize: 18,
             color: Colors.white,
             fontWeight: FontWeight.w700
             
             ),),
      
             Expanded(
               child: Text(widget.description,style: GoogleFonts.poppins(
               fontSize: 12,
               color: Colors.white,
               fontWeight: FontWeight.w600
               
               ),),
             ),
      SizedBox(
      
        height: screenHeight*.03,
      ),
      
      Text("Content: ",style: GoogleFonts.poppins(
             fontSize: 18,
             color: Colors.white,
             fontWeight: FontWeight.w700
             
             ),),
      
      Text(widget.content,style: GoogleFonts.poppins(
      fontSize: 12,
      color: Colors.white,
      fontWeight: FontWeight.w600
      
      ),),
      
        ],
      ),
      ),
    )
  ],
)

    );
  }
}