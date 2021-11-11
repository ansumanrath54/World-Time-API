import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map data = {};
  WorldTime worldTime = WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    print(data);

    String bgImage = data['isDayTime'] ? 'day.jpg' : 'night.jpg';
    Color bgColor = data['isDayTime'] ? Colors.blue : Colors.black38;

    Future<void> update(WorldTime worldTime) async {

      await worldTime.getTime();

      setState(() {
        data = {
          'location': worldTime.location,
          'flag': worldTime.flag,
          'time': worldTime.time,
          'isDayTime': worldTime.isDayTime
        };
      });
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/$bgImage'),
              fit: BoxFit.cover
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child:
            RefreshIndicator(

              onRefresh: () { return update(worldTime); },
              child: ListView(
                children: [
                  FlatButton.icon(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      worldTime = WorldTime(location: result['location'], flag: result['flag'], url: result['url']);
                      await worldTime.getTime();

                      setState(() {
                        data = {
                          'location': worldTime.location,
                          'flag': worldTime.flag,
                          'time': worldTime.time,
                          'isDayTime': worldTime.isDayTime
                        };
                      });
                    },
                    icon: const Icon(Icons.edit_location),
                    label: const Text('Edit Location'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data['location'],
                        style: const TextStyle(fontSize: 28, letterSpacing: 2.0),
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0,),
                  Center(
                    child: Text(
                      data['time'],
                      style: const TextStyle(
                        fontSize: 66.0
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
