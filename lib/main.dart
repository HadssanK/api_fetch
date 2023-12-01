import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_class_mwf/ApiServices.dart';
import 'package:flutter_class_mwf/description_screen.dart';
import 'package:flutter_class_mwf/reuseable_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Fetch"),
      ),
      body: FutureBuilder(
          future: MyServices.apifetch(),
          builder: (context, snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            }

            if(snapshot.hasData){
              Map map = jsonDecode(snapshot.data);
              List mydata = map['tv_shows'];
              return ListView.builder(
                itemCount: mydata.length,
                itemBuilder: (context, index) {
                  var movieID = mydata[index]['id'];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DescriptionScreen(id: movieID),));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Movie ID: $movieID")));
                  },
                  child: MovieContainer(
                      movieImage: mydata[index]["image_thumbnail_path"],
                      movieName: mydata[index]['name'],
                      movieNetwork: mydata[index]['network'],
                      movieStatus: mydata[index]['status'],
                      movieDate: mydata[index]['start_date']),
                );
              },);
            }

            if(snapshot.hasError){
              return Icon(Icons.error);
            }

            return Container();
          },),
    );
  }
}





