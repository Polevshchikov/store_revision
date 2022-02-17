import 'package:equatable/equatable.dart';

class CreateRevisionParams extends Equatable {
  final String uid;
  final String name;
  final String description;

  const CreateRevisionParams({
    required this.uid,
    required this.name,
    required this.description,
  });

  @override
  List<Object> get props => [
        uid,
        name,
        description,
      ];
}
