import 'dart:collection';
import 'dart:ui';

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

class Util {
  String fileURL;
  static final Util _instance = Util._internal();
  // dog videos
  Map<String, dynamic> dogcaretips;
  Map<String, dynamic> doggeneralhealth;
  Map<String, dynamic> trainingdogvideos;
  Map<String, dynamic> funnydogvideos;
  Map<String, dynamic> trickdogvideos;
  // cat videos
  Map<String, dynamic> catcaretips;
  Map<String, dynamic> generalhealthcatvideos;
  Map<String, dynamic> cathelpfulinfo;
  Map<String, dynamic> catnutritionalinfo;

  clearArrays() {
    // dog videos
    dogcaretips = Map<String, dynamic>();
    doggeneralhealth = Map<String, dynamic>();
    trainingdogvideos = Map<String, dynamic>();
    funnydogvideos = Map<String, dynamic>();
    trickdogvideos = Map<String, dynamic>();
    // cat videos
    catcaretips = Map<String, dynamic>();
    generalhealthcatvideos = Map<String, dynamic>();
    cathelpfulinfo = Map<String, dynamic>();
    catnutritionalinfo = Map<String, dynamic>();
  }

  Util() {
    dogcaretips = LinkedHashMap<String, dynamic>();
    doggeneralhealth = LinkedHashMap<String, dynamic>();
    trainingdogvideos = LinkedHashMap<String, dynamic>();
    funnydogvideos = LinkedHashMap<String, dynamic>();
    trickdogvideos = LinkedHashMap<String, dynamic>();

    catcaretips = LinkedHashMap<String, dynamic>();
    generalhealthcatvideos = LinkedHashMap<String, dynamic>();
    cathelpfulinfo = LinkedHashMap<String, dynamic>();
    catnutritionalinfo = LinkedHashMap<String, dynamic>();
  }

  Util.fromJson(Map<String, dynamic> json)
      : dogcaretips = json['dogcaretips'],
        doggeneralhealth = json['doggeneralhealth'],
        trainingdogvideos = json['trainingdogvideos'],
        funnydogvideos = json['funnydogvideos'],
        trickdogvideos = json['trickdogvideos'],
        catcaretips = json['catcaretips'],
        generalhealthcatvideos = json['generalhealthcatvideos'],
        cathelpfulinfo = json['cathelpfulinfo'],
        catnutritionalinfo = json['catnutritionalinfo'];

  Map<String, dynamic> toJson() => {
        'dogcaretips': dogcaretips,
        'doggeneralhealth': doggeneralhealth,
        'trainingdogvideos': trainingdogvideos,
        'funnydogvideos': funnydogvideos,
        'trickdogvideos': trickdogvideos,
        'catcaretips': catcaretips,
        'generalhealthcatvideos': generalhealthcatvideos,
        'cathelpfulinfo': cathelpfulinfo,
        'catnutritionalinfo': catnutritionalinfo,
      };

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
}
