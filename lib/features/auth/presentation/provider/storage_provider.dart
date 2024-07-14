

import 'package:dartz/dartz_streaming.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils.dart';

class StorageProvider extends ChangeNotifier{

 final FirebaseStorage _storage = FirebaseStorage.instance;
  Uint8List? _img;
  double _uploadProgress = 0.0;
  String? imageUrl;

  Uint8List? get img => _img;

  set img(Uint8List? value) {
    _img = value;
  }

  bool _isUploading = false;
  Future<void> selectImage(ImageSource source) async{
       _img= await pickImage(source);
      notifyListeners();


  }
Future<void> uploadImageProfile() async{

 _isUploading=true;
_uploadProgress = 0.0;
notifyListeners();
  Reference storageRef = _storage.ref().child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
  UploadTask uploadTask = storageRef.putData(_img!);
  uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      _uploadProgress = (snapshot.bytesTransferred / snapshot.totalBytes).round() * 100;
      notifyListeners();
  });

 await uploadTask.whenComplete(() => null);
 imageUrl= await storageRef.getDownloadURL();

 _isUploading=false;
 _uploadProgress = 0.0;
 notifyListeners();
}
  double get uploadProgress => _uploadProgress;

  set uploadProgress(double value) {
    _uploadProgress = value;
  }

  bool get isUploading => _isUploading;

  set isUploading(bool value) {
    _isUploading = value;
  }

  resetVariable(){
    _uploadProgress=0.0;
    _img=null;
    _isUploading=false;
    notifyListeners();
  }
}