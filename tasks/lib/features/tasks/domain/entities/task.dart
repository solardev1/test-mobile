class TaskDTO {
  final String id;
  final String title;
  final String description;
  final String priority;

  TaskDTO(
      {required this.id,
      required this.title,
      required this.description,
      required this.priority});

  //to String
  @override
  String toString() {
    return 'TaskDTO(id: $id, title: $title, description: $description, priority: $priority)';
  }
}


enum PriorityFilter {
  all,
  alta,
  media,
  baja,
  otras,
}