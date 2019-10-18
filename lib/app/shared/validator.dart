import 'dart:async';

mixin Validators{

  var emailValidator = StreamTransformer<String,String>.fromHandlers( 
    handleData: (email,sink){
      if(email.contains("@"))
        sink.add(email);
      else
        sink.addError("Email inválido");
    }
  );

  var passwordValidator = StreamTransformer<String,String>.fromHandlers( 
    handleData: (password,sink){
      if(password.length>4)
        sink.add(password);
      else
        sink.addError("A senha deve ter mais de 4 caracteres");
    }
  );

}

