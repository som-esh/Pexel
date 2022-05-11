// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wallpaperhubapp/model/wallpaper_model.dart';
import 'package:wallpaperhubapp/views/image_view.dart';

// ignore: non_constant_identifier_names
Widget BrandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(
        "Wallpaper",
        style: TextStyle(color: Colors.black87),
      ),
      Text(
        "Hub",
        style: TextStyle(color: Colors.deepOrangeAccent),
      ),
    ],
  );
}

Widget wallpaperList({required List<WallpaperModel> wallpapers, context}){
  //print(wallpapers);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    alignment: Alignment.topCenter,
    child: GridView.count(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper){
        //print(wallpaper.src.portrait);
        return GridTile(
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ImageView(imgUrl: wallpaper.src.portrait)
              ));
            },
            child: Hero(
              tag: "img",
              child: ClipRRect(
                child: Image.network(wallpaper.src.portrait, fit: BoxFit.fill,),
                borderRadius: BorderRadius.circular(14),
        ),
            ),
          ),);
      }).toList(),
    ),
  );
}
