import 'package:equatable/equatable.dart';

/// {@template user}
/// User model
///
/// [UserEntity.empty] represents an unauthenticated user.
/// {@endtemplate}
class UserEntity extends Equatable {
  /// {@macro user}
  const UserEntity({
    required this.uid,
    this.email,
    this.name,
    this.photo,
  });

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String uid;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photo;

  /// Empty user which represents an unauthenticated user.
  static const empty = UserEntity(uid: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == UserEntity.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != UserEntity.empty;

  @override
  List<Object?> get props => [email, uid, name, photo];
}
