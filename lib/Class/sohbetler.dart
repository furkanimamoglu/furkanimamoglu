class Sohbetler{
  int sohbetTC;
  String sohbetIsim;
  String key;

  Sohbetler(this.sohbetTC,this.sohbetIsim,this.key);

  factory Sohbetler.fromJson(Map<dynamic, dynamic> json){
    return Sohbetler(json["sohbet_tc"],json["sohbet_isim"],"");
  }

  Sohbetler addKey(String key){
    this.key=key;
    return this;
  }

}