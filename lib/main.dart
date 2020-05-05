import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Firestore db = Firestore.instance;

  var pesquisa = "an";
  QuerySnapshot querySnapshot = await db.collection("usuarios")
    //.where("nome", isEqualTo: "jamilton")
    //.where("idade", isEqualTo: 31)
    //.where("idade", isGreaterThan: 15)
    //.where("idade", isLessThan: 30)
    //.orderBy("idade", descending: true)
    //.orderBy("nome", descending: false)
    //.limit(1)

    .where("nome", isGreaterThanOrEqualTo: pesquisa)
    .where("nome", isLessThanOrEqualTo: pesquisa + "\uf8ff")
    .getDocuments();

  for(DocumentSnapshot item in querySnapshot.documents){
    var dados = item.data;
    print("filtro nome: ${dados["nome"]} idade: ${dados["idade"]}");
  }

  //Adicionar inserindo o código
  /*
  db.collection("usuarios")
    .document("002")
    .setData({
      "nome": "Ana Maria",
      "idade": "25"
    });*/

  //Adicionar gerando código automático
  /*
  DocumentReference ref = await db.collection("noticias")
  .add({
    "titulo": "Ondas de calor em São Paulo",
    "descricao": "texto de exemplo..."
  });*/

  //print("item salvo: " + ref.documentID);

  //Atualizar
  /*
  db.collection("noticias")
    .document("2HR83NA7Si5hUEubrbUf")
    .setData({
      "titulo": "Ondas de calor em São Paulo alterado",
      "descricao": "texto de exemplo..."
    });*/

  //Remover
  //db.collection("usuarios").document("003").delete();

  //Recuperar dados de um determinado usuário
  /*
  DocumentSnapshot snapshot = await db.collection("usuarios")
      .document("002")
      .get();

  var dados = snapshot.data;
  print("dados nome: " + dados["nome"] + " idade: " + dados["idade"]);
  */

  //Recuperar todos os dados de uma coleção
  /*
  QuerySnapshot querySnapshot = await db
      .collection("usuarios")
      .getDocuments();*/

  //print("dados usuarios: " + querySnapshot.documents.toString());

  /*
  for(DocumentSnapshot item in querySnapshot.documents) {
    var dados = item.data;
    print("dados usuarios: " + dados["nome"] +  " - " +  dados["idade"]);
  }*/

  //Recupera dados e notifica sempre que há mudança
  /*
  db.collection("usuarios").snapshots().listen(
      (snapshot){
        for(DocumentSnapshot item in snapshot.documents) {
          var dados = item.data;
          print("dados usuarios: " + dados["nome"] +  " - " +  dados["idade"]);
        }
      }
  );*/

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
