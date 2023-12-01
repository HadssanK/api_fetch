import 'package:flutter/material.dart';

class MovieContainer extends StatelessWidget {
  String movieImage;
  String movieName;
  String movieNetwork;
  String movieStatus;
  String movieDate;


  MovieContainer(
      {required this.movieImage,
      required this.movieName,
      required this.movieNetwork,
      required this.movieStatus,
      required this.movieDate});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main Container
        Container(
          width: double.infinity,
          height: 120,
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(14)
          ),
        ),
        // image container
        Positioned(
          left: 18,
          top: 20,
          child: Row(
            children: [
              // Image Container
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(movieImage)),
                  color: Colors.red,
                ),
              ),

              SizedBox(width: 8,),

              // Text Container
              Container(
                width: 220,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(movieName,style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),),
                    Text(movieNetwork),
                    Text(movieStatus),
                    Text(movieDate)
                  ],
                ),
              )
            ],
          ),
        ),

        // Text Container

      ],
    );
  }
}