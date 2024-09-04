part of 'news_cubit.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}

class GetResultsLoading extends NewsState{}
class GetResultsSuccess extends NewsState{}
class GetResultsError extends NewsState{}


class GetSliderNewsLoading extends NewsState{}
class GetSliderNewsSuccess extends NewsState{}
class GetSliderNewsError extends NewsState{}

class GetBreakingNewsLoading extends NewsState{}
class GetBreakingNewsSuccess extends NewsState{}
class GetBreakingNewsError extends NewsState{}