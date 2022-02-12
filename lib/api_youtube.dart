import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:youtube_app/models/video.dart';

const CHAVE_YOUTUBE_API = "AIzaSyDuDXj7kxUcb48gBmTXt33XH4lI0HN54w4";
const ID_CANAL = "UCJm7i4g4z7ZGcJA_HKHLCVw";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api {
  Future<List<Video>> pequisar(String pesquisa) async {
    final uri = Uri.parse(URL_BASE + 'search').replace(queryParameters: {
      'part': "snippet",
      'type': "video",
      'maxResults': '20',
      'order': 'date',
      'key': CHAVE_YOUTUBE_API,
      'channelId': ID_CANAL,
      'q': pesquisa
    });

    var retorno;
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> dadosJson = json.decode(response.body);

      retorno = dadosJson["items"].map<Video>((map) {
        return Video.fromJson(map);
      }).toList();
    } else {
      print('error');
    }

    return retorno;
  }
}
