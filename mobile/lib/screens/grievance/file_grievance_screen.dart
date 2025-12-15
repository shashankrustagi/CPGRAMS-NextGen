import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/grievance_model.dart';
import '../../providers/grievance_provider.dart';
import '../../utils/validators.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class FileGrievanceScreen extends ConsumerStatefulWidget {
  const FileGrievanceScreen({super.key});

  @override
  ConsumerState<FileGrievanceScreen> createState() =>
      _FileGrievanceScreenState();
}

class _FileGrievanceScreenState
    extends ConsumerState<FileGrievanceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  String _selectedCategory = 'Public Works';
  bool _isSubmitting = false;

  final List<String> _categories = [
    'Public Works',
    'Water Supply',
    'Electricity',
    'Health',
    'Education',
    'Transportation',
    'Police',
    'Other',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _submitGrievance() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    final grievance = Grievance(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _selectedCategory,
      status: GrievanceStatus.submitted,
      createdAt: DateTime.now(),
      location: _locationController.text.trim(),
    );

    ref.read(grievanceProvider.notifier).addGrievance(grievance);

    setState(() => _isSubmitting = false);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Grievance filed successfully!\nID: ${grievance.id}',
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Grievance'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline,
                          color: Colors.blue.shade700),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Fill in the details below to submit your grievance',
                          style: TextStyle(
                              color: Colors.blue.shade700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Category
              Text('Category *',
                  style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: _categories
                    .map(
                      (c) => DropdownMenuItem(
                        value: c,
                        child: Text(c),
                      ),
                    )
                    .toList(),
                onChanged: (value) =>
                    setState(() => _selectedCategory = value!),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.category),
                ),
              ),
              const SizedBox(height: 20),

              // Title
              CustomTextField(
                label: 'Title',
                hint: 'Brief summary of the issue',
                controller: _titleController,
                validator: Validators.validateTitle,
                prefixIcon: const Icon(Icons.title),
                maxLength: 100,
              ),
              const SizedBox(height: 20),

              // Description
              CustomTextField(
                label: 'Description',
                hint: 'Explain your grievance in detail',
                controller: _descriptionController,
                validator: Validators.validateDescription,
                prefixIcon: const Icon(Icons.description),
                maxLines: 6,
                maxLength: 500,
              ),
              const SizedBox(height: 20),

              // Location
              CustomTextField(
                label: 'Location',
                hint: 'Area / locality',
                controller: _locationController,
                validator: (v) =>
                    Validators.validateRequired(v, 'Location'),
                prefixIcon: const Icon(Icons.location_on),
                maxLength: 100,
              ),
              const SizedBox(height: 32),

              // Submit
              CustomButton(
                text: 'Submit Grievance',
                onPressed: _submitGrievance,
                isLoading: _isSubmitting,
              ),

              const SizedBox(height: 12),

              // Cancel
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),

              const SizedBox(height: 12),
              Text(
                '* All fields are required',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
