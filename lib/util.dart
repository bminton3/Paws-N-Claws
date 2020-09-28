import 'dart:ui';

import 'base_video_player.dart';
import 'download_helper.dart';

// top bar color across app
const AppBarColor = const Color(0xFFF3BD40);
//
List<String> pawsLocations = <String>['vet', 'humaneSociety'];

enum PawsLocations { Vet, HumaneSociety }

enum pettypes { dog, cat, other }

final List<String> pets = [
  'assets/dogbuttonresized.png',
  'assets/catbutton.png',
  'assets/otherbutton.png'
];
final List<String> humanebuttons = [
  'assets/dogbuttonresized.png',
  'assets/catbutton.png',
  'assets/rescuebutton.png'
];

var dir;

//List<PawsVideo> dogcaretips = [
//  //PawsVideo('Get Out of Vehicle', 'assets/videos/dog/Dogcar.mp4', 'assets/AllStar.PNG'),
//];
//List<PawsVideo> generalHealthDogVideos = [];
//List<PawsVideo> trainingDogVideos = [];
//List<PawsVideo> tricksDogVideos = [];

/// Dart singleton. I forget what this is used for
class Util {
  String fileURL;
  static final Util _instance = Util._internal();
  String get URL => fileURL;
  static Map<String, Util> _cache;
  List<PawsVideo> dogcaretips = [];
  List<PawsVideo> generalhealthdogvideos = [];
  List<PawsVideo> trainingdogvideos = [];
  List<PawsVideo> funnydogvideos = [];
  List<PawsVideo> trickdogvideos = [];
  DownloadHelper downloadHelper;

  factory Util() {
    return _instance;
  }

//  factory Util(String URL) {
//    if(_cache == null) {
//      _cache = new Map<String,Util>();
//    }
//    if(_cache[URL] == null]) {
//      _cache[URL] = new Util._internal(URL);
//    }
//    return _cache[URL];
//  }

  Util._internal();

  void setURL(String url) {
    this.fileURL = url;
  }
}
