import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/entities/file_object.dart';
import 'package:store_revision/feature/domain/usecases/upload_camera_image_usecase.dart';
import 'package:store_revision/feature/domain/usecases/upload_file_usecase.dart';
import 'package:store_revision/feature/presentation/pages/add_trophy/ui/utils/enum_file_num.dart';
import 'package:store_revision/feature/presentation/pages/add_trophy/ui/utils/serial_num.dart';

part 'add_trophy_state.dart';

@injectable
class AddTrophyCubit extends Cubit<AddTrophyState> {
  AddTrophyCubit(
    this._uploadCameraImageUseCase,
    this._uploadFileUseCase,
  ) : super(const AddTrophyState());
  final UploadCameraImageUseCase _uploadCameraImageUseCase;
  final UploadFileUseCase _uploadFileUseCase;

  void serialNumChanged(String value) {
    final serialNum = SerialNum.dirty(value);
    emit(state.copyWith(
      serialNum: serialNum,
      status: Formz.validate([serialNum]),
    ));
  }

  void descriptionChanged(String value) =>
      emit(state.copyWith(trophyDescription: value));

  void deleteFile({required FileNum fileNum}) {
    switch (fileNum) {
      case FileNum.fileOne:
        emit(state.copyWith(fileOne: const FileObject.initial('', '', '')));
        break;
      case FileNum.fileTwo:
        emit(state.copyWith(fileTwo: const FileObject.initial('', '', '')));
        break;
      case FileNum.fileThree:
        emit(state.copyWith(fileThree: const FileObject.initial('', '', '')));
        break;
      default:
        break;
    }
  }
}
