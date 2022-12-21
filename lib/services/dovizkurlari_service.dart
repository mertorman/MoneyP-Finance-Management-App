import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:moneyp/product/constant/constant.dart';
import 'package:moneyp/services/model/dovizkurlari_model.dart';

class DovizKurlariService {
  Future<List<DovizKurlariModel>> dovizKurGet() async {
    List<DovizKurlariModel> kurList = [];
    Response res = await http.get(Uri.parse(AppConstants.dovizApiUrl));
    Map<String, dynamic> veri = jsonDecode(res.body);

    DovizKurlariModel model = DovizKurlariModel(
        usdKur: veri["USD"]["satis"], eurKur: veri["EUR"]["satis"]);
    kurList.add(model);
    return kurList;
  }
}
