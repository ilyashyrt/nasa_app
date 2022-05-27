import 'package:nasa_app/constants/app_constants.dart';
import 'package:nasa_app/models/nasa_model.dart';

import 'package:http/http.dart' as http;
import 'package:nasa_app/repository/page_status.dart';

class HttpService {
  Future<Nasa> getData() async {
    String apiUrl =
        "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=${AppConstants.apiKey}&page=1";
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return nasaFromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception("Failed");
    }
  }
}
