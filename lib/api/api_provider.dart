import 'dart:convert';

import 'package:dio/dio.dart' as http_dio;
import 'package:flutter_dio/api/models/post_model/post_model.dart';

class ApiProvider {
  http_dio.Dio dio = http_dio.Dio();

  Future<List<PostModel>> getDataPostFromApiAsync() async {
    http_dio.Response response;

    try {
      response = await dio.get("https://jsonplaceholderr.typicode.com/posts");
      if (response.statusCode == 200) {
        final List rawData = jsonDecode(jsonEncode(response.data));
        List<PostModel> listPostModel = rawData.map((f) => PostModel.fromJson(f)).toList();

        return listPostModel;
      } else {
        return null;
      }
    } on http_dio.DioError catch (ex) {
      print(ex.error.toString());
      if (ex.type == http_dio.DioErrorType.RESPONSE) {
        //404, 400, 500
        if (ex.response.statusCode == 404) {
          //give warning here
        }
      } else if (ex.type == http_dio.DioErrorType.DEFAULT) {
        throw Exception(ex.error.message);
      } else {
        //timeout and canceled
      }
    }
  }
}
