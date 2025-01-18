class LookAt{
  late double lng;
  late double lat;
  late double altitude;
  late String range;
  late String tilt;
  late String heading;
  late String altiudeMode;

  LookAt(
      {required this.lng,
        required this.lat,
        required this.range,
        required this.tilt,
        required this.heading,
        this.altitude = 0,
        this.altiudeMode = 'relativeToGround'});

  String get linearTag =>
      '<LookAt><longitude>$lng</longitude><latitude>$lat</latitude><altitude>$altitude</altitude><range>$range</range><tilt>$tilt</tilt><heading>$heading</heading><gx:altitudeMode>$altiudeMode</gx:altitudeMode></LookAt>';
  toMap() {
    return {
      'lng': lng,
      'lat': lat,
      'altitude': altitude,
      'range': range,
      'tilt': tilt,
      'heading': heading,
      'altitudeMode': altiudeMode
    };
  }
  factory LookAt.fromMap(Map<String, dynamic> map) {
    return LookAt(
        lng: map['lng'],
        lat: map['lat'],
        altitude: map['altitude'],
        range: map['range'],
        tilt: map['tilt'],
        heading: map['heading'],
        altiudeMode: map['altitudeMode']);
  }
}