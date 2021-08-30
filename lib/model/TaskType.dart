enum TaskType {
  NUMBERBONDS_OF_10, TIMESTABLE_TO_10
}

extension TaskTypeExtension on TaskType {
  String get name {
    switch (this) {
      case TaskType.NUMBERBONDS_OF_10:
        return 'Number bonds';
      case TaskType.TIMESTABLE_TO_10:
        return 'Times table';
      default:
        throw Exception("Not implemented");
    }
  }

  bool get requiresZero {
    switch (this) {
      case TaskType.NUMBERBONDS_OF_10:
        return false;
      case TaskType.TIMESTABLE_TO_10:
        return true;
      default:
        throw Exception("Not implemented");
    }
  }
}