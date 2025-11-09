import 'package:flutter/material.dart';
import '../data/app_store.dart';
import '../models/service_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  Widget _buildOrderItem(BuildContext context, ServiceItem s, bool isWorker) {
    final hasCustomerInfo = s.customerName != null && s.customerPhone != null;
    final hasWorkerInfo = s.workerName != null && s.workerPhone != null;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: s.imageUrl != null
                ? Image.network(
                    s.imageUrl!,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.work_outline),
                  )
                : const Icon(Icons.work_outline),
            title: Text(s.title),
            subtitle: Text('${s.location} • ${s.availabilityHours}'),
          ),
          if (s.isCanceled)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Canceled by ${s.canceledBy}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          if (!s.isCanceled && isWorker && hasCustomerInfo)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Customer Information:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text('Name: ${s.customerName}'),
                  Text('Phone: ${s.customerPhone}'),
                  if (s.customerLocation != null)
                    Text('Location: ${s.customerLocation}'),
                ],
              ),
            ),
          if (!s.isCanceled && !isWorker && hasWorkerInfo)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Worker Information:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text('Name: ${s.workerName}'),
                  Text('Phone: ${s.workerPhone}'),
                ],
              ),
            ),
          if (!s.isCanceled)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      AppStore.cancelOrder(s);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Order canceled')),
                      );
                    },
                    child: const Text('Cancel Order'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWorker = AppStore.isWorkerMode;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isWorker ? 'Your Jobs' : 'Your Orders',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isWorker
                      ? 'Services requested by customers'
                      : 'Services you have ordered',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: isWorker
                  ? AppStore.jobs.length
                  : AppStore.orders.length,
              itemBuilder: (context, i) {
                final s = isWorker ? AppStore.jobs[i] : AppStore.orders[i];
                return _buildOrderItem(context, s, isWorker);
              },
            ),
          ),
        ],
      ),
    );
  }
}
