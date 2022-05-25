import 'dart:convert';

import 'package:hungry_hour/controller/ip.dart';
import 'package:hungry_hour/model/get_area.dart';
import 'package:http/http.dart' as http;

class AreaController {
  static Future<List<Area>> areas() async {
    List<Area> _rests = [];
    var url = Uri.parse(GETAREAURL);
    var response = await http.get(url, headers: {"Accept": "application/json"});
    print(response.body);
    if (response.statusCode == 200) {
      List res = jsonDecode(response.body);
      res.forEach((element) {
        _rests.add(Area.fromJson(element));
      });
    } else {}
    //print(_rests.length);
    return _rests;
  }
}
