import 'package:chat_app/src/model/auth_request.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication{

  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  Future<AuthenticationRequest> createUser({String email="", String password=""}) async{
    
    AuthenticationRequest authenticationRequest = AuthenticationRequest();

    try {
      var user =  await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if(user != null){
        authenticationRequest.success = true;
      }
    } catch (e) {
      _mapErrorMessage(authenticationRequest, e.code);
    } 
    return authenticationRequest;
  }

  Future<User> getCurrentUser() async{
    try{
      return _auth.currentUser;
      
    } catch(e){
      print(e);
    }
    return null;
  }

  Future<AuthenticationRequest> loginUser({String email="", String password=""}) async{

    AuthenticationRequest authRequest = AuthenticationRequest();

    try {
      var user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if(user != null){
        authRequest.success = true;
      }
    } catch (e) {
      _mapErrorMessage(authRequest, e.code);
    } 
    return authRequest;
  }

  Future<void> logoutUser() async{
    try{
      return _auth.signOut();
      
    } catch(e){
      print(e);
    }
    return null;
  }

  void _mapErrorMessage(AuthenticationRequest authenticationRequest, String code) {
    switch (code) {
      case 'user-not-found':
        authenticationRequest.errorMessage = "Usuario No encontrado";
        break;
      case 'wrong-password':
        authenticationRequest.errorMessage = "Contrasenia invalida";
        break;
      case 'ERROR_NETWORK_REQUEST_FAILED':
        authenticationRequest.errorMessage = "Error de red";
        break;
      case 'unknown':
        authenticationRequest.errorMessage = "El usuario ya esta registrado";
        break;
      default:
        authenticationRequest.errorMessage = code;
    }
  }
}