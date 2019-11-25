class Records{
  int score;
  String name;
  //String key;

  Records( this.score, this.name);

  mySort(Records recA, Records recB){
    if(recA.score < recB.score){
      return true;
    }else{
      return false;
    }
  }

  @override
  String toString() {
    String str = " record: $name $score";
    return str;
  }
    

}