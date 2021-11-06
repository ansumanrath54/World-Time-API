import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  late String url;
  late String location;
  late String time;
  late String flag;
  late bool isDayTime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response = await get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      String sign = data['utc_offset'].substring(0,1);
      print(sign);
      DateTime now = DateTime.parse(datetime);
      now = sign.contains('+') ? now.add(Duration(hours: int.parse(offset)))
          : now.subtract(Duration(hours: int.parse(offset)));
      isDayTime = now.hour > 5 && now.hour < 17;
      time = DateFormat.jm().format(now);
    }
    catch(e) {
      print('caught error: $e');
      time = 'Could not get time';
    }
  }

}