import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/categories_news_model.dart';
import 'package:news_app/view/categories.dart';
import 'package:news_app/view/category_detailed_screen.dart';
import 'package:news_app/view/detailed_screen.dart';
import 'package:news_app/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum filterList{bbcNews, axios,abcNews, ansa,cnn,alJazera,arynews }

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  filterList?selectedmenu;
  final format = DateFormat("MMMM dd, yyyy"); // corrected yyyy
String name= "bbc-news" ;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
     backgroundColor: Colors.black,
      appBar: AppBar(
         backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {

            Navigator.push(context, MaterialPageRoute(builder: (context)=>Categories()));

          },
          icon: Icon(Icons.menu),
          // icon: Image.asset(
          //   "assets/category_icon.png",
          //   height: 30,
          //   width: 30,
          // ),
          color: Colors.white,
        ),
        title: Text(
          "News",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white
          ),
        ),

       actions: [
  PopupMenuButton<filterList>(
    color: Colors.black, // 👈 background color of the popup
    borderRadius: BorderRadius.circular(10),
    initialValue: selectedmenu,
    icon: Icon(Icons.more_vert_outlined, color: Colors.white), // icon color

    onSelected: (filterList item) {
      if (filterList.bbcNews.name == item.name) {
        name = 'bbc-news';
      }
      if (filterList.axios.name == item.name) {
        name = 'axios';
      }
      if (filterList.alJazera.name == item.name) {
        name = "al-jazeera-english";
      }
      if (filterList.abcNews.name == item.name) {
        name = "abc-news-au";
      }
      if (filterList.ansa.name == item.name) {
        name = "ansa";
      }
      if (filterList.arynews.name == item.name) {
        name = "ary-news";
      }

      setState(() {
        selectedmenu = item;
      });
    },

    itemBuilder: (BuildContext context) => <PopupMenuEntry<filterList>>[
      PopupMenuItem<filterList>(
        value: filterList.bbcNews,
        child: Text("BBC News", style: TextStyle(color: Colors.white)),
      ),
      PopupMenuItem<filterList>(
        value: filterList.axios,
        child: Text("Axios News", style: TextStyle(color: Colors.white)),
      ),
      PopupMenuItem<filterList>(
        value: filterList.abcNews,
        child: Text("ABC News", style: TextStyle(color: Colors.white)),
      ),
      PopupMenuItem<filterList>(
        value: filterList.alJazera,
        child: Text("Aljazeera News", style: TextStyle(color: Colors.white)),
      ),
      PopupMenuItem<filterList>(
        value: filterList.ansa,
        child: Text("Ansa News", style: TextStyle(color: Colors.white)),
      ),
      PopupMenuItem<filterList>(
        value: filterList.arynews,
        child: Text("Ary News", style: TextStyle(color: Colors.white)),
      ),
    ],
  )
],

      ),
      body: ListView(
        children: [
          SizedBox(
            height: screenHeight * 0.55,
            width: screenWidth,
            child: FutureBuilder(
              future: newsViewModel.fetchNewsChaneelHeadlinesApi(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: spinkit2);
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(
                        snapshot.data!.articles![index].publishedAt.toString(),
                      );

                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                          width: screenWidth * 0.9,
                          child: InkWell(
                            onTap: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailedScreen(newImage: snapshot.data!.articles![index].urlToImage.toString(), 
newsTitle: snapshot.data!.articles![index].title.toString(),
 newsDate: snapshot.data!.articles![index].publishedAt.toString(),
  author: snapshot.data!.articles![index].author.toString(),
   description: snapshot.data!.articles![index].description.toString(),
    content: snapshot.data!.articles![index].content.toString(),
     source: snapshot.data!.articles![index].source!.name.toString(),
     
     )));

                            },
                            child: SizedBox(
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data!.articles![index]
                                              .urlToImage ??
                                          "",
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                      placeholder: (context, url) =>
                                          Center(child: spinkit2),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error, color: Colors.red),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Card(
                                      margin: EdgeInsets.all(12),
                                      elevation: 6,
                                      color: Colors.white.withOpacity(0.85),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data!.articles![index]
                                                      .title ??
                                                  "No Title",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    snapshot
                                                            .data!
                                                            .articles![index]
                                                            .source
                                                            ?.name ??
                                                        "Unknown Source",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
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


           Padding(
             padding: const EdgeInsets.all(20),
             child: FutureBuilder<CategoriesNewsModel>(
                  future: newsViewModel.fetchcategoriesnewsapi('General'),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: spinkit2);
                    } else if (snapshot.hasData) {
                      return ListView.separated(
                        shrinkWrap: true,
                        
                physics: NeverScrollableScrollPhysics(), // 👈 Prevent inner scrolling

                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(
                            snapshot.data!.articles![index].publishedAt.toString(),
                          );
               
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: InkWell(
                              onTap: () {

Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryDetailedScreen(newImage: snapshot.data!.articles![index].urlToImage.toString(), 
newsTitle: snapshot.data!.articles![index].title.toString(), newsDate: snapshot.data!.articles![index].publishedAt.toString(),
 author: snapshot.data!.articles![index].author.toString(), 
 description: snapshot.data!.articles![index].description.toString(),
  content: snapshot.data!.articles![index].content.toString(),
     source: snapshot.data!.articles![index].source!.name.toString())));



                              },
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
                                             Padding(
                                               padding: const EdgeInsets.only(right: 10),
                                               child: Text(format.format(dateTime),
                                               style: GoogleFonts.poppins(
                                               fontSize: 12,color: Colors.black,
                                               fontWeight: FontWeight.w500
                                               
                                               ),
                                               
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
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(height: 15),
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
    );
  }
}

// Loading spinner
const spinkit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);


