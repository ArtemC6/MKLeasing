import 'package:equatable/equatable.dart';

class CursorPaginationEntity<T> extends Equatable {
  final MetaCursorPaginationEntity meta;
  final List<T> data;

  CursorPaginationEntity({required this.meta, required this.data});

  @override
  List<Object?> get props =>
      [meta.nextCursor, meta.prevCursor, meta.perPage, ...data];
}

class MetaCursorPaginationEntity extends Equatable {
  final String? nextCursor;
  final String? prevCursor;
  final int perPage;

  MetaCursorPaginationEntity(
      {required this.nextCursor,
      required this.prevCursor,
      required this.perPage});

  @override
  List<Object?> get props => [nextCursor, prevCursor, perPage];
}
