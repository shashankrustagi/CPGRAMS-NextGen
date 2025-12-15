// ============================================
// FILE: lib/screens/grievance/grievance_list_screen.dart
// ============================================
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/routes.dart';
import '../../models/grievance_model.dart';
import '../../providers/grievance_provider.dart';
import '../../widgets/status_badge.dart';

class GrievanceListScreen extends ConsumerStatefulWidget {
  const GrievanceListScreen({super.key});

  @override
  ConsumerState<GrievanceListScreen> createState() =>
      _GrievanceListScreenState();
}

class _GrievanceListScreenState extends ConsumerState<GrievanceListScreen> {
  String _searchQuery = '';
  GrievanceStatus? _selectedStatus;
  String _sortBy = 'date'; // 'date' or 'status'

  List<Grievance> _getFilteredGrievances(List<Grievance> grievances) {
    var filtered = grievances.where((g) {
      // Search filter
      final matchesSearch = _searchQuery.isEmpty ||
          g.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          g.category.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          g.location.toLowerCase().contains(_searchQuery.toLowerCase());

      // Status filter
      final matchesStatus =
          _selectedStatus == null || g.status == _selectedStatus;

      return matchesSearch && matchesStatus;
    }).toList();

    // Sort
    if (_sortBy == 'date') {
      filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else {
      filtered.sort((a, b) => a.status.index.compareTo(b.status.index));
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final allGrievances = ref.watch(grievanceProvider);
    final filteredGrievances = _getFilteredGrievances(allGrievances);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CPGRAMS • My Grievances'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterBottomSheet(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search grievances...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
          ),

          // Filter Chips
          if (_selectedStatus != null || _sortBy != 'date')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  if (_selectedStatus != null) ...[
                    Chip(
                      label: Text('Status: ${_selectedStatus!.name}'),
                      onDeleted: () {
                        setState(() => _selectedStatus = null);
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                  if (_sortBy != 'date')
                    Chip(
                      label: Text('Sort: $_sortBy'),
                      onDeleted: () {
                        setState(() => _sortBy = 'date');
                      },
                    ),
                ],
              ),
            ),

          // Results Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  '${filteredGrievances.length} result(s)',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),

          // Grievance List
          Expanded(
            child: filteredGrievances.isEmpty
                ? _buildEmptyState()
                : RefreshIndicator(
                    onRefresh: () async {
                      // Simulate refresh
                      await Future.delayed(const Duration(seconds: 1));
                      ref.read(grievanceProvider.notifier).loadGrievances();
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredGrievances.length,
                      itemBuilder: (context, index) {
                        final grievance = filteredGrievances[index];
                        return _buildGrievanceCard(context, grievance);
                      },
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, Routes.fileGrievance),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildGrievanceCard(BuildContext context, Grievance grievance) {
    final daysSince = DateTime.now().difference(grievance.createdAt).inDays;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          Routes.grievanceDetail,
          arguments: {'id': grievance.id},
        ),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Title + Status
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      grievance.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  StatusBadge(status: grievance.status),
                ],
              ),
              const SizedBox(height: 8),

              // Category + Location
              Row(
                children: [
                  Icon(Icons.category, size: 14, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    grievance.category,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      grievance.location,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Description Preview
              Text(
                grievance.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[800],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),

              // Footer: Date + ID
              Row(
                children: [
                  Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    daysSince == 0
                        ? 'Today'
                        : daysSince == 1
                            ? 'Yesterday'
                            : '$daysSince days ago',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'ID: ${grievance.id.substring(grievance.id.length - 6)}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isNotEmpty || _selectedStatus != null
                ? 'No grievances match your filters'
                : 'No grievances yet',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty || _selectedStatus != null
                ? 'Try adjusting your search or filters'
                : 'File your first grievance to get started',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          if (_searchQuery.isEmpty && _selectedStatus == null) ...[
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () =>
                  Navigator.pushNamed(context, Routes.fileGrievance),
              icon: const Icon(Icons.add),
              label: const Text('File Grievance'),
            ),
          ],
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filter & Sort',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),

                  // Status Filter
                  Text(
                    'Filter by Status',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      FilterChip(
                        label: const Text('All'),
                        selected: _selectedStatus == null,
                        onSelected: (selected) {
                          setModalState(() => _selectedStatus = null);
                          setState(() => _selectedStatus = null);
                        },
                      ),
                      ...GrievanceStatus.values.map((status) {
                        return FilterChip(
                          label: Text(status.name),
                          selected: _selectedStatus == status,
                          onSelected: (selected) {
                            setModalState(() =>
                                _selectedStatus = selected ? status : null);
                            setState(() =>
                                _selectedStatus = selected ? status : null);
                          },
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Sort By
                  Text(
                    'Sort By',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      ChoiceChip(
                        label: const Text('Date'),
                        selected: _sortBy == 'date',
                        onSelected: (selected) {
                          setModalState(() => _sortBy = 'date');
                          setState(() => _sortBy = 'date');
                        },
                      ),
                      ChoiceChip(
                        label: const Text('Status'),
                        selected: _sortBy == 'status',
                        onSelected: (selected) {
                          setModalState(() => _sortBy = 'status');
                          setState(() => _sortBy = 'status');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedStatus = null;
                              _sortBy = 'date';
                            });
                            Navigator.pop(context);
                          },
                          child: const Text('Clear All'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Apply'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}