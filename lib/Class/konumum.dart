class Konumum{
  double lat;
  double lon;

Konumum(this.lat,this.lon);

  factory Konumum.fromJson(Map<dynamic, dynamic> json){
    return Konumum(json["uye_durak_lat"], json["uye_durak_lon"]);
  }
}