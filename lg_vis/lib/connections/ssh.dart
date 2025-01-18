

import 'dart:async';
import 'dart:io';
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import '../kml/kml_entity.dart';
import '../kml/logo_kml.dart';
import '../kml/look_at.dart';
import 'dart:convert';
import 'dart:typed_data';


class SSH {
  late String _host;
  late String _port;
  late String _username;
  late String _passwordOrKey;
  late String _numberOfRigs;
  SSHClient? _client;

  // FileCreate get _filecreate => GetIt.I<FileCreate>();

  // To Initialize connection details from shared preferences
  Future<void> initConnectionDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _host = prefs.getString('ipAddress') ?? 'default_host';
    _port = prefs.getString('sshPort') ?? '22';
    _username = prefs.getString('username') ?? 'lg';
    _passwordOrKey = prefs.getString('password') ?? 'lg';
    _numberOfRigs = prefs.getString('numberOfRigs') ?? '3';
  }

  // To Connect to the Liquid Galaxy system
  Future<bool?> connectToLG() async {
    await initConnectionDetails();

    try {
      final socket = await SSHSocket.connect(_host, int.parse(_port));

      _client = SSHClient(socket,
          username: _username,
          onPasswordRequest: () => _passwordOrKey);
      return true;
    } on SocketException catch (e) {
      print('Failed to connect: $e');
      return false;
    }
  }

  // To excute any command
  Future<SSHSession?> execute() async {
    try {
      if (_client == null) {
        print('SSH client is not initialized.');
        return null;
      }
      final session = await _client!.execute('echo "search=Spain" > /tmp/query.txt');
      print("Excution okay");
      return session;
    } catch (e) {
      print('An error occurred while executing the command: $e');
      return null;
    }
  }

  // To show logo in the slave machine
  Future<void> showLogo() async{
    try {
      if (_client == null) {
        print('SSH client is not initialized.');
        return null;
      }
      int rigs = 3;
      String logo = LogoKml().openLogoKML;
      await _client?.execute("echo '$logo' > /var/www/html/kml/slave_3.kml");
      print("Kml uploaded");
    } catch (error) {
      print("An error has occured while excuting the command : $error");
      return null;
    }
  }


  // To shut down Liquid Galaxy
  Future<void> shutdownLG() async {

    if(_client == null){
      print("SSH is not initialized");
      return null;
    }
    try {
      for(int i = int.parse(_numberOfRigs); i>=1;i--) {
        await _client!.execute(
            'sshpass -p $_passwordOrKey ssh -t lg$i "echo $_passwordOrKey | sudo -S poweroff"');
      }
      return null;
    } catch (error) {
      print("An error has occured while excuting the command : $error");
      return null;
    }
  }


  // Demo command
  Future<void> searchPlace(String? place) async{
    if(_client == null){
      print("SSH is not initialized");
      return null;
    }

    try{

      await _client!.execute('echo "search=$place" > /tmp/query.txt');
      return null;
    }catch(error){
      print("Error occured while executing the command : $error");
      return null;
    }
  }



  //To Send the kml to Liquid Galaxy
  Future<void> uploadKmlAndAssets(String kmlContent, String kmlName) async {
    // To Create directory for KMLs
    await _client!.run('mkdir -p /var/www/html/kmls');
    print('Directory created or already exists.');
    print(kmlContent);


    // To Upload the KML file
    final sftp = await _client!.sftp();
    final kmlFile = await sftp.open(
      '/var/www/html/kmls/${kmlName}.kml',
      mode: SftpFileOpenMode.truncate | SftpFileOpenMode.create | SftpFileOpenMode.write,
    );

    // To Write the KML content
    final kmlStream = Stream.fromIterable([Uint8List.fromList(utf8.encode(kmlContent))]);
    print(kmlStream);
    await kmlFile.write(kmlStream);
    await kmlFile.close();
    print('KML file uploaded.');

    //Step 3: Upload the associated image
    // final imageBytes = await loadImageAsset();
    // final sftpFile = await sftp.open(
    //   '/var/www/html/kmls/india_overlay.png',
    //   mode: SftpFileOpenMode.create | SftpFileOpenMode.write,
    // );
    // final imageStream = Stream.fromIterable([imageBytes]);
    // await sftpFile.write(imageStream);
    // await sftpFile.close();
    //print('Image uploaded.');

    print('Upload complete.');
  }

  //To display the file on Liquid Galaxy
  Future<void> displayKmlOnLiquidGalaxy(String kmlUrl) async {
    print(kmlUrl);
    await _client!.execute('echo "$kmlUrl" > /var/www/html/kmls.txt');
    print('KML URL added to query.txt.');
  }



  // To run a Query for Lg
  Future<void> query(String content) async {
    await _client!.execute('echo "$content" > /tmp/query.txt');
  }

  // Look at in LG
  Future<void> flyTo(LookAt lookAt) async {
    await query('flytoview=${lookAt.linearTag}');
  }


  //Clear kml file in lg
  Future<void> clearKml({bool keepLogos = true}) async {
    String query =
        'echo "exittour=true" > /tmp/query.txt && > /var/www/html/kmls.txt';

    for (var i = 2; i <= int.parse(_numberOfRigs); i++) {
      String blankKml = KMLEntity.generateBlank('slave_$i');
      query += " && echo '$blankKml' > /var/www/html/kml/slave_$i.kml";
    }
    await _client!.execute(query);

    if(keepLogos){
      await showLogo();
      }

  }


// Loading KML files
// Future<Uint8List> loadImageAsset() async {
//   final ByteData data = await rootBundle.load('assets/image/india_overlay.png');
//   return data.buffer.asUint8List();
// }


// Another method to send kml
// Future<void> sendKml(String content, String kmlName) async{
//   String fileName = '${kmlName}.kml';
//   await clearKml(keepLogos: true);
//   File? kmlFile = await makeFile(fileName, content);
//   print(content);
//   await uploadKml(kmlFile!, fileName);
//   var no = await _client?.execute('echo "http://lg1:81/${fileName}" > /tmp/query.txt');
//   print(no);
//   print("Kml Sent from the function");
// }

// To upload KML to the liquid galaxy
// Future<void> uploadKml(File inputFile, String filename) async {
//   final sftp = await _client?.sftp();
//   // ignore: unused_local_variable
//   double anyKindofProgressBar;
//   final file = await sftp?.open('/var/www/html/$filename',
//       mode: SftpFileOpenMode.create |
//       SftpFileOpenMode.truncate |
//       SftpFileOpenMode.write);
//   var fileSize = await inputFile.length();
//   print(fileSize);
//   await file?.write(inputFile.openRead().cast(), onProgress: (progress) {
//     anyKindofProgressBar = progress / fileSize;
//     print(anyKindofProgressBar);
//   });
//   print("KML Upload Complete");
// }

// To make a file for kml
// Future<File?> makeFile(String filename, String content) async {
//   try {
//     var localPath = await getApplicationDocumentsDirectory();
//     print(localPath.path.toString());
//     String sanitizedFilename = filename.replaceAll(' ', '_');
//     File localFile = File('${localPath.path}/$sanitizedFilename.kml');
//     await localFile.writeAsString(content);
//     return localFile;
//   } catch (e) {
//     print("Error making the file");
//     return null;
//   }
// }
}
