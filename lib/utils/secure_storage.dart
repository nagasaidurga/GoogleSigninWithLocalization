import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SecureStorage {
  final _storage = FlutterSecureStorage();

  Future writeSecureData(String key, String value) async {
    var writeData = await _storage.write(key: key, value: value);
    return writeData;
  }
  Future readSecureData(String key) async{
    var readData=await _storage.read(key: key);
    print("read data: "+(readData!=null?readData:"null"));
    return readData;
  }
  Future deleteSecureData(String key) async{
    var deleteData=await _storage.delete(key: key);
    return deleteData;
  }
  Future writeSecureObject(String key, GoogleSignInAccount currentUser) async {
    var value=User(currentUser.displayName,currentUser.photoUrl,currentUser.email,currentUser.id);
    print("value"+value.toJson().toString());
    var value1=JsonEncoder().convert(value.toJson());
    var writeData = await _storage.write(key: key, value: value1);
    return writeData;
  }
  Future<User> readSecureObject(String key) async {
    var readData=await _storage.read(key: key);
    var readJson=User.fromJson(jsonDecode(readData));
    return readJson;
  }

}
class User{
  User(this.name, this.photoURL, this.email, this.id);
  String name;
  String photoURL;
  String id;
  String email;
  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'email': email,
        'id': id,
        'photoURL': photoURL,
      };
  factory User.fromJson(Map<String, dynamic> json) => _itemFromJson(json);
}

User _itemFromJson(Map<String, dynamic> json) {
  return User(
    json['name'] as String, json['photoURL'] as String,
    json['id'] as String,
    json['email'] as String,
  );
}

