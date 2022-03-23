import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';

@module
abstract class LocalModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  ImagePicker get imagePicker => ImagePicker();

  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;

  FirebaseStorage get firebaseStorage => FirebaseStorage.instance;

  Connectivity get connectivity => Connectivity();

  HiveInterface get hive => Hive;
}
