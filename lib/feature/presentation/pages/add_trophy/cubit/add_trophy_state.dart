part of 'add_trophy_cubit.dart';

class AddTrophyInitial extends AddTrophyState {}

enum ConfirmPasswordValidationError { invalid }

class AddTrophyState extends Equatable {
  const AddTrophyState({
    this.serialNum = const SerialNum.pure(),
    this.trophyDescription = '',
    this.fileOne = const FileObject.initial('', '', ''),
    this.fileTwo = const FileObject.initial('', '', ''),
    this.fileThree = const FileObject.initial('', '', ''),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.fileError = const EmptyFailure(),
  });

  final SerialNum serialNum;
  final FileObject fileOne;
  final FileObject fileTwo;
  final FileObject fileThree;
  final String trophyDescription;
  final FormzStatus status;
  final String? errorMessage;
  final Failure fileError;

  @override
  List<Object> get props => [
        serialNum,
        fileOne,
        fileTwo,
        fileThree,
        trophyDescription,
        status,
        fileError,
      ];

  AddTrophyState copyWith({
    SerialNum? serialNum,
    FileObject? fileOne,
    FileObject? fileTwo,
    FileObject? fileThree,
    String? trophyDescription,
    FormzStatus? status,
    String? errorMessage,
    Failure? fileError,
  }) {
    return AddTrophyState(
      serialNum: serialNum ?? this.serialNum,
      fileOne: fileOne ?? this.fileOne,
      fileTwo: fileTwo ?? this.fileTwo,
      fileThree: fileThree ?? this.fileThree,
      trophyDescription: trophyDescription ?? this.trophyDescription,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      fileError: fileError ?? this.fileError,
    );
  }
}
