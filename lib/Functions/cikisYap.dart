import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

  cikisYap() async {
    var sp = await SharedPreferences.getInstance();
    sp.remove("girisyapildipref");
    sp.remove("girisyapankullanicipref");
    sp.remove("sohbetkisi");
    SystemNavigator.pop();
  }