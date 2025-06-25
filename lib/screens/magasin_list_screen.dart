import 'package:flutter/material.dart';
import '../services/api_magasin.dart';
import '../models/magasin.dart';
import 'magasin_form_screen.dart';

class MagasinListScreen extends StatefulWidget {
  @override
  _MagasinListScreenState createState() => _MagasinListScreenState();
}

class _MagasinListScreenState extends State<MagasinListScreen> {
  late Future<List<Magasin>> _magasins;

  @override
  void initState() {
    super.initState();
    _magasins = ApiMagasin.fetchMagasins();
  }

  void _refresh() {
    setState(() {
      _magasins = ApiMagasin.fetchMagasins();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Magasins")),
      body: FutureBuilder<List<Magasin>>(
        future: _magasins,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final magasins = snapshot.data!;
            return ListView.builder(
              itemCount: magasins.length,
              itemBuilder: (context, index) {
                final mag = magasins[index];
                return ListTile(
                  title: Text(mag.nomMag),
                 subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Adresse: ${mag.adresseMag}"),
                      Text("Téléphone: ${mag.telMag}"),
                      Text("Code: ${mag.codeMag}"),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(icon: Icon(Icons.edit), onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MagasinFormScreen(magasin: mag),
                          ),
                        );
                        _refresh();
                      }),
                      IconButton(icon: Icon(Icons.delete), onPressed: () async {
                        await ApiMagasin.supprimerMagasin(mag.codeMag);
                        _refresh();
                      }),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => MagasinFormScreen()),
          );
          _refresh();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
