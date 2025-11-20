import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/error/exceptions.dart';

import '../../../core/error/failures.dart';

abstract class AdminRemoteDataSource {
  Future<Unit> OperationBridge(bool isRaisePont);
}

class AdminRemoteDataSourceImpl implements AdminRemoteDataSource {
  @override
  Future<Unit> OperationBridge(bool isRaisePont) async {
    late String notificationHeader;
    late String notificationMessage;
    if (isRaisePont) {
      notificationHeader = "Attention (Cas d'urgence)";
      notificationMessage = "Le pont est levé devant vous, veuillez attendre";
    } else {
      notificationHeader = "Attention";
      notificationMessage =
          "Le pont est dans un état normal et vous peuvez avancer";
    }
    final body = {
      "notificationHeader": notificationHeader,
      "notificationMessage": notificationMessage,
    };
    final token = await this.token;
    final response = await http.post(
      Uri.parse("${dotenv.env['URL']}/send-notification"),
      headers: {
        "Authorization": "Bearer $token",
      },
      body: body,
    );
    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return unit;
    } else if (response.statusCode == 410) {
      final errorMessage = responseBody['message'] as String;

      UnauthorizedFailure.message = errorMessage;
      throw const UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  Future<dynamic> get token async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }
}
