part of 'database_cubit.dart';

@immutable
sealed class DatabaseState {}

final class DatabaseInitial extends DatabaseState {}

final class GetAllNotesLoading extends DatabaseState {}

final class GetAllNotesSuccess extends DatabaseState {}

final class GetAllNotesError extends DatabaseState {
final String message;
GetAllNotesError({required this.message});
}

final class UpdateNoteLoading extends DatabaseState {}

final class UpdateNoteSucessfully extends DatabaseState {}

final class UpdateNoteError extends DatabaseState {
  final String message;
  UpdateNoteError({required this.message});
}

final class AddNoteLoading extends DatabaseState {}

final class AddNoteSucessfully extends DatabaseState {}

final class AddNoteError extends DatabaseState {
  final String message;
  AddNoteError({required this.message});
}

final class DeleteNoteLoading extends DatabaseState {}

final class DeletedSuccesfullly extends DatabaseState {}

final class DeletedError extends DatabaseState {
final String message;
DeletedError({required this.message});
}