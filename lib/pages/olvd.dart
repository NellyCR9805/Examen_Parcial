import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pc/util/constants.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  bool _isLoading = false;
  var datosUsuario;

  final TextEditingController usuarioController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();


  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Usuario',
              style: kLabelStyle,
            ),
          ),
          SizedBox(height: 15.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: TextFormField(
              controller: usuarioController,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(4.0),
                hintText: ' Usuario ',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
          SizedBox(height: 30.0),
          //CONTRASEÑAAA
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Email',
              style: kLabelStyle,
            ),
          ),
          SizedBox(height: 15.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: TextFormField(
              controller: emailController,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(4.0),
                hintText: ' Email',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }



  Container _buildInicioBtn() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
      alignment: Alignment.center,
      child: FlatButton(
        onPressed: () {
          Navigator.pop(context);
          //Navigator.pushNamed(context, "/loginpage ");
        },
        padding: EdgeInsets.only(right: 11.0),
        child: Text(
          'Quiero iniciar sesión',
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

 




  recuperar(String usuario, String email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonResponse;
    var response = await http.get(
        "https://sigapdev2-consultarecibos-back.herokuapp.com/usuario/alumnoprograma/cambiar/" +
            email +
            "/" +
            usuario);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });

        print(jsonResponse);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Contraseña restablecida"),
              content: new Text(""),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          },
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Algo salió mal!"),
            content: new Text(
                "Tu usuario o email incorrectos. Vuelve a intentarlo."),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
  }

//h

  Container _buildRecuperarBtn() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 23.0),
      margin: EdgeInsets.all(15.0),
      child: RaisedButton(
        onPressed: usuarioController.text == "" || emailController.text == ""
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });
                recuperar(usuarioController.text, emailController.text);
              },
        elevation: 5.0,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'RECUPERAR',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

//ENCABEZADO

  Container _headerSection() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text(
        'Recuperar Contraseña',
        style: TextStyle(
            color: Colors.white70,
            fontFamily: 'OpenSans',
            fontSize: 30.0,
            fontWeight: FontWeight.w700),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          //Stack(
          //children: <Widget>[
          Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF73AEF5),
             Color(0xFF61A4F1),
            Color(0xFF478DE0),
            Color(0xFF398AE5),
            ],
            stops: [0.1, 0.4, 0.7, 0.9],
          ),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  _headerSection(),
                  textSection(),
                  _buildRecuperarBtn(),
                  _buildInicioBtn(),
                 
                ],
              ),
      ),
    );
  }
}
