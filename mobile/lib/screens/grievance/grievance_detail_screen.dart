// ============================================
// FILE: lib/screens/grievance/grievance_detail_screen.dart
// FIXED VERSION - Safe handling + Branding
// ============================================
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/grievance_model.dart';
import '../../providers/grievance_provider.dart';
import '../../widgets/status_badge.dart';
import 'package:intl/intl.dart';

class GrievanceDetailScreen extends ConsumerWidget {
  final String grievanceId;

  const GrievanceDetailScreen({
    super.key,
    required this.grievanceId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grievances = ref.watch(grievanceProvider);
    
    // ✅ FIX 1: Safe handling - check empty list and not found
    if (grievances.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('CPGRAMS – Grievance Details'),
        ),
        body: const Center(
          child: Text('No grievances found'),
        ),
      );
    }

    final grievance = grievances.cast<Grievance?>().firstWhere(
      (g) => g?.id == grievanceId,
      orElse: () => null,
    );

    if (grievance == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('CPGRAMS – Grievance Details'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text('Grievance not found'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('CPGRAMS – Grievance Details'), // ✅ FIX 2: Branding
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Badge
                    StatusBadge(status: grievance.status),
                    const SizedBox(height: 12),

                    // Title
                    Text(
                      grievance.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // ID
                    Row(
                      children: [
                        Icon(Icons.tag, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          'ID: ${grievance.id}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Created Date
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          'Filed on ${DateFormat('MMM dd, yyyy').format(grievance.createdAt)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Details Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Details',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),

                    // Category
                    _buildDetailRow(
                      context,
                      Icons.category,
                      'Category',
                      grievance.category,
                    ),
                    const Divider(height: 24),

                    // Location
                    _buildDetailRow(
                      context,
                      Icons.location_on,
                      'Location',
                      grievance.location,
                    ),
                    const Divider(height: 24),

                    // Description
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.description,
                                size: 20, color: Colors.grey[700]),
                            const SizedBox(width: 8),
                            Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          grievance.description,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Timeline Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Timeline',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),

                    // Timeline
                    _buildTimelineItem(
                      context,
                      'Submitted',
                      'Your grievance has been submitted',
                      DateFormat('MMM dd, yyyy • hh:mm a')
                          .format(grievance.createdAt),
                      isCompleted: true,
                      isFirst: true,
                    ),
                    _buildTimelineItem(
                      context,
                      'In Progress',
                      'Under review by concerned department',
                      grievance.status.index >= GrievanceStatus.inProgress.index
                          ? DateFormat('MMM dd, yyyy • hh:mm a').format(
                              grievance.createdAt.add(const Duration(days: 1)))
                          : null,
                      isCompleted: grievance.status.index >=
                          GrievanceStatus.inProgress.index,
                    ),
                    _buildTimelineItem(
                      context,
                      'Resolved',
                      'Your grievance has been resolved',
                      grievance.status == GrievanceStatus.resolved
                          ? DateFormat('MMM dd, yyyy • hh:mm a').format(
                              grievance.createdAt.add(const Duration(days: 3)))
                          : null,
                      isCompleted:
                          grievance.status == GrievanceStatus.resolved,
                      isLast: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      BuildContext context, IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[700]),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineItem(
    BuildContext context,
    String title,
    String subtitle,
    String? timestamp, {
    required bool isCompleted,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              if (!isFirst)
                Container(
                  width: 2,
                  height: 16,
                  color: isCompleted ? Colors.green : Colors.grey[300],
                ),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted ? Colors.green : Colors.grey[300],
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: isCompleted
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isCompleted ? Colors.green : Colors.grey[300],
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isCompleted ? Colors.black87 : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  if (timestamp != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      timestamp,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}