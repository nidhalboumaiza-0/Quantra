import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin/data layer/data sources/admin_remote_data_source.dart';
import 'admin/data layer/repositories/admin_repository_impl.dart';
import 'admin/domain layer/repositories/admin_repository.dart';
import 'admin/domain layer/usecases/urgent_raise_usecase.dart';
import 'admin/presentation layer/cubit/bridge cubit/bridge__cubit.dart';
import 'authorisation/data layer/data sources/user_local_data_source.dart';
import 'authorisation/data layer/data sources/user_remote_data_source.dart';
import 'authorisation/data layer/repositories/user_repository_impl.dart';
import 'authorisation/domain layer/repositories/user_repository.dart';
import 'authorisation/domain layer/usecases/disable_account.dart';
import 'authorisation/domain layer/usecases/forget_password.dart';
import 'authorisation/domain layer/usecases/get_cached_user_info.dart';
import 'authorisation/domain layer/usecases/modify_my_information.dart';
import 'authorisation/domain layer/usecases/reset_password_step_one.dart';
import 'authorisation/domain layer/usecases/reset_password_step_two.dart';
import 'authorisation/domain layer/usecases/sign_in.dart';
import 'authorisation/domain layer/usecases/sign_out.dart';
import 'authorisation/domain layer/usecases/sign_up.dart';
import 'authorisation/domain layer/usecases/update_user_password.dart';
import 'authorisation/presentation layer/bloc/disable_account_bloc/disable_account_bloc.dart';
import 'authorisation/presentation layer/bloc/forget_password_bloc/forget_password_bloc.dart';
import 'authorisation/presentation layer/bloc/get_cached_user_info/get_cached_user_bloc.dart';
import 'authorisation/presentation layer/bloc/modify my information bloc/modify_my_information_bloc.dart';
import 'authorisation/presentation layer/bloc/reset_password_step_one_bloc/reset_password_step_one_bloc.dart';
import 'authorisation/presentation layer/bloc/reset_password_step_two_bloc/reset_password_step_two_bloc.dart';
import 'authorisation/presentation layer/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'authorisation/presentation layer/bloc/sign_out_bloc/sign_out_bloc.dart';
import 'authorisation/presentation layer/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'authorisation/presentation layer/bloc/update_user_password_bloc/update_user_password_bloc.dart';
import 'authorisation/presentation layer/cubit/confirm_password_visibility_reset_password_cubit/reset_confirm_password_visibility_cubit.dart';
import 'authorisation/presentation layer/cubit/password_visibility_reset_password_cubit/reset_password_visibility_cubit.dart';
import 'authorisation/presentation layer/cubit/password_visibility_sign_in_cubit/password_visibility_cubit.dart';
import 'authorisation/presentation layer/cubit/profile_pic_creation _cubit/profile_pic_creation__cubit.dart';
import 'bloc/weather_bloc_bloc.dart';
import 'core/network/network_info.dart';
import 'cubit/confirm new password cubit/confirm_new_password_cubit.dart';
import 'cubit/new password cubit/new_password_cubit.dart';
import 'cubit/old password cubit/old_password_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => BridgeCubit(urgentRaiseUsecase: sl()));
  sl.registerFactory(() => ConfirmNewPasswordCubit());
  sl.registerFactory(() => NewPasswordCubit());
  sl.registerFactory(() => OldPasswordCubit());
  sl.registerFactory(
      () => ModifyMyInformationBloc(modifyMyInformationUseCase: sl()));
  sl.registerFactory(() => WeatherBlocBloc());
  sl.registerFactory(() => GetCachedUserBloc(getCachedUserInfoUseCase: sl()));
  sl.registerFactory(() => ProfilePicCreationCubit());
  sl.registerFactory(() => ResetPasswordVisibilityCubit());
  sl.registerFactory(() => ResetConfirmPasswordVisibilityCubit());
  sl.registerFactory(() => PasswordVisibilityCubit());
  sl.registerFactory(() => SignInBloc(signIn: sl()));
  sl.registerFactory(() => ForgetPasswordBloc(forgetPassword: sl()));
  sl.registerFactory(() => DisableAccountBloc(disableAccount: sl()));
  sl.registerFactory(() => SignUpBloc(signUpUseCase: sl()));
  sl.registerFactory(
      () => ResetPasswordStepOneBloc(forgetPasswordStepOneUseCase: sl()));
  sl.registerFactory(
      () => ResetPasswordStepTwoBloc(resetPasswordStepTwoUseCase: sl()));
  sl.registerFactory(() => SignOutBloc(signOut: sl()));
  sl.registerFactory(() => UpdateUserPasswordBloc(updatePasswordUseCase: sl()));
  // Use cases
  sl.registerLazySingleton(() => UrgentRaiseUsecase(adminRepository: sl()));
  sl.registerLazySingleton(() => ModifyMyInformationUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedUserInfoUseCase(sl()));
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => DisableAccountUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordStepOneUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordStepTwoUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserPasswordUseCase(sl()));
  // Repository
  sl.registerLazySingleton<AdminRepository>(() => AdminRepositoryImpl(
        networkInfo: sl(),
        adminRemoteDataSource: sl(),
      ));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        userRemoteDataSource: sl(),
        userLocalDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<AdminRemoteDataSource>(
      () => AdminRemoteDataSourceImpl());
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(sharedPreferences: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External

  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
