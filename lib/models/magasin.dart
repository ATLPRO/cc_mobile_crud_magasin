class Magasin {
  final String codeMag;
  final String nomMag;
  final String adresseMag;
  final String telMag;

  Magasin({required this.codeMag, required this.nomMag, required this.adresseMag, required this.telMag});

  factory Magasin.fromJson(Map<String, dynamic> json) {
    return Magasin(
      codeMag: json['codeMag'],
      nomMag: json['nomMag'],
      adresseMag: json['adresseMag'],
      telMag: json['telMag'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codeMag': codeMag,
      'nomMag': nomMag,
      'adresseMag': adresseMag,
      'telMag': telMag,
    };
  }
}
