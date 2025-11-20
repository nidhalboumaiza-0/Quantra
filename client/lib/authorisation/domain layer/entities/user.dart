import 'package:equatable/equatable.dart';

class User extends Equatable {
  late final String id;
  late String profilePicture;
  late String firstName;
  late String lastName;
  late String phoneNumber;
  late String email;
  late String password;
  late String passwordConfirm;
  late String passwordResetCode;
  late bool accountStatus;
  late String accountType;

  User(
    this.id,
    this.profilePicture,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.password,
    this.passwordConfirm,
    this.passwordResetCode,
    this.accountStatus,
    this.accountType,
  );

  User.create({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.passwordConfirm,
  }) {
    id = '';
    profilePicture = '';
    accountType = '';
    passwordResetCode = '';
    accountStatus = false;
  }

  @override
  List<Object?> get props => [
        id,
        profilePicture,
        firstName,
        lastName,
        phoneNumber,
        email,
        password,
        passwordConfirm,
        passwordResetCode,
        accountStatus,
      ];
}
