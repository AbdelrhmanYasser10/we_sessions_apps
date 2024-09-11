part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

class GetHomeDataLoading extends AppState{}
class GetHomeDataSuccess extends AppState{}
class GetHomeDataError extends AppState{}


class GetCategoriesDataLoading extends AppState{}
class GetCategoriesDataSuccess extends AppState{}
class GetCategoriesDataError extends AppState{}
