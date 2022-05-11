// ignore_for_file: unnecessary_const, prefer_const_constructors

import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;
  
  ImageView({required this.imgUrl});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.imgUrl,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(widget.imgUrl, fit: BoxFit.cover,)),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white54, width: 1.0),
                    gradient: LinearGradient(
                      colors: const [
                          Color(0x36FFFFFF),
                          Color(0xFFFFFFFF)
                      ]
                    )
                  ),
                  child: Column(
                    children: const [
                      Text("Set Wallpaper", style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),)
                    ],
                  ),
                ),
                GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Text("Cancel", style: TextStyle(color: Colors.white),)),
                SizedBox(height: 50,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
