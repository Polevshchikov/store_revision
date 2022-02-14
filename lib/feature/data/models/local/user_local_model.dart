// // ignore_for_file: overridden_fields

// import 'package:hive/hive.dart';
// import 'package:store_revision/feature/domain/entities/user_entity.dart';

// part 'user_local_model.g.dart';

// const userBoxKey = 'userBox';

// @HiveType(typeId: 1)
// class UserLocalModel extends UserEntity {
//   @override
//   @HiveField(0)
//   final String id;
//   @override
//   @HiveField(1)
//   final String email;
//   @override
//   @HiveField(2)
//   final String name;
//   @override
//   @HiveField(3)
//   final String photo;

//   const UserLocalModel({
//     required this.id,
//     required this.email,
//     required this.name,
//     required this.photo,
//   }) : super(
//           id: id,
//           email: email,
//           name: name,
//           photo: photo,
//         );

//   factory UserLocalModel.from(UserEntity user) => UserLocalModel(
//         id: user.id,
//         email: user.email ?? '',
//         name: user.name ?? '',
//         photo: user.photo ?? '',
//       );
// }
