import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Firestore db = Firestore.instance;

  /*
  db.collection("usuarios")
    .document("002")
    .setData({
      "nome": "Ana Maria",
      "idade": "25"
    });*/

  /*
  DocumentReference ref = await db.collection("noticias")
  .add({
    "titulo": "Ondas de calor em São Paulo",
    "descricao": "texto de exemplo..."
  });*/

  //print("item salvo: " + ref.documentID);

  db.collection("noticias")
    .document("2HR83NA7Si5hUEubrbUf")
    .setData({
      "titulo": "Ondas de calor em São Paulo alterado",
      "descricao": "texto de exemplo..."
    });

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
