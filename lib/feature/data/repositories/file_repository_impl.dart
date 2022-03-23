import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/repositories/file_repository.dart';

@Injectable(as: FileRepository)
class FileRepositoryImpl implements FileRepository {
  final FirebaseStorage _firebaseStorage;
  final FirebaseAuth _firebaseAuth;
  FileRepositoryImpl(this._firebaseStorage, this._firebaseAuth);

  @override
  Future<Either<Failure, String>> uploadFile(XFile file) async {
    File _file = File(file.path);
    try {
      Reference ref = _firebaseStorage
          .ref()
          .child('profilePics')
          .child(_firebaseAuth.currentUser!.uid);

      UploadTask uploadTask = ref.putFile(_file);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return Right(downloadUrl);
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }
}
