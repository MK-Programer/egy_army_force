import '../../../resources/string_manager.dart';
import '../../../resources/values_manager.dart';
import '../../../utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(30.097455811114393, 31.351535169314122);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{
      const MarkerId('marker_1'): Marker(
        markerId: const MarkerId('marker_1'),
        position: const LatLng(30.097455811114393, 31.351535169314122),
        infoWindow: InfoWindow(
          title: AppString.mapTitle.localize(context),
        ),
      )
    };

    Size size = Utils(context).getScreenSize;
    return ListView(
      children: [
        SizedBox(
          width: double.infinity,
          height: size.height * AppSize.s0_45,
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            markers: Set<Marker>.of(markers.values),
            tiltGesturesEnabled: true,
            scrollGesturesEnabled: true,
            gestureRecognizers: Set()
              ..add(
                Factory<EagerGestureRecognizer>(
                  () => EagerGestureRecognizer(),
                ),
              ),
          ),
        ),
        const SizedBox(
          height: AppMargin.m8,
        ),
        const Padding(
          padding: EdgeInsets.all(AppPadding.p12),
          child: LocaleText(
            AppString.aboutUsDescription,
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
