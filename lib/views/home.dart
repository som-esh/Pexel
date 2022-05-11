// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaperhubapp/data/data.dart';
import 'package:wallpaperhubapp/model/categories_model.dart';
import 'package:wallpaperhubapp/model/wallpaper_model.dart';
import 'package:wallpaperhubapp/views/categories.dart';
import 'package:wallpaperhubapp/views/image_view.dart';
import 'package:wallpaperhubapp/views/search.dart';
import 'package:wallpaperhubapp/widget/brandName.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategorieModel> categories = [];
  List<WallpaperModel> wallpapers = [];
  TextEditingController searchQuery = new TextEditingController();

  getTrendingPhotos() async{
    String url = "https://api.pexels.com/v1/curated";
    var response = await http.get(url, headers: {
      "Authorization" : api
    });
    // ignore: avoid_print
    //print(response.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    //print(jsonData);

    jsonData["photos"].forEach((element){
      WallpaperModel wallpaperModel = WallpaperModel.fromMap(element);
      //print(wallpaperModel.photographer_url);
      wallpapers.add(wallpaperModel);
    }
    );
    setState(() {});
  }
  @override
  void initState() {
    getTrendingPhotos();
    categories = getCategories();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: BrandName(),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
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
                  controller: searchQuery,
                  decoration: InputDecoration(
                    hintText: "search wallpaper",
                    border: InputBorder.none,
                  ),
                )
                ),
                GestureDetector(
                    child: Icon(Icons.ac_unit),
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Search(
                      searchQuery: searchQuery.text,
                    )),
                    );
                  }),
              ],),
            ),
            SizedBox(height: 14,),
            //Spacer(),
            Container(
              height: 80,
              child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  itemBuilder: (context, index){
                    return CategoriesTile(
                      title: categories[index].categoryName,
                      imgUrl: categories[index].imgUrl,
                    );
                  }
              ),
            ),
            //SizedBox(height: 0,),
            wallpaperList(wallpapers: wallpapers, context: context),
          ],
        ),),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String title, imgUrl;
  const CategoriesTile({required this.title, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:
            (context)=> Categories(categoryName: title.toLowerCase())));
      },
      child: Container(
        margin: EdgeInsets.only(right: 5),
        child: Stack(children: [

        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(imgUrl, height: 50, width: 100, fit: BoxFit.fill,)),
      Container(
        //padding: EdgeInsets.symmetric(horizontal: 24),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black26,
        ),
        height: 50,
        width: 100,
        child: Text(title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),),
            ),
          ],
        ),
      ),
    );
  }
}

