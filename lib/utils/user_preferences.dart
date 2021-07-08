import 'package:truck/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
_loadUserData() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));
    //String userPref = localStorage.getString('user');
     
//Map<String,dynamic> userMap = jsonDecode(userPref) as Map<String, dynamic>;
        return user['name'];
    
  }
class UserPreferences{
  
  static var myUser=User(
    imagePath:"https:////m.files.bbci.co.uk/modules/bbc-morph-sport-seo-meta/1.20.8/images/bbc-sport-logo.png",
 name:"custom",
  role:"sdfsd",
   email:"fdfsdfs",
   snn:"fdsfds",
  mobile_number:"fsdfds",
  dob:"fdsfsdf",
  user_type:"dfsdfdf",
   vehicle_type:"dsfdsf",
  register_for_city:"fdsfsd",
 experience:"fdsfdsf",
  gender:"sdfsdf",
  );
}