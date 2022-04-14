import 'dart:convert';

import 'package:http/http.dart';

const apiKey = '26711456-bde74f403cb42e77029bc1678';
const appUrl = 'https://pixabay.com/api/';

class PhotosService {
  Future getData(String url) async {
    print('Calling url: $url');
    final response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
    }
  }

  List<PhotosModel> dataList = [];
  Future<List<PhotosModel>> getPhotos(String query) async {
    final photosData = await getData('$appUrl?key=$apiKey&q=$query');
    var data = json.decode(photosData);
    var items = data["hits"];
    items.forEach((element) {
      dataList.add(PhotosModel.fromJson(element));
    });

    print('this is photos data: $photosData');
    return dataList;
  }
}

class PhotosModel {
  String previewURL;

  PhotosModel({required this.previewURL});

  factory PhotosModel.fromJson(Map<dynamic, dynamic> json) =>
      _commentFromJson(json);

  Map<dynamic, dynamic> toJson() => photosModelToJson(this);
}

PhotosModel _commentFromJson(Map<dynamic, dynamic> json) {
  return PhotosModel(
    previewURL: json['previewURL'],
  );
}

Map<dynamic, dynamic> photosModelToJson(PhotosModel instance) =>
    <dynamic, dynamic>{
      'previewURL': instance.previewURL,
    };
