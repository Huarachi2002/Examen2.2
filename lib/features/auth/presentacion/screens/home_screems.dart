import 'dart:async';
import 'package:google_mao/config/menu/menu_items.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_mao/constants.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  static const String name = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  List<LatLng> polylineCoordinates = [];

  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  LocationData? currentLocation;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((location) {
      currentLocation = location;
    });
    GoogleMapController googleMapController = await _controller.future;

    if (googleMapController != null) {
      location.onLocationChanged.listen((newLoc) {
        currentLocation = newLoc;
        googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 13.5,
            target: LatLng(newLoc.latitude!, newLoc.longitude!),
          ),
        ));
        setState(() {});
      });
    }
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Pin_source.png")
        .then((icon) {
      sourceIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Pin_destination.png")
        .then((icon) {
      destinationIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Badge.png")
        .then((icon) {
      currentLocationIcon = icon;
    });
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        google_api_key,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude));

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    if (!_controller.isCompleted) {
      getCurrentLocation();
      setCustomMarkerIcon();
      getPolyPoints();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(color: colorFontsTitle),
          ),
          backgroundColor: colorBackground,
        ),
        drawer: Drawer(
          backgroundColor: Colors.transparent,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  _MyHeaderDrawer(),
                  _MyDrawerList(),
                ],
              ),
            ),
          ),
        ),
        body: currentLocation != null
            ? Center(
                child: Container(
                  width: 80, // Ancho del contenedor
                  height: 80, // Alto del contenedor
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
              )
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(-17.7833274, -63.1835149), zoom: 14.5),
                polylines: {
                  Polyline(
                      polylineId: PolylineId("route"),
                      points: polylineCoordinates,
                      color: primaryColor,
                      width: 4)
                },
                markers: {
                  Marker(
                      markerId: MarkerId('currentlocation'),
                      icon: currentLocationIcon,
                      position: LatLng(currentLocation!.latitude!,
                          currentLocation!.longitude!)),
                  Marker(
                      markerId: MarkerId('source'),
                      icon: sourceIcon,
                      position: sourceLocation),
                  Marker(
                      markerId: MarkerId('destination'),
                      icon: destinationIcon,
                      position: destination),
                },
                onMapCreated: (mapController) {
                  _controller.complete(mapController);
                },
              ),
      ),
    );
  }

  Widget _MyDrawerList() {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(top: 15),
      child: Column(
        //Lista del menu
        children: [
          menuItem(appMenuConfig[0].title, appMenuConfig[0].icon,
              appMenuConfig[0].link),
          menuItem(appMenuConfig[1].title, appMenuConfig[1].icon,
              appMenuConfig[1].link)
        ],
      ),
    );
  }

  Widget menuItem(String title, IconData icon, String link) {
    return Builder(builder: (context) {
      return Material(
        color: colorBackground,
        child: InkWell(
            onTap: () {
              context.push(link);
            },
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(children: [
                Expanded(
                  child: Icon(
                    icon,
                    size: 20,
                    color: colorIcons,
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: colorFontsTitle,
                        fontSize: 16,
                      ),
                    ))
              ]),
            )),
      );
    });
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    required this.menuItem,
  });

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(menuItem.icon, color: colors.primary),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: colors.primary),
      title: Text(menuItem.title),
      subtitle: Text(menuItem.subTitle),
      onTap: () {
        context.push(menuItem.link);
      },
    );
  }
}

class _MyHeaderDrawer extends StatefulWidget {
  const _MyHeaderDrawer({super.key});

  @override
  State<_MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<_MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/images/profile.png')),
            ),
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            splashColor: colorBackground,
            highlightColor: colorBackground,
            onPressed: () {},
            color: colorBackgroundButton,
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                'Yeferson Adrian Huarachi',
                style: TextStyle(
                  color: colorFontsTitle,
                ),
              ),
            ),
          ),
          MaterialButton(
            splashColor: colorBackground,
            highlightColor: colorBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            onPressed: () {},
            color: colorBackgroundButton,
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                '220001499',
                style: TextStyle(
                  color: colorFontsTitle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// class _ControlledProgresIndicator extends StatelessWidget {
//   const _ControlledProgresIndicator();

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: Stream.periodic( const Duration( milliseconds: 300 ), (value) {
//         return (value * 2) / 100; // 0.0, 1.0
//       }).takeWhile((value) => value < 100 ),
//       builder: (context, snapshot) {

//         final progressValue = snapshot.data ?? 0;

//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircularProgressIndicator( value: progressValue, strokeWidth: 2, backgroundColor: Colors.black12, ),
//               const SizedBox(width: 20,),
//               Expanded(
//                 child: LinearProgressIndicator(value: progressValue )
//               ),
              
//             ],
//           ),
//         );

//       },
//     );
//   }
// }