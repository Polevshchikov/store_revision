// // ignore_for_file: overridden_fields

// import 'package:hive/hive.dart';
// import 'package:irla_my/feature/domain/entities/user_entity.dart';

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
//   final String avatar;
//   @override
//   @HiveField(4)
//   final String country;
//   @override
//   @HiveField(5)
//   final String state;
//   @override
//   @HiveField(6)
//   final String city;

//   const UserLocalModel({
//     required this.id,
//     required this.email,
//     required this.name,
//     required this.avatar,
//     required this.country,
//     required this.state,
//     required this.city,
//   }) : super(
//           id: id,
//           email: email,
//           name: name,
//           avatar: avatar,
//           country: country,
//           state: state,
//           city: city,
//         );

//   factory UserLocalModel.from(UserEntity user) => UserLocalModel(
//         id: user.id,
//         email: user.email,
//         name: user.name,
//         avatar: user.avatar,
//         country: user.country,
//         state: user.state,
//         city: user.city,
//       );
// }
