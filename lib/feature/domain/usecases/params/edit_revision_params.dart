import 'package:equatable/equatable.dart';

class EditRevisionParams extends Equatable {
  final String id;
  final String name;
  final String description;

  const EditRevisionParams({
    required this.id,
    required this.name,
    required this.description,
  });

  @override
  List<Object> get props => [id, name, description];
}
