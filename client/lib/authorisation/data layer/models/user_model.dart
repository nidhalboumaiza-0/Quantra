import '../../domain layer/entities/user.dart';

class UserModel extends User {
  UserModel(
    super.id,
    super.profilePicture,
    super.firstName,
    super.lastName,
    // ignore: non_constant_identifier_names
    super.PhoneNumber,
    super.email,
    super.password,
    super.passwordConfirm,
    super.passwordResetCode,
    super.accountStatus,
    super.accountType,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json['_id'] ?? '',
      json['profilePicture'] ?? '',
      json['firstName'] ?? '',
      json['lastName'] ?? '',
      json['phoneNumber'] ?? '',
      json['email'] ?? '',
      json['password'] ?? '',
      json['passwordConfirm'] ?? '',
      json['passwordResetCode'] ?? '',
      json['accountStatus'] ?? false,
      json['accountType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profilePicture': profilePicture,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
      'passwordConfirm': passwordConfirm,
      'passwordResetCode': passwordResetCode,
      'accountStatus': accountStatus,
    };
  }
}
