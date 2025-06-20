import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/categories_news_model.dart';
import 'package:news_app/view/home_Screen.dart';
import 'package:news_app/view_model/news_view_model.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {


 NewsViewModel newsViewModel = NewsViewModel();


  final format = DateFormat("MMMM dd, yyyy"); // corrected yyyy
String categoryname= "General";



List<String> Categorieslist=[
"General","Entertainment","Health","Sports","Buisness","Technology"

];



  @override
  Widget build(BuildContext context) {
        final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
appBar: AppBar(
  centerTitle: true,
  iconTheme: IconThemeData(
    color: Colors.white
  ),
  backgroundColor: Colors.black,
title: Text(
          "Categories",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white
          ),
        ),

),
body: Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Column(
    children: [
      SizedBox(height: 50,
      child: ListView.builder(
        
        scrollDirection: Axis.horizontal,
        itemCount: Categorieslist.length,
        itemBuilder: (context,index){
          
  return InkWell(
    
    onTap: () {
      categoryname= Categorieslist[index];
      setState(() {
        
      });
    },
    child: Padding(
      padding: const EdgeInsets.only(right: 12,top: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey
          ),
          borderRadius: BorderRadius.circular(20),
        color: categoryname==Categorieslist[index]? Colors.grey: Colors.black
          
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(child: Text(Categorieslist[index].toString(),
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: Colors.white
          ),
          
          )),
        ),
      ),
    ),
  );
  
  
  
        }),
      
      ),
    SizedBox(height: 20,),
Expanded(
  child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fetchcategoriesnewsapi(categoryname),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: spinkit2);
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(
                          snapshot.data!.articles![index].publishedAt.toString(),
                        );
  
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Container(
decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.85),
                             
                                borderRadius: BorderRadius.circular(12)
                                
                              ),

                            child: Row(
                              children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data!.articles![index]
                                              .urlToImage ??
                                          "",
                                      fit: BoxFit.cover,
                                      width: screenWidth*.18,
                                      height: screenHeight*.18,
                                      
                                      placeholder: (context, url) =>
                                          Center(child: spinkit2),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error, color: Colors.red),
                                    
                                    ),
                                    
                                  ),
                            Expanded(child: Container(
                              height: screenHeight*.18,
                              padding: EdgeInsets.only(left: 15),
                              child: Column(
                                children: [
                            Text(snapshot.data!.articles![index].title.toString(),
                            style: GoogleFonts.poppins(
                            fontSize: 15,color: Colors.black,
                            fontWeight: FontWeight.w700
                            
                            ),
                            
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(snapshot.data!.articles![index].source!.name.toString(),
                            style: GoogleFonts.poppins(
                            fontSize: 15,color: Colors.black,
                            fontWeight: FontWeight.w600
                            
                            ),
                            
                            ),
                            Text(format.format(dateTime),
                            style: GoogleFonts.poppins(
                            fontSize: 15,color: Colors.black,
                            fontWeight: FontWeight.w500
                            
                            ),
                            
                            ),
                              ],
                            )
                            
                                ],
                              ),
                            ))
                            
                              ],
                            
                            
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text("Something went wrong."),
                    );
                  }
                },
              ),
),


    ],
  ),
),
    );
  }
}
const spinkit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
