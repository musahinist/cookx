import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SodioMap extends StatefulWidget {
  const SodioMap({Key? key}) : super(key: key);

  @override
  _SodioMapState createState() => _SodioMapState();
}

class _SodioMapState extends State<SodioMap> with TickerProviderStateMixin {
  static LatLng london = LatLng(51.5, -0.09);
  static LatLng paris = LatLng(48.8566, 2.3522);
  static LatLng dublin = LatLng(53.3498, -6.2603);
  var circleMarkers = <CircleMarker>[
    CircleMarker(
        point: LatLng(51.5, -0.09),
        color: Colors.blue.withOpacity(0.7),
        borderStrokeWidth: 2,
        useRadiusInMeter: true,
        radius: 2000 // 2000 meters | 2 km
        ),
  ];
  var overlayImages = <OverlayImage>[
    OverlayImage(
        bounds: LatLngBounds(LatLng(51.5, -0.09), LatLng(48.8566, 2.3522)),
        opacity: 0.8,
        imageProvider: NetworkImage(
            'https://images.pexels.com/photos/231009/pexels-photo-231009.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=300&w=600')),
  ];
  late final MapController mapController;
  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final _latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(51.5, -0.09),
              zoom: 13.0,
            ),
            layers: [
              TileLayerOptions(
                  maxZoom: 20,
                  backgroundColor: Colors.black,
                  tileBuilder: (context, tileWidget, tile) => ColorFiltered(
                        colorFilter: ColorFilter.matrix([
                          -1,
                          0,
                          0,
                          0,
                          255,
                          0,
                          -1,
                          0,
                          0,
                          255,
                          0,
                          0,
                          -1,
                          0,
                          255,
                          0,
                          0,
                          0,
                          1,
                          0
                        ]),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.srgbToLinearGamma(),
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                Colors.grey, BlendMode.saturation),
                            child: tileWidget,
                          ),
                        ),
                      ),
                  urlTemplate:
                      'http://mt0.google.com/vt/lyrs=m&hl=en&x={x}&y={y}&z={z}',
                  subdomains: ['mt0', 'mt1', 'mt2', 'mt3']),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(51.5, -0.09),
                    builder: (ctx) => Icon(
                      Icons.circle,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              //  OverlayImageLayerOptions(overlayImages: overlayImages),
              //  CircleLayerOptions(circles: circleMarkers)
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _animatedMapMove(paris, 13);
        },
      ),
    );
  }
}
