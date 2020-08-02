import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:pc/pages/login_page.dart';
import 'login_page.dart';
//import 'package:shared_preferences/shared_preferences.dart';


class AlumnoPage extends StatefulWidget {
  final Map jsonResponse;

 AlumnoPage({Key key, this.jsonResponse}) : super(key: key);
  _AlumnoPageState createState() => _AlumnoPageState(jsonResponse);

  
}
class _AlumnoPageState extends State<AlumnoPage> {
  Map jsonResponse;
  _AlumnoPageState(this.jsonResponse);
  @override

  List data;
  List userData;
  String cod;
  getData(String apePaterno, String  codAlumno) async {
    http.Response response = await http.get(
        "https://sigapdev2-consultarecibos-back.herokuapp.com/recaudaciones/alumno/concepto/listar_codigoslog/"+
            apePaterno +
            "/" +
            codAlumno);

    data = json.decode(response.body);
    setState(() {
      userData = data;
    });
     }


Widget _buildUsuario() {
    return Column();


 }
 Widget _buildPagosBtn(){
   return Container(
      padding: EdgeInsets.symmetric(vertical: 55.0),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {
                 
                  Navigator.pushNamed(context, "/listapage");
                },
        
        elevation: 5.0,
       
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Ver Pagos',
          style: TextStyle( 
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
 }

  Widget build(BuildContext context) {
       return new Scaffold(
      appBar: AppBar(title: Text("  "),
      actions: <Widget>[
          FlatButton(
           onPressed: () {
            /*   sharedPreferences.clear();
              sharedPreferences.commit();*/
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
            
            },
            child: Text("Log Out", style: TextStyle(color: Colors.white)),
          ),
        ],
         
         ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 50.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Bienvenido',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 40.0),
                     // _buildUsuario(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPagosBtn(),
                    
                      
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
 
 
  }


  }