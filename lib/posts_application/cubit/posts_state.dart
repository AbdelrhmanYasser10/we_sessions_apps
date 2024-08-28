part of 'posts_cubit.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}
final class GetAllPostsLoading extends PostsState {}
final class GetAllPostsSuccess extends PostsState {}
final class GetAllPostsError extends PostsState {}