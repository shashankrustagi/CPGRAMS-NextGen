import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/grievance_model.dart';

class GrievanceNotifier extends StateNotifier<List<Grievance>> {
  GrievanceNotifier() : super([]);

  void loadGrievances() {
    state = [
      Grievance(
        id: '1',
        title: 'Street Light Not Working',
        description: 'Street light near sector 5 has been off for weeks',
        category: 'Public Works',
        status: GrievanceStatus.inProgress,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        location: 'Sector 5, Delhi',
      ),
    ];
  }

  void addGrievance(Grievance grievance) {
    state = [...state, grievance];
  }
}

final grievanceProvider =
    StateNotifierProvider<GrievanceNotifier, List<Grievance>>((ref) {
  return GrievanceNotifier();
});
