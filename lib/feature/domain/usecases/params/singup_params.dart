import 'package:equatable/equatable.dart';

class SignUpParams extends Equatable {
  final String email;
  final String password;
  final String username;
  // final String? photo;

  const SignUpParams({
    required this.username,
    // this.photo,
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
