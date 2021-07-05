class Uyeler{
  int uyeTcDegisken;
  String uyeIsimDegisken;
  String uyePassDegisken;
  String uyeAdresDegisken;
  int uyeDurumDegisken;
  int uyeYetkiDegisken;
  String key;

  Uyeler(this.uyeTcDegisken,this.uyeIsimDegisken,this.uyePassDegisken,this.uyeAdresDegisken,this.uyeDurumDegisken,this.uyeYetkiDegisken,this.key);

  factory Uyeler.fromJson(Map<dynamic, dynamic> json){
    return Uyeler(json["uye_tc"], json["uye_isim"],json["uye_pass"], json["uye_adres"], json["uye_durum"], json["uye_yetki"],"");
  }
}