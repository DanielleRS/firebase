import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  File _imagem;

  Future _recuperarImagem(bool daCamera) async {
    File imagemSelecionada;

    if(daCamera){ //camera
      imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.camera);
    } else { //galeria
      imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      _imagem = imagemSelecionada;
    });
  }

  Future _uploadImagem() async {
    //Referenciar arquivo
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference pastaRaiz = storage.ref();
    StorageReference arquivo = pastaRaiz.child("fotos").child("foto1.jpg");

    //Fazer upload da imagem
    arquivo.putFile(_imagem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecionar imagem"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Camera"),
              onPressed: (){
                _recuperarImagem(true);
              },
            ),
            RaisedButton(
              child: Text("Galeria"),
              onPressed: (){
                _recuperarImagem(false);
              },
            ),
            _imagem == null
            ? Container()
                : Image.file(_imagem),
            RaisedButton(
              child: Text("Upload Storage"),
              onPressed: (){
                _uploadImagem();
              },
            ),
          ],
        ),
      ),
    );
  }
}

