// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaperhubapp/data/data.dart';
import 'package:wallpaperhubapp/model/wallpaper_model.dart';
import 'package:wallpaperhubapp/widget/brandName.dart';
import 'package:http/http.dart' as http;


class Search extends StatefulWidget {
  //const Search({Key? key}) : super(key: key);
  final String searchQuery;
  Search({required this.searchQuery});
  @override
  _SearchState createState() => _SearchState();
}


class _SearchState extends State<Search> {

  TextEditingController searchController = new TextEditingController();

  List<WallpaperModel> wallpapers = [];

  getSearchPhotos(String query) async{
    String url = "https://api.pexels.com/v1/search?query=$query&per_page=50";
    var response = await http.get(url, headers: {
      "Authorization" : api
    });
    // ignore: avoid_print
    //print(response.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    //print(jsonData);

    jsonData["photos"].forEach((element){
      WallpaperModel wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    }
    );
    setState(() {});
  }
  
  @override
  void initState() {
      getSearchPhotos(widget.searchQuery);
      searchController.text = widget.searchQuery;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    searchController.text = widget.searchQuery;
    return Scaffold(
      appBar: AppBar(
        title: BrandName(),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        //iconTheme: Icons,
          leading: BackButton(
              color: Colors.black
          )
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(child: Column(
            children: <Widget>[
        Container(
        decoration: BoxDecoration(
            color: Color(0xffe6ebff),
          borderRadius: BorderRadius.circular(45),
        ),
        margin: EdgeInsets.symmetric(horizontal: 24),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(children: <Widget>[
          Expanded(child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: searchController.text,
              border: InputBorder.none,
            ),
          ),
          ),
          //Spacer(),
          GestureDetector(
              child: Icon(Icons.search),
              onTap: () {
                // Navigator.push(
                //   context, MaterialPageRoute(builder: (context) => Search(
                //   searchQuery: searchController.text,
                // )),
                Search(searchQuery: searchController.text,
                );
              }),
        ],),
    ),
              SizedBox(height: 16,),
              wallpaperList(wallpapers: wallpapers, context: context),
    ]),
    ),
      ),
    );
  }
}
