class Mesajlar{
  int mesajID;
  String mesajAliciTC;
  String mesajGonderenTC;
  String mesajIcerik;
  String mesajResim;
  String key;

  Mesajlar(this.mesajID,this.mesajAliciTC,this.mesajGonderenTC,this.mesajIcerik,this.mesajResim,this.key);

  factory Mesajlar.fromJson(Map<dynamic, dynamic> json){
    return Mesajlar(json["mesaj_id"],json["mesaj_alicitc"],json["mesaj_gonderentc"], json["mesaj_icerik"],json["mesaj_resim"],"");
  }

  Mesajlar addKey(String key){
    this.key=key;
    return this;
  }

}