import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/magasin.dart';

class ApiMagasin {
  static const baseUrl = 'http://localhost/cc_mobile_magasin/controller/magasin';

  static Future<List<Magasin>> fetchMagasins() async {
    final response = await http.get(Uri.parse('$baseUrl/getMagasins.php?host=localhost&dbname=crudmagasinmobile&username=root&password='));
    if (response.statusCode == 200) {
      List jsonList = json.decode(response.body);
      return jsonList.map((e) => Magasin.fromJson(e)).toList();
    } else {
      throw Exception('Erreur chargement');
    }
  }

  static Future<bool> ajouterMagasin(Magasin magasin) async {
    final response = await http.post(
      Uri.parse('$baseUrl/createmagasin.php?host=localhost&dbname=crudmagasinmobile&username=root&password='),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(magasin.toJson()),
    );
    return response.statusCode == 201;
  }

  static Future<bool> modifierMagasin(Magasin magasin) async {
    final response = await http.put(
      Uri.parse('$baseUrl/updateMagasin.php?host=localhost&dbname=crudmagasinmobile&username=root&password='),
      headers: {'Content-Type': 'application/json'},
      body: json.encode( {
        "codeMag": magasin.codeMag,
        "nomMag": magasin.nomMag,
      "adresseMag": magasin.adresseMag,
      "telMag": magasin.telMag
        }),
    );
    return response.statusCode == 200;
  }

  static Future<bool> supprimerMagasin(String codeMag) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/supprimerVirtuellement.php?host=localhost&dbname=crudmagasinmobile&username=root&password='),
       headers: {'Content-Type': 'application/json'},
      body: json.encode( {"codeMag": codeMag}),
    );
    return response.statusCode == 200;
  }
}
