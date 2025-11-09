import 'package:flutter/material.dart';
import '../models/service_item.dart';
import '../data/app_store.dart';

class ServicesScreen extends StatefulWidget {
  final bool isWorker;

  const ServicesScreen({super.key, required this.isWorker});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final List<String> _allServices = [
    'Plumbing',
    'Electrical',
    'Cleaning',
    'Painting',
  ];

  Future<ServiceItem?> _openEditDialog({ServiceItem? existing}) async {
    final titleCtrl = TextEditingController(text: existing?.title ?? '');
    final descCtrl = TextEditingController(text: existing?.description ?? '');
    final locCtrl = TextEditingController(text: existing?.location ?? '');
    final hoursCtrl = TextEditingController(
      text: existing?.availabilityHours ?? '',
    );
    final currentLocCtrl = TextEditingController(
      text: existing?.currentLocation ?? '',
    );
    final typeCtrl = TextEditingController(text: existing?.serviceType ?? '');
    String? image = existing?.imageUrl;

    return showDialog<ServiceItem>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(existing == null ? 'Add Service' : 'Edit Service'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleCtrl,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descCtrl,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: locCtrl,
                decoration: const InputDecoration(labelText: 'Location (city)'),
              ),
              TextField(
                controller: hoursCtrl,
                decoration: const InputDecoration(
                  labelText: 'Availability hours',
                ),
              ),
              TextField(
                controller: currentLocCtrl,
                decoration: const InputDecoration(
                  labelText: 'Current location',
                ),
              ),
              TextField(
                controller: typeCtrl,
                decoration: const InputDecoration(labelText: 'Service type'),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      // lightweight image input: ask for an image URL
                      final url = await showDialog<String>(
                        context: context,
                        builder: (c) {
                          final ctrl = TextEditingController();
                          return AlertDialog(
                            title: const Text('Image URL'),
                            content: TextField(
                              controller: ctrl,
                              decoration: const InputDecoration(
                                labelText: 'Image URL',
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(c).pop(),
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.of(c).pop(ctrl.text),
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                      if (url != null && url.isNotEmpty) image = url;
                    },
                    icon: const Icon(Icons.image),
                    label: const Text('Add Image'),
                  ),
                  const SizedBox(width: 8),
                  if (image != null)
                    const Text(
                      'Image set',
                      style: TextStyle(color: Colors.green),
                    ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final t = titleCtrl.text.trim();
              if (t.isEmpty) return;
              final item = ServiceItem(
                id:
                    existing?.id ??
                    DateTime.now().millisecondsSinceEpoch.toString(),
                title: t,
                description: descCtrl.text,
                location: locCtrl.text,
                availabilityHours: hoursCtrl.text,
                currentLocation: currentLocCtrl.text,
                serviceType: typeCtrl.text,
                imageUrl: image,
              );
              Navigator.of(context).pop(item);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _addService() async {
    final res = await _openEditDialog();
    if (res != null) {
      setState(() => AppStore.addService(res));
    }
  }

  void _editService(int index) async {
    final existing = AppStore.availableServices[index];
    final res = await _openEditDialog(existing: existing);
    if (res != null) {
      setState(() => AppStore.updateService(index, res));
    }
  }

  void _deleteService(int index) {
    setState(() => AppStore.removeService(index));
  }

  @override
  Widget build(BuildContext context) {
    final list = AppStore.availableServices;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Services We Offer',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _allServices.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) => Chip(label: Text(_allServices[i])),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.isWorker ? 'Your Services' : 'Available Services',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (widget.isWorker)
                  ElevatedButton.icon(
                    onPressed: _addService,
                    icon: const Icon(Icons.add),
                    label: const Text('Add'),
                  ),
              ],
            ),

            const SizedBox(height: 8),

            Expanded(
              child: list.isEmpty
                  ? const Center(child: Text('No services yet.'))
                  : ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, i) {
                        final s = list[i];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (s.imageUrl != null)
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(8),
                                  ),
                                  child: Image.network(
                                    s.imageUrl!,
                                    height: 140,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const SizedBox(
                                          height: 140,
                                          child: Center(
                                            child: Icon(Icons.broken_image),
                                          ),
                                        ),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      s.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(s.description),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Location: ${s.location} • Hours: ${s.availabilityHours}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if (!widget.isWorker)
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              AppStore.addToCart(s);
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    '${s.title} added to cart',
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.add_shopping_cart,
                                            ),
                                            label: const Text('Add to Cart'),
                                          ),
                                        if (!widget.isWorker)
                                          const SizedBox(width: 8),
                                        if (!widget.isWorker)
                                          ElevatedButton(
                                            onPressed: () async {
                                              final success =
                                                  await AppStore.buy(
                                                    context,
                                                    s,
                                                  );
                                              if (success && context.mounted) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Purchased ${s.title}',
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            child: const Text('Buy'),
                                          ),
                                        if (widget.isWorker)
                                          ElevatedButton(
                                            onPressed: () {
                                              AppStore.offerJob(s);
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Job offered: ${s.title}',
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Text('Offer Job'),
                                          ),
                                        if (widget.isWorker)
                                          const SizedBox(width: 8),
                                        if (widget.isWorker)
                                          IconButton(
                                            onPressed: () => _editService(i),
                                            icon: const Icon(Icons.edit),
                                          ),
                                        if (widget.isWorker)
                                          IconButton(
                                            onPressed: () => _deleteService(i),
                                            icon: const Icon(Icons.delete),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
