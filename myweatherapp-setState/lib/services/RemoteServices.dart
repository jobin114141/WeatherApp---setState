import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myweatherapp/model/weatherModel.dart';

class Remoteservices {
  Future<List<WhetherDetails>?> getWhetherDetails() async {
    String CityName = 'London';
    List<WhetherDetails> details = [];
    final url =
        "http://api.openweathermap.org/data/2.5/forecast?q=$CityName&appid=9e1ea0f519e892fee077f58c9aa22ea8";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse.containsKey('list')) {
        final jsonArray = jsonResponse["list"] as List<dynamic>;

        details = jsonArray
            .map((itemJson) => WhetherDetails.fromJson(itemJson))
            .toList();

        print(details);
        return details;
      }
    }
    return null;
  }
}
