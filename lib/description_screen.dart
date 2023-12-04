import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_class_mwf/ApiServices.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class DescriptionScreen extends StatefulWidget {
  var id;

  DescriptionScreen({required this.id});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  List containerColor = [Colors.purple, Colors.red, Colors.green];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
          body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: FutureBuilder(
            future: MyServices.descriptionfetch(widget.id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                Map map = jsonDecode(snapshot.data);
                List movieImages = map['tvShow']['pictures']; //--> Carousel
                List genres = map['tvShow']['genres']; //--> Genres
                double rating = double.parse(map['tvShow']['rating']) / 2;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 260,
                      child: Stack(children: [
                        CarouselSlider(
                            items: List.generate(
                                movieImages.length,
                                (index) => Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 10),
                                      width: double.infinity,
                                      height: 180,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  movieImages[index]))),
                                    )),
                            options: CarouselOptions(
                                autoPlay: true,
                                viewportFraction: 1,
                                height: 180,
                                autoPlayInterval: Duration(milliseconds: 2500),
                                autoPlayCurve: Curves.easeIn)),
                        Positioned(
                          top: 80,
                          left: 24,
                          child: Container(
                            width: 120,
                            height: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.red,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        '${map['tvShow']['image_path']}'))),
                          ),
                        ),
                        Positioned(
                          top: 170,
                          left: 150,
                          child: Text(
                            '${map['tvShow']['name']}',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18),
                          ),
                        ),
                        Positioned(
                          top: 190,
                          left: 150,
                          child: Text(
                            '${map['tvShow']['start_date']}',
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 14),
                          ),
                        ),
                        Positioned(
                          top: 210,
                          left: 150,
                          child: RatingBarIndicator(
                            rating: rating,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                        )
                      ]),
                    ),
                    Center(
                      child: Text(
                        'Genres',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 18),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 40,
                        child: Divider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      width: double.infinity,
                      height: 30,
                      child: ListView.builder(
                        itemCount: genres.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              genres[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          );
                        },
                      ),
                    ),
                    Center(
                      child: Text(
                        'Description',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 18),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 40,
                        child: Divider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(14)),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${map['tvShow']['description']}',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Center(
                      child: Text(
                        'Web URL',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 18),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 40,
                        child: Divider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse('${map['tvShow']['url']}'));
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(14)),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${map['tvShow']['url']}',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              if (snapshot.hasError) {
                return Icon(Icons.error_outline);
              }
              return Container();
            }),
      )),
    );
  }
}
// FutureBuilder(
// future: MyServices.descriptionfetch(widget.id),
// builder: (BuildContext context, AsyncSnapshot snapshot) {
// if (snapshot.hasData) {
// Map map = jsonDecode(snapshot.data);
//
// return Text("${map["tvShow"]["description"]}");
// } else if (snapshot.hasError) {
// return Icon(Icons.error_outline);
// } else {
// return CircularProgressIndicator();
// }
// }),
