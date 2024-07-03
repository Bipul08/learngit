import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vdo_app_api/model/search_api.dart';

import '../model/vdo_model.dart';

class PixelServices {
      final String baseUrl = 'https://api.pexels.com/videos/';
      final String pexelEndPoint = 'popular';
      final String searchEndPoint = 'search';
      final String apiKey = 'hkGbBpHetKmFRH3oPZVf9nwuoovOflIcXwcz1vpqYQ2rXpQHWBQqjJiE';

      Future<VideoModel> getPixelApi() async {
            var url = Uri.parse('$baseUrl$pexelEndPoint');
            var response = await http.get(url, headers: {
                  'Authorization': apiKey,
            });

            if (response.statusCode == 200) {
                  var resData = jsonDecode(response.body);
                  return VideoModel.fromJson(resData);
            } else {
                  throw Exception('Failed to load videos');
            }
      }

      Future<VideoModel?> searchApi(String name) async {
            var url = Uri.parse('https://api.pexels.com/videos/search?query=$name');
            var response = await http.get(url, headers: {
                  'Authorization': apiKey,
            });

            if (response.statusCode == 200) {
                  var requestData = jsonDecode(response.body);
                  print('reponse: ${response.statusCode}');
                  return VideoModel.fromJson(requestData);
            } else {
                  print('reponse: ${response.statusCode}');
                  return null;
            }
      }



}



