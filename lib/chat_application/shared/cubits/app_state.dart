part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class GetImageSuccessfully extends AppState{}
final class GetImageError extends AppState{}
final class CropImageSuccesfully extends AppState{}
final class CropImageError extends AppState{}

final class RegisterLoading extends AppState{}
final class RegisterSuccesfully extends AppState{}
final class RegisterWithError extends AppState{}

final class LoginLoading extends AppState{}
final class LoginSuccesfully extends AppState{}
final class LoginWithError extends AppState{}