import 'package:flutter/material.dart';
import '../models/service_item.dart';

class AppStore {
  // Shared lists for the demo app
  static final List<ServiceItem> availableServices = [];
  static final List<ServiceItem> cart = [];
  static final List<ServiceItem> orders = [];
  static final List<ServiceItem> jobs = [];

  // User info (would normally come from auth)
  static String? workerName;
  static String? workerPhone;
  static String? customerName;
  static String? customerPhone;
  static bool isWorkerMode = false;

  static void addService(ServiceItem s) => availableServices.add(s);
  static void updateService(int index, ServiceItem s) =>
      availableServices[index] = s;
  static void removeService(int index) => availableServices.removeAt(index);

  static void addToCart(ServiceItem s) => cart.add(s);

  static Future<bool> buy(BuildContext context, ServiceItem s) async {
    final customerInfo = await _getCustomerInfo(context);
    if (customerInfo == null) return false;

    final orderItem = ServiceItem(
      id: s.id,
      title: s.title,
      description: s.description,
      location: s.location,
      availabilityHours: s.availabilityHours,
      currentLocation: s.currentLocation,
      serviceType: s.serviceType,
      imageUrl: s.imageUrl,
      customerName: customerInfo['name'],
      customerPhone: customerInfo['phone'],
      customerLocation: customerInfo['location'],
      workerName: s.workerName,
      workerPhone: s.workerPhone,
    );

    orders.add(orderItem);
    jobs.add(orderItem);
    return true;
  }

  static void offerJob(ServiceItem s) {
    final jobItem = ServiceItem(
      id: s.id,
      title: s.title,
      description: s.description,
      location: s.location,
      availabilityHours: s.availabilityHours,
      currentLocation: s.currentLocation,
      serviceType: s.serviceType,
      imageUrl: s.imageUrl,
      workerName: workerName,
      workerPhone: workerPhone,
    );
    jobs.add(jobItem);
  }

  static void cancelOrder(ServiceItem order) {
    order.isCanceled = true;
    order.canceledBy = isWorkerMode ? workerName : customerName;
  }

  static Future<Map<String, String>?> _getCustomerInfo(
    BuildContext context,
  ) async {
    final formKey = GlobalKey<FormState>();
    String? name, phone, location;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Order Information'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Your Name'),
                validator: (v) => v?.isEmpty == true ? 'Required' : null,
                onSaved: (v) => name = v,
                initialValue: customerName,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (v) => v?.isEmpty == true ? 'Required' : null,
                onSaved: (v) => phone = v,
                initialValue: customerPhone,
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Service Location',
                ),
                validator: (v) => v?.isEmpty == true ? 'Required' : null,
                onSaved: (v) => location = v,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() == true) {
                formKey.currentState?.save();
                Navigator.pop(context, true);
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );

    if (result == true && name != null && phone != null && location != null) {
      customerName = name;
      customerPhone = phone;
      return {
        'name': name ?? '',
        'phone': phone ?? '',
        'location': location ?? '',
      };
    }
    return null;
  }
}
