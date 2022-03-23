import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class SignUpParams extends Equatable {
  final String email;
  final String password;
  final String username;
  final XFile? photo;

  const SignUpParams({
    required this.username,
    required this.photo,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        username,
        email,
        password,
      ];
}
