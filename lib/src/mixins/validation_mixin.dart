
class ValidationMixin{

  String validateEmail(String value){
    if(!value.contains('@'))
      return "Email no es valido";
    return null;
  }

  String validatePassword(String value){
    if(value.length < 6)
      return "La contrasenia no es valida";
    return null;
  }


}