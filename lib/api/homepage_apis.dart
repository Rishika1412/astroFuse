import 'dart:convert';

import 'package:astrofuseui/components/constants.dart';
import 'package:astrofuseui/model/astrologers_model.dart';
import 'package:astrofuseui/model/blog_model.dart';
import 'package:http/http.dart' as http;

class HomePageApis {
  Future<List<String>> getImageBanner() async {
    final url = Uri.parse('$baseUrl/$api');
    try {
      var res = await http.post(url);
      if (res.statusCode == 200) {
        var jsondata = json.decode(res.body);
        List? bannardata = jsondata['banner'];
        List<String> banners = [];
        if (bannardata != null && bannardata.isNotEmpty) {
          bannardata.forEach((element) {
            String bannerImage = element["bannerImage"];
            bannerImage.replaceAll('\\', '');
            banners.add('$imgbaseUrl/$bannerImage');
          });
        }
        return banners;
      } else {
        return Future.error(
            'Failed to load image error code : ${res.statusCode}');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<BlogModel>> getBlogs() async {
    final url = Uri.parse('$baseUrl/$api');
    try {
      var res = await http.post(url);
      if (res.statusCode == 200) {
        var jsondata = json.decode(res.body);
        List? blogsdata = jsondata['blog'];
        List<BlogModel> blogs = [];
        if (blogsdata != null && blogsdata.isNotEmpty) {
          blogsdata.forEach((element) {
            BlogModel model = BlogModel.fromJson(element);
            blogs.add(model);
          });
        }
        return blogs;
      } else {
        return Future.error(
            'Failed to load blogs error code : ${res.statusCode}');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<AstroModel>> getAstrologers() async {
    final Map<String, dynamic> requestBody = {
      "userId": 544,
      "astrologerCategoryId": null,
      "filterData": {
        "skills": null,
        "languageKnown": null,
        "gender": null,
      },
      "sortBy": null,
      "startIndex": 0,
      "fetchRecord": 20,
    };
    final url = Uri.parse('$baseUrl/$astroapi');
    try {
      var res = await http.post(url,
          headers: {
            "Authorization": "Bearer $astroToken",
            "Content-Type": "application/json",
          },
          body: jsonEncode(requestBody));
      if (res.statusCode == 200) {
        var jsondata = json.decode(res.body);
        List? astrodata = jsondata['recordList'];
        List<AstroModel> astrologers = [];
        if (astrodata != null && astrodata.isNotEmpty) {
          
          astrodata.forEach((element) {
          AstroModel model =   AstroModel.fromJson(element);
            astrologers.add(model);
          });
        }
        return astrologers;
      } else {
        return Future.error(
            'Failed to load astrologers error code : ${res.statusCode}');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
