
class TaskResponse {
  final String id;
  final String title;
  final String description;
  final String priority;

  TaskResponse(
      {required this.id,
      required this.title,
      required this.description,
      required this.priority});

      factory TaskResponse.fromJson(Map<String, dynamic> json) {
    return TaskResponse(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      priority: json['priority'] as String,
    );
      }

//toString
  @override
  String toString() {
    return 'TaskResponse(id: $id, title: $title, description: $description, priority: $priority)';
  }
 
}

class TasksResponse {
  final List<TaskResponse> tasks;

  TasksResponse({required this.tasks});

  factory TasksResponse.fromJson(List<Map<String, dynamic>> json) {
    return TasksResponse(
      tasks: json
      .map((e) => TaskResponse.fromJson(e)).toList(),
    );
  }
}