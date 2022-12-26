import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

enum authMethod {
  Login,
  Signup,
}

class AuthenticationScreen extends StatefulWidget {
  AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _formState = GlobalKey<FormState>();
  var selectedAuthMethod = authMethod.Login;
  bool _isPass = true;
  bool _isLoading=false;
  Map<String,String> _authData={
    'email':'',
    'password':''
  };
  void userAuth() async{
    _formState.currentState!.save();
    setState(() {
      _isLoading=true;
    });
    try{
      if(selectedAuthMethod==authMethod.Login){
        await Provider.of<Auth>(context,listen: false).login(_authData['email']!, _authData['password']!);
      }
      else {
        await Provider.of<Auth>(context,listen: false).signUp(_authData['email']!, _authData['password']!);
      }
    }
    catch(error){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
    }

    setState(() {
      _isLoading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.red],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26, spreadRadius: 5, blurRadius: 20)
                ]),
            width: screenSize.width * 0.8,
            height: selectedAuthMethod == authMethod.Login
                ? screenSize.height * 0.45
                : screenSize.height * 0.55,
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Form(
                key: _formState,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "My Shop",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      onSaved: (value){
                        _authData['email']=value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "*Required";
                        }
                        if(!value.contains('@')){
                          return "Invalid email";
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                    ),
                    TextFormField(
                      onSaved: (value){
                        _authData['password']=value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "*Required";
                        }
                      },
                      obscureText: _isPass,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPass = !_isPass;
                            });
                          },
                          icon: _isPass
                              ? Icon(Icons.remove_red_eye)
                              : Icon(Icons.remove_red_eye_outlined),
                        ),
                        hintText: "Password",

                      ),
                    ),
                    if (selectedAuthMethod == authMethod.Signup)
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "*Required";
                          }
                        },
                        obscureText: _isPass,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPass = !_isPass;
                              });
                            },
                            icon: _isPass
                                ? Icon(Icons.remove_red_eye)
                                : Icon(Icons.remove_red_eye_outlined),
                          ),
                          hintText: "Confirm password",
                        ),
                      ),
                    Column(
                      children: [
                        _isLoading?const CircularProgressIndicator():AuthenticationButton(
                          label: selectedAuthMethod == authMethod.Signup?"Signup":"Login",
                          onPressed: () {
                            if (!_formState.currentState!.validate());
                            else {
                              userAuth();
                            }
                          },
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        AuthenticationButton(
                          label: selectedAuthMethod == authMethod.Signup?"Login":"Signup",
                          onPressed: () {
                            setState(() {
                              selectedAuthMethod=selectedAuthMethod == authMethod.Signup?authMethod.Login:authMethod.Signup;
                              _formState.currentState!.reset();
                            });
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AuthenticationButton extends StatelessWidget {
  final String label;
  final Function()? onPressed;

  const AuthenticationButton({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.blue),
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
