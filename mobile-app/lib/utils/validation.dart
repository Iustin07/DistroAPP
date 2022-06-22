class Validator{

static String? validatePassword(String? value){
    if(value!.isEmpty || value.length<8){
                  return 'Password is to short. Password should be at leat 8 characters.';
                }
  if (!RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$")
        .hasMatch(value.toString())) {
      return "password must contain at least a capital letter and a number";
    }
}
static String? validateUserName(String? value){ 
      if(value==null || value.isEmpty){
        return 'field is empty';
      }
      String providedUser=value.toString().trim();
                 final args=providedUser.split(" ");
                 if(args.length<2){
                   return 'Username should contains at least two names';
                 }
                 if(!args[0].startsWith(RegExp(r'[A-Z]')) || !args[1].startsWith(RegExp(r'[A-Z]'))){
                   return 'names should start with capital letter';
                 }
      
}
static String? validatePhoneNumber(String? value){
  if(value==null || value.isEmpty){
    return 'phone number can not be empty';
  }
  if (!RegExp("[(07)|(02)|(03)][0-9]{9}").hasMatch(value as String)){
    return "not valid phone number";
  }
}

static String? validateDouble(String? value){
  if(double.tryParse(value as String)==null){
    return 'value provided is not double';
  }
  double number=double.parse(value);
  if(number<0){
    return 'numbers should be positive value';
  }
}
static String? validateCif(String? value){
    if(value==null || value.isEmpty){
    return 'cif can not be empty';
  }
  if (!RegExp("[A-Z]{2}[0-9]{1,10}").hasMatch(value as String)){
    return "not valid cif";
  }
}
static String? validateCRN(String? value){
    if(value==null || value.isEmpty){
    return 'commerce reg number ca not be empty';
  }
   if (!RegExp("[F|J][0-9]{2}\/[1-9]{1,9}\/[1-9][0-9]{3}").hasMatch(value as String)){
    return "not valid cif";
  }
}
static String? validateRegisterNumber(String? value){
  if(value==null || value.isEmpty){
    return 'provide a registration number';
  }
  if(!RegExp("[A-Z]{1,2}\\s[0-9]{2,3}\\s[A-Z]{3}").hasMatch(value as String)){
    return 'invalid registration number. Pay atention to spaces!';
  }
}
static String? validateGeneral(String? value){
   if(value==null || value.isEmpty){
    return 'this filed can not be empty';
  }
}
}
