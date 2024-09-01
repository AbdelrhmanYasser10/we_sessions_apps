part of 'news_cubit.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}

class GetResultsLoading extends NewsState{}
class GetResultsSuccess extends NewsState{}
class GetResultsError extends NewsState{}