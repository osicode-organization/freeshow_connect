class PortStatusEntity {
  final bool isOpen;
  final int? responseTime;
  final String? error;
  final DateTime lastChecked;

  PortStatusEntity({
    required this.isOpen,
    this.responseTime,
    this.error,
    required this.lastChecked,
  });
}
