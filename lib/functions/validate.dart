import 'package:get/get.dart';

validate(String val,int min,int max,String type) {
if(type == 'name') {
  if(!GetUtils.isUsername(val)) {
    return 'not valid user name';
  }
}
if(type == 'email') {
  if(!GetUtils.isEmail(val)) {
    return "not valid email";
  }
}
if(type == 'phone') {
  if(!GetUtils.isPhoneNumber(val)) {
    return 'not valid phone';
  }
}
if(val.isEmpty) {
  return "can't be empty";
}
if(val.length < min) {
  return "can't be less than $min";
}
if(val.length > max) {
  return "can't be larger than $max";
}
}