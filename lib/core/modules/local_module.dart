import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class LocalModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  HiveInterface get hive => Hive;

  ImagePicker get imagePicker => ImagePicker();

  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;

  // DeviceInfoPlugin get deviceInfoPlugin => DeviceInfoPlugin();
}
