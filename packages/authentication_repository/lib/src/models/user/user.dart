import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? email;
  final String? name;
  final String? photoUrl;

  const User({this.email, this.photoUrl, this.name, required this.id});

  User copyWith({String? id, String? name, String? email, String? photoUrl}) {
    return User(
        id: id != null ? id : this.id,
        name: name != null ? name : this.name,
        email: email != null ? email : this.email,
        photoUrl: photoUrl != null ? photoUrl : this.photoUrl);
  }

  static const empty = User(id: '');
  bool get isEmpty => this == empty;
  bool get isNotEmpty => this != empty;

  @override
  List<Object?> get props => [id, email, name, photoUrl];
}
