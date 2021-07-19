
class Todo {
  int id;
  String details;
  bool status;

  Todo({
    this.details = '',
    required this.id,
    this.status = false,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as int,
      details: json['details'] as String,
      status: json['status'] as bool
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'details': details,
      'status':status
    };
  }
}
