import 'package:flutter/material.dart';
import '../data/app_store.dart';
import '../models/service_item.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Widget _buildOrderItem(BuildContext context, ServiceItem s, bool isWorker) {
    final hasCustomerInfo = s.customerName != null && s.customerPhone != null;
    final hasWorkerInfo = s.workerName != null && s.workerPhone != null;
    final isAccepted = s.isAccepted;
    final isCanceled = s.isCanceled;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with service info
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
            title: Text(
              s.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text('${s.location} • ${s.availabilityHours}'),
          ),

          // Status section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isCanceled)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      border: Border.all(color: Colors.red.shade300),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Cancelled by ${s.canceledBy}',
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                else if (isAccepted)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      border: Border.all(color: Colors.green.shade300),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      isWorker
                          ? 'You accepted this order'
                          : 'Worker accepted your order',
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      border: Border.all(color: Colors.blue.shade300),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      isWorker
                          ? 'Pending your response'
                          : 'Pending worker response',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Worker info - shown to clients
          if (!isCanceled && !isWorker && hasWorkerInfo)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Worker Information:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.person, size: 18, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(s.workerName ?? 'N/A'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 18, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(s.workerPhone ?? 'N/A'),
                    ],
                  ),
                ],
              ),
            ),

          // Customer info - shown to workers only after acceptance
          if (!isCanceled && isWorker && isAccepted && hasCustomerInfo)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Customer Information:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.person, size: 18, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(s.customerName ?? 'N/A'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 18, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(s.customerPhone ?? 'N/A'),
                    ],
                  ),
                  if (s.customerLocation != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 18,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Expanded(child: Text(s.customerLocation!)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // Open map screen to show customer location
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Map view not yet available'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.map, size: 18),
                        label: const Text('View Location on Map'),
                      ),
                    ),
                  ],
                ],
              ),
            ),

          // Action buttons
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Worker buttons
                if (isWorker && !isCanceled && !isAccepted) ...[
                  OutlinedButton(
                    onPressed: () {
                      AppStore.rejectOrder(s);
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Order rejected')),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: const Text('Reject'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      AppStore.acceptOrder(s);
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Order accepted!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Accept'),
                  ),
                ],

                // Cancel button for both (if not already canceled)
                if (!isCanceled) ...[
                  if (isWorker && isAccepted) const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: () {
                      AppStore.cancelOrder(s);
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Order cancelled')),
                      );
                    },
                    icon: const Icon(Icons.close, size: 18),
                    label: const Text('Cancel'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                  ),
                ],
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
    final orderList = isWorker ? AppStore.jobs : AppStore.orders;

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
                    fontSize: 28,
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
            child: orderList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isWorker
                              ? Icons.work_outline
                              : Icons.shopping_bag_outlined,
                          size: 64,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          isWorker ? 'No jobs yet' : 'No orders yet',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: orderList.length,
                    itemBuilder: (context, i) {
                      final s = orderList[i];
                      return _buildOrderItem(context, s, isWorker);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
