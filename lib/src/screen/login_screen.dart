import 'package:chat_app/src/mixins/validation_mixin.dart';
import 'package:chat_app/src/services/authentication.dart';
import 'package:chat_app/src/widgets/app_error_message.dart';
import 'package:chat_app/src/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/src/widgets/app_button.dart';
import 'package:chat_app/src/widgets/app_icon.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixin{

  String _email;
  String _password;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  FocusNode _mailFocus;
  bool _isAsyncCall = false;
  final GlobalKey<FormState> _formKey =GlobalKey<FormState>();
  String _errorMessage = "";

  void setSpinnerStatus(bool status){
    setState(() {
      _isAsyncCall = status;
    });
  }

  @override
  void initState() {
    super.initState();
    _mailFocus = FocusNode();
  }

  @override
  void dispose() {
    _mailFocus.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  void clearTextInput(){
    _emailController.clear();
    _passwordController.clear();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: _buildLoginForm(context),
          ),
        ),
        inAsyncCall: _isAsyncCall,
        // demo of some additional parameters
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
      ),

    );
  }

  Widget _buildLoginForm(BuildContext context){
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 25.0),
      child: Column( 
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [ 
          AppIcon(),
          SizedBox(height: 48),
          _emailField(),
          SizedBox(height: 8),
          _passwordField(),
          SizedBox(height: 23),
          _showErrorMessage(),
          _buttonLogin(context),
        ],
      ),
    );
  }

  Widget _emailField(){
    return AppTextField(
      textInput: "Ingresa tu correo",
      onSaved: (value) {
        _email = value;
        print('Correo: $_email');
      },
      controller: _emailController,
      focusNode: _mailFocus,
      validator: validateEmail,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );

    
  }
  Widget _passwordField(){
    return AppTextField(
      textInput: "Ingresa tu contrasenia", 
      onSaved: (value) {
        _password = value;
        print('Password: $_password');
      },
      controller: _passwordController,
      isPassword: true,
      validator: validatePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction
    );
  }

  Widget _buttonLogin(BuildContext context){
    return AppButton(
      textButton: 'Login', 
      colorButton: Colors.lightBlueAccent, 
      onPressed: () async {
        if(_formKey.currentState.validate()){
          setSpinnerStatus(true);
          var loginUser = await Authentication().loginUser(email: _emailController.text, password: _passwordController.text);
          if(loginUser.success){
            clearTextInput();
            _mailFocus.requestFocus();
            Navigator.pushReplacementNamed(context, '/chat');
          }else{
            setState(() => _errorMessage = loginUser.errorMessage);
          }
          
          setSpinnerStatus(false);
        }
        
      }
    );
  }

  Widget _showErrorMessage(){
    if(_errorMessage != ''){
      return AppErrorMessage(errorMessage: _errorMessage);
    }else{
      return Container(height: 0.0,);
    }
  }

}