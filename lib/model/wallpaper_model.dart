class WallpaperModel{
  late String photographer;
  late String photographer_url;
  late int photographer_id;
  late SrcModel src;

  WallpaperModel({required this.src, required this.photographer, required this.photographer_id,required this.photographer_url});

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData){
    //print(jsonData["photographer_id"]);
    return WallpaperModel(
        src: SrcModel.fromMap(jsonData["src"]),
        photographer: jsonData["photographer"],
        photographer_id: jsonData["photographer_id"],
        photographer_url: jsonData["photographer_url"]);
  }
}

class SrcModel{
  late String original;
  late String small;
  late String portrait;

  SrcModel({required this.original,required this.small,required this.portrait});

  factory SrcModel.fromMap(Map<String, dynamic> jsonData){
    return SrcModel(original: jsonData["original"],
        small: jsonData["small"],
        portrait: jsonData["portrait"]);
  }
}