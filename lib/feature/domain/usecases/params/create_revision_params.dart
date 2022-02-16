import 'package:equatable/equatable.dart';

class CreateRevisionParams extends Equatable {
  final String uid;
  final String name;
  final String description;
  final String username;

  const CreateRevisionParams({
    required this.uid,
    required this.name,
    required this.description,
    required this.username,
  });

  @override
  List<Object> get props => [
        uid,
        name,
        description,
        username,
      ];
}
