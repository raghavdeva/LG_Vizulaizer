
class RocketKml{
  String get rocket => '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Placemark>
    <name>Saturn V</name>
    <Model>
<altitudeMode>absolute</altitudeMode>
  <Location>
        <longitude>-80.5828754312998</longitude>
        <latitude>28.583482949633943</latitude>
        <altitude>0</altitude>
      </Location>
    <Orientation>
      <heading>90</heading>
      <tilt>0</tilt>
      <roll>0</roll>
    </Orientation>
    <Scale>
      <x>3</x>
      <y>3</y>
      <z>5</z>
    </Scale>
      <Link>
        <href>https://raw.githubusercontent.com/raghavdeva/Lg_visualization_images/refs/heads/main/model/uploads_files_1825551_Rocket.dae</href>
      </Link>
    </Model>
  </Placemark>
</kml>
''';
}