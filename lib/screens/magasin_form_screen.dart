import 'package:flutter/material.dart';
import '../models/magasin.dart';
import '../services/api_magasin.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MagasinFormScreen extends StatefulWidget {
  final Magasin? magasin;
  const MagasinFormScreen({this.magasin});

  @override
  _MagasinFormScreenState createState() => _MagasinFormScreenState();
}

class _MagasinFormScreenState extends State<MagasinFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController codeC, nomC, adresseC, telC;

  @override
  void initState() {
    super.initState();
    codeC = TextEditingController(text: widget.magasin?.codeMag ?? '');
    nomC = TextEditingController(text: widget.magasin?.nomMag ?? '');
    adresseC = TextEditingController(text: widget.magasin?.adresseMag ?? '');
    telC = TextEditingController(text: widget.magasin?.telMag ?? '');
  }

  @override
  void dispose() {
    codeC.dispose();
    nomC.dispose();
    adresseC.dispose();
    telC.dispose();
    super.dispose();
  }

  void _enregistrer() async {
    if (_formKey.currentState!.validate()) {
      Magasin m = Magasin(
        codeMag: codeC.text,
        nomMag: nomC.text,
        adresseMag: adresseC.text,
        telMag: telC.text,
      );

      bool result = widget.magasin == null
          ? await ApiMagasin.ajouterMagasin(m)
          : await ApiMagasin.modifierMagasin(m);

      Fluttertoast.showToast(
        msg: result ? "Opération réussie" : "Échec de l’opération",
        gravity: ToastGravity.BOTTOM,
      );

      if (result) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.magasin == null ? "Ajouter Magasin" : "Modifier Magasin")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: codeC,
              decoration: InputDecoration(labelText: "Code Magasin"),
              validator: (val) => val!.isEmpty ? 'Champ requis' : null,
            ),
            TextFormField(
              controller: nomC,
              decoration: InputDecoration(labelText: "Nom Magasin"),
              validator: (val) => val!.isEmpty ? 'Champ requis' : null,
            ),
            TextFormField(
              controller: adresseC,
              decoration: InputDecoration(labelText: "Adresse"),
              validator: (val) => val!.isEmpty ? 'Champ requis' : null,
            ),
            TextFormField(
              controller: telC,
              decoration: InputDecoration(labelText: "Téléphone"),
              keyboardType: TextInputType.phone,
              validator: (val) => val!.isEmpty ? 'Champ requis' : null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _enregistrer,
              child: Text("Enregistrer"),
            )
          ]),
        ),
      ),
    );
  }
}
