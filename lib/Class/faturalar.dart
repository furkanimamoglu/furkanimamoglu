class Faturalar{
  int faturaID;
  int faturaTc;
  String faturaDurum;
  int faturaMiktar;
  String key;

  Faturalar(this.faturaID,this.faturaTc,this.faturaDurum,this.faturaMiktar,this.key);

  factory Faturalar.fromJson(Map<dynamic, dynamic> json){
    return Faturalar(json["uye_fatura_id"],json["uye_fatura_tc"], json["uye_fatura_durum"],json["uye_fatura_miktar"],"");
  }

  Faturalar addKey(String key){
    this.key=key;
    return this;
  }

}