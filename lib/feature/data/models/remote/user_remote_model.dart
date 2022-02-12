
// part 'user_remote_model.g.dart';

// @JsonSerializable(createToJson: false)
// class UserRemoteModel extends UserEntity {
//   final String id;
//   final String email;
//   final String name;
//   final String avatar;
//   @override
//   @JsonKey(ignore: true)
//   final LocationRemoteModel location;

//   const UserRemoteModel({
//     required this.id,
//     required this.email,
//     required this.name,
//     required this.avatar,
//     required this.location,
//   }) : super(
//           id: id,
//           email: email,
//           name: name,
//           avatar: avatar,
//           location: location,
//         );

//   factory UserRemoteModel.fromJson(
//     Map<String, dynamic> json, {
//     required LocationRemoteModel location,
//   }) {
//     final model = _$UserRemoteModelFromJson(json);
//     model.location = location;
//     return model;
//   }
// }
