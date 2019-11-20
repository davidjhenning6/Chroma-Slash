import 'package:firebase_database/firebase_database.dart';

class Server {
  static const _GAME_SCORES = 'game_scores';
  static List<int> highScores = [];

  static init() async {}

  static Future<void> addScore(int score) async {
    const debug = 'Server.addScore(): ';
    print('$debug Invoked.');
    var ref = FirebaseDatabase.instance.reference().child(_GAME_SCORES);
    ref.push().update({
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'score': score,
    });
    var snap =
        await FirebaseDatabase.instance.reference().child(_GAME_SCORES).once();
    Map val = snap?.value;
    print('$debug val = $val');
    val?.forEach((key, mapData) => print('$debug ${mapData['score']}'));
    print('$debug Completed.');
  }

  static Future<List<int>> getHighScores(Function setState) async {
    List<int> tempList = [];
    var snap =
        await FirebaseDatabase.instance.reference().child(_GAME_SCORES).once();
    Map val = snap?.value;
    val?.forEach((key, data) => tempList.add(data['score']));
    tempList.sort((a, b) => a < b ? 1 : -1);
    // val?.forEach((key, mapData) => print('${mapData['score']}'));
    setState(() => Server.highScores = tempList ?? []);
    return tempList ?? [];
  }
}
