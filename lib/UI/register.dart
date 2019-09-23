import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class Register extends StatefulWidget {

  final GlobalKey<FlipCardState> passwedKey;

  Register(this.passwedKey);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email;
  String password;
  String userName;

  List data;

  var currentUser;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


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
                      child: Icon(Icons.dashboard,color: Colors.white,size: 70,),
                    ),
                    Padding(padding: EdgeInsets.all(8),),
                    Text(
                      'WELCOME',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                      ),
                    Padding(padding: EdgeInsets.all(8),),
                    TextFormField(
                      controller: _emailController,
                      validator: (value){
                          if(value.isEmpty){
                            return 'Please enter a valid email';
                          }
                          return null;
                      },
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
                      controller: _userNameController,
                      validator: (value){
                          if(value.isEmpty){
                            return 'Please enter a valid User Name';
                          }
                          return null;
                      },
                      style: TextStyle(
                          color: Colors.white,
                      ),
                      decoration:InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey.withOpacity(0.3),
                        labelText: "User Name",
                        labelStyle: TextStyle(
                          color: Colors.blueGrey
                        ),
                        prefixIcon: Icon(Icons.account_circle,color: Colors.blueGrey,),
                        border:  OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        )
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(8),),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value){
                          if(value.isEmpty){
                            return 'Please enter a password';
                          }
                          return null;
                      },
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
                          _checkUser().then((value){
                            print(value);
                              if (value == email) {
                                _showMyAlert("user error", "user already exist");
                              }else{
                                _registerUser().whenComplete((){
                                    Navigator.pushReplacement(
                                      context, 
                                      MaterialPageRoute(
                                          builder: (context)=>Home()
                                      )
                                    );
                                });
                              }
                          });
                        }
                      },
                        child: Text(
                          'Register',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          color: Colors.white,
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: (){
                          widget.passwedKey.currentState.toggleCard();
                          //Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text(
                          "Already have an account !" ,
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

                 
Future _registerUser() async{
    var now = DateTime.now();

    String registerDate = '${now.year}-${now.month}-${now.day}';
    userName = _userNameController.text;
    email = _emailController.text;
    password = _passwordController.text;

    var url = 'https://thecoder.online/insert.php?user='+userName+
    '&email='+email+
    '&password='+password+
    '&date='+registerDate;

    //http.Response response = 
    await http.get(url);

  }

  Future<String> _checkUser() async{
    email = _emailController.text;
    var url = "https://thecoder.online/check.php?table=users&email=$email";
    http.Response response = await http.get(url);
    var data = response.body;
    return data;
  }
}

