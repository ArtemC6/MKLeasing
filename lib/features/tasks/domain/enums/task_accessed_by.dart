enum TaskAccessedBy { user, subdivision }

extension TaskAccessedByExtension on TaskAccessedBy {
  String get value {
    switch (this) {
      case TaskAccessedBy.user:
        return 'user';
      case TaskAccessedBy.subdivision:
        return 'subdivision';
    }
  }
}