enum GrievanceStatus {
  submitted,
  inProgress,
  resolved,
  escalated,
  rejected,
}

class Grievance {
  final String id;
  final String title;
  final String description;
  final String category;
  final GrievanceStatus status;
  final DateTime createdAt;
  final String location;
  final List<String>? attachments;

  Grievance({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    required this.createdAt,
    required this.location,
    this.attachments,
  });
}
