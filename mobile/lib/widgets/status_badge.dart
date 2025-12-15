import 'package:flutter/material.dart';
import '../models/grievance_model.dart';
import '../config/theme.dart';

class StatusBadge extends StatelessWidget {
  final GrievanceStatus status;

  const StatusBadge({super.key, required this.status});

  Color get color {
    switch (status) {
      case GrievanceStatus.submitted:
        return AppTheme.primaryColor;
      case GrievanceStatus.inProgress:
        return AppTheme.warningColor;
      case GrievanceStatus.resolved:
        return AppTheme.successColor;
      case GrievanceStatus.escalated:
        return Colors.purple;
      case GrievanceStatus.rejected:
        return AppTheme.errorColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status.name,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
