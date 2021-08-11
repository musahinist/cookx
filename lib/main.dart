import 'dart:convert';
import 'dart:math';
import 'package:cookx/view/map/flutter_map.dart';
import 'package:cookx/view/page/earth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Earth Demo',
      theme: ThemeData.dark(),
      home: SodioMap(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // late FlutterEarthController _controller;
  // double _zoom = 0;
  // LatLon _position = LatLon(0, 0);
  // String _cityName = '';
  // dynamic _cityList;
  // Random _random = Random();

  // void _onMapCreated(FlutterEarthController controller) {
  //   _controller = controller;
  //   _moveToNextCity();
  // }

  // void _onCameraMove(LatLon latLon, double zoom) {
  //   setState(() {
  //     _zoom = zoom;
  //     _position = latLon.inDegrees();
  //   });
  // }

  // void _moveToNextCity() {
  //   if (_cityList != null) {
  //     final int index = _random.nextInt(_cityList.length);
  //     final dynamic city = _cityList[index];
  //     final double lat = double.parse(city['latitude']);
  //     final double lon = double.parse(city['longitude']);
  //     _cityName = city['city'];
  //     _controller.animateCamera(
  //         newLatLon: LatLon(lat, lon).inRadians(),
  //         riseZoom: 2.2,
  //         fallZoom: 11.2,
  //         panSpeed: 500,
  //         riseSpeed: 3,
  //         fallSpeed: 2);
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   rootBundle.loadString('asset/city.json').then((String data) {
  //     _cityList = json.decode(data);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(51.5, -0.09),
        zoom: 0,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(51.5, -0.09),
              builder: (ctx) => Container(
                child: FlutterLogo(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
