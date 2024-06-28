



import 'package:ak_notes_app/controllers/auth_controller.dart';
import 'package:ak_notes_app/models/user_model.dart';
import 'package:ak_notes_app/services/auth_service.dart';
import 'package:ak_notes_app/services/database_service.dart';
import 'package:ak_notes_app/views/constants/collection_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';


final class UserController  extends ChangeNotifier{

  UserModel _user = UserModel.empty() ;
  bool? _loading=false;
  List<bool> _changed=[false , false , false , false];


  void changeVal (int index , bool val){
    _changed[index]=val;
    notifyListeners();
  }




  List<bool> get changed => _changed;

  void initialNewValue(String fName , String lName , String gender , String age)
  {
    _user.fName=fName;
    _user.lName=lName;
    _user.gender=gender;
    _user.age=age;
    notifyListeners();
  }

  void initial(UserModel us){
    _user= us;
    notifyListeners();
  }

  set age(String val){
    _user.age=val;
    notifyListeners();
  }






  bool get loading => _loading!;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  UserModel? get user => _user;

UserController() {
   fetchUserData(AuthController().currentUser!.uid);
}
  Future<void> storeUser(UserModel user )  async{

    return await DatabaseService().storeUser(user).then((value){
      _user=user;
      print("UserController : User Have Added");
      notifyListeners();
    }).catchError((onError){
      print("UserController :"+onError.toString());
    });

  }
  Future<void> updatePassword(String currentPassword, String newPassword) async {
     await AuthService().updatePassword(currentPassword, newPassword).then((value){
       _user.password= newPassword;
       updateUser(_user);
       notifyListeners();
     });
  }
  Future<void> getUserData(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        _user=UserModel.fromMap(userDoc);
        notifyListeners();

      } else {
      _user= UserModel.empty();
      notifyListeners();
      }
    } catch (e) {
      print(e);
      _user= UserModel.empty();
      notifyListeners();
    }
  }

  Future<void> fetchUserData(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection(USERS_COLLECTION)
          .doc(userId)
          .get();
      if (userDoc.exists) {
        _user= UserModel.fromMap(userDoc);

        notifyListeners();
      }
      else {
        _user= UserModel.empty();
        notifyListeners();
      }
    }catch(e){

      print("Error in fetchUserData");
      _user= UserModel.empty();
      notifyListeners();
    }

  }
   Future<void> updateUser(UserModel user) async{
     return await DatabaseService().updateUser(user).then((value){
       _user= user;
       notifyListeners();
     }).catchError((error){
       print("Update User"+error.toString());
     });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    /* # to solve this : A UserController was used after being disposed.
       super.dispose();
     */
    print("object");
  }

}