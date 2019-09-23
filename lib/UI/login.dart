import 'dart:convert';
import 'package:flip_card/flip_card.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'home.dart';

class Login extends StatefulWidget {
  final GlobalKey<FlipCardState> passwedKey;
  
  Login(this.passwedKey);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email;
  String password;

  List data;

  var currentUser;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  
  final _formKey = GlobalKey<FormState>(); 
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        
        children: <Widget>[
          Opacity(
              opacity: 1,
              child: Image.asset(
                "assets/images/pic3.jpg",
                fit: BoxFit.cover,
                )
              ),
          ListView(
            children: <Widget>[
              Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(
              child: Form(
                key: _formKey,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.withOpacity(0.3),
                      child: Icon(Icons.dashboard,size: 70,color: Colors.white,),
                    ),
                    Padding(padding: EdgeInsets.all(8),),
                    Text(
                      'WELCOME BACK LOGIN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                      ),
                    Padding(padding: EdgeInsets.all(8),),

                    TextFormField(
                      validator: (value){
                          if(value.isEmpty){
                            return 'Please enter a valid email';
                          }
                          return null;
                      },
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                          color: Colors.white,
                      ),
                      decoration:InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey.withOpacity(0.3),
                        labelText: "Email",
                        labelStyle: TextStyle(
                          color: Colors.blueGrey
                        ),
                        prefixIcon: Icon(Icons.email,color: Colors.blueGrey,),
                        border:  OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        )
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(8),),
                    TextFormField(
                          validator: (value){
                          if(value.isEmpty){
                            return "This Field can't be blank";
                          }
                          return null;
                      },
                      controller: _passwordController,
                      obscureText: true,
                      style: TextStyle(
                          color: Colors.white,
                      ),
                      decoration:InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey.withOpacity(0.3),
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Colors.blueGrey
                        ),
                        prefixIcon: Icon(Icons.lock,color: Colors.blueGrey,),
                        border:  OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        )
                      ),
                    ),
                                   
                    Padding(padding: EdgeInsets.all(8),),
                    MaterialButton(
                      color: Colors.green[700],
                      elevation: 8.0,
                      onPressed: (){
                        if (_formKey.currentState.validate()) {
                          _loginUser().then((value){
                            if (value.length != 0) {
                              if(value[0]['e_mail'] == _emailController.text){
                                if(value[0]['password'] == _passwordController.text){
                                  setState(() {
                                  currentUser = value;
                                  }); 
                                  Navigator.pushReplacement
                                  (context, MaterialPageRoute(
                                  builder: (context)=>Home(user: currentUser),
                                  ),
                                  );
                                }else{
                                  _showMyAlert('Invalide password', 'the password you enter does not match');
                                }
                              }
                            }else{
                              _showMyAlert('Invalide user', 'the e-mail you entered is not registered');
                            }
                          });
                        }
                      },
                      child: Text(
                        'Login Now',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                        color: Colors.white,
                        ),
                      ),
                      ),
                    MaterialButton(
                      onPressed: (){
                        widget.passwedKey.currentState.toggleCard();
                        // Navigator.pushReplacementNamed(context, '/register');
                      },
                      child: Text(
                        "Don't have Account !" ,
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline
                          ),
                        ),
                    ),
                  ],
                ),
              ),
            ),
        ),
        ],
        ),
      ],
    ),
  );
}

Future<void> _showMyAlert(String value,String content) async{
  await showDialog(
    context: context,
    builder: (BuildContext context){
        return SimpleDialog(
      contentPadding: EdgeInsets.all(8.0),
      title: Center(
        child: Text(
          value,
          style: TextStyle(
            color: Colors.red
          ),
          ),
      ),
      children: <Widget>[
        Center(child: Text(content)),
        Padding(padding: EdgeInsets.all(8.0),)
      ],  
    );
    }
  );
}
                  
Future<List> _loginUser() async{
    email = _emailController.text;
    var url = "https://thecoder.online/get.php?table=users&email=$email";
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data;
  }
}
