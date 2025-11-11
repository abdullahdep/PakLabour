class ServiceItem {
  String id;
  String title;
  String description;
  String location;
  String availabilityHours;
  String currentLocation;
  String serviceType;
  String? imageUrl;
  bool offered;

  // Order related fields
  String? customerName;
  String? customerPhone;
  String? customerLocation;
  String? workerName;
  String? workerPhone;
  bool isCanceled = false;
  String? canceledBy;

  // Acceptance tracking
  bool isAccepted = false;
  String? acceptedBy;

  ServiceItem({
    required this.id,
    required this.title,
    this.description = '',
    this.location = '',
    this.availabilityHours = '',
    this.currentLocation = '',
    this.serviceType = '',
    this.imageUrl,
    this.offered = false,
    this.customerName,
    this.customerPhone,
    this.customerLocation,
    this.workerName,
    this.workerPhone,
  });
}
