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
  String _statusUpload = "Upload não iniciado";
  String _urlImagemRecuperada = null;

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
    StorageUploadTask task = arquivo.putFile(_imagem);

    //Controlar progresso do upload
    task.events.listen((StorageTaskEvent storageEvent){
      if(storageEvent.type == StorageTaskEventType.progress){
        setState(() {
          _statusUpload = "Em progresso";
        });
      } else if(storageEvent.type == StorageTaskEventType.success){
        setState(() {
          _statusUpload = "Upload realizado com sucesso!";
        });
      }
    });

    Future _recuperarUrlImagem(StorageTaskSnapshot snapshot) async {
      String url = await snapshot.ref.getDownloadURL();
      print("resultado url: " + url);

      setState(() {
        _urlImagemRecuperada = url;
      });
    }

    //Recuperar url da imagem
    task.onComplete.then((StorageTaskSnapshot snapshot){
      _recuperarUrlImagem(snapshot);
    });


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
            Text(_statusUpload),
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
            _imagem == null
                ? Container()
                : RaisedButton(
                  child: Text("Upload Storage"),
                  onPressed: (){
                    _uploadImagem();
                  },
                ),
            _urlImagemRecuperada == null
            ? Container()
                : Image.network(_urlImagemRecuperada)
          ],
        ),
      ),
    );
  }
}

