import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
String resultado = "Retorno da consulta";

TextEditingController txtcep = TextEditingController();
void buscacep() async {
String cep = txtcep.text;

String url = "https://viacep.com.br/ws/$cep/json/";

http.Response response;

response = await http.get(Uri.parse(url));

Map<String, dynamic> dados = json.decode(response.body);

String logradouro =dados["logradouro"];
String complemento =dados["complemento"];
String bairro =dados["bairro"];
String localidade =dados["localidade"];

String endereco = "O Cep buscado é : $logradouro, $complemento, $bairro, $localidade ";

setState(() {
  resultado = endereco;
});
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consulta CEP"),
        backgroundColor: Colors.white,
      ),

body: Container(
  padding: EdgeInsets.all(50),
  child: Center(
    child: Column(
      children: <Widget>[
      TextField(
        keyboardType: TextInputType.number,
        decoration:InputDecoration(
          labelText: "Digite o CEP"
        ),
        style: TextStyle(fontSize: 16,color:Colors.blueAccent),
      ),

      ElevatedButton(
        child: Text("Consultar"),
        onPressed: buscacep,
      ),
      Text(resultado)

      ],
    ),
  ),
),
    
    );
  }
}