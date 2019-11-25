import 'package:firebase_database/firebase_database.dart';
import 'package:slice_game/firebase/records.dart';
import 'package:slice_game/pages/player_profile_page.dart';
//import 'package:sortedmap/sortedmap.dart';


class Server {
  static const _GAME_SCORES = 'game_scores';
  
  static List<Records> highScores = [];

  static init() async {}

  static Future<void> addScore(int score) async {
    String name;
    const debug = 'Server.addScore(): ';
    print('$debug Invoked.');
    var ref = FirebaseDatabase.instance.reference().child(_GAME_SCORES);
    //name check
    if(myController.text == ""){
      name = "Not Entered";
    }else{
      name = myController.text;
    }
    ref.push().update({
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'score': score,
      'name': name,
    });
    var snap =
        await FirebaseDatabase.instance.reference().child(_GAME_SCORES).once();
    Map val = snap?.value;
    //print('$debug val = $val');
    val?.forEach((key, mapData) => print('$debug ${mapData['score']}'));
    print('$debug Completed.');
  }

  static Future<List<Records>> getHighScores(Function setState) async {
    List<Records> fullList = [];
    var snap =
        await FirebaseDatabase.instance.reference().child(_GAME_SCORES).once();
    //var val = new SortedMap((Pair a, Pair b)=>Comparable.comp)
    //print(snap);
    Map val = snap?.value;
   
    val?.forEach((key, data){
      var myRec = new Records(data['score'], data['name']);
      fullList.add(myRec);
    });
    fullList.sort((a, b) => a.mySort(a,b) ? 1 : -1);
    print("my list $fullList");

    setState(() => Server.highScores = fullList ?? []);
    return fullList ?? [];
  }
}
