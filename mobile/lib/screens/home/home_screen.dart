import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/routes.dart';
import '../../providers/auth_provider.dart';
import '../../providers/grievance_provider.dart';
import '../../widgets/status_badge.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load grievances
    Future.microtask(() => ref.read(grievanceProvider.notifier).loadGrievances());
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final grievances = ref.watch(grievanceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CPGRAMS NextGen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, Routes.profile),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome
            Text(
              'Welcome, ${authState.userName ?? 'User'}!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            
            // Stats - Simple
            Text(
              'Total Grievances: ${grievances.length}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            
            // Actions
            _buildActionButton(
              context,
              'File New Grievance',
              Icons.add_circle_outline,
              () => Navigator.pushNamed(context, Routes.fileGrievance),
            ),
            const SizedBox(height: 12),
            _buildActionButton(
              context,
              'View All Grievances',
              Icons.list,
              () => Navigator.pushNamed(context, Routes.grievanceList),
            ),
            
            const SizedBox(height: 32),
            
            // Recent Grievances
            if (grievances.isNotEmpty) ...[
              Text(
                'Recent Grievances',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              ...grievances.take(3).map((g) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  title: Text(g.title),
                  subtitle: Text(g.category),
                  trailing: StatusBadge(status: g.status),
                  onTap: () => Navigator.pushNamed(
                    context,
                    Routes.grievanceDetail,
                    arguments: {'id': g.id},
                  ),
                ),
              )),
            ] else ...[
              const SizedBox(height: 32),
              Center(
                child: Text(
                  'No grievances yet.\nFile your first one!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String text,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(text),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
