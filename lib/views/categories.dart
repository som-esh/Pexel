import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperhubapp/data/data.dart';
import 'package:wallpaperhubapp/model/wallpaper_model.dart';
import 'package:wallpaperhubapp/widget/brandName.dart';

class Categories extends StatefulWidget {

  final String categoryName;
  const Categories({required this.categoryName});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

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
    // TODO: implement initState
    getSearchPhotos(widget.categoryName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: BrandName(),
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          //iconTheme: Icons,
          leading: const BackButton(
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
              ),
              SizedBox(height: 16,),
              wallpaperList(wallpapers: wallpapers, context: context),
            ]),
        ),
      ),
    );
  }
}
