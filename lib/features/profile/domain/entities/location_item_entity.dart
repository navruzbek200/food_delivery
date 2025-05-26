import 'package:flutter/material.dart';

enum LocationType { home, work, other }

class LocationItem {
  final String id;
  final LocationType type;
  final String label;
  final String fullAddress;
  bool isDefault;

  LocationItem({
    required this.id,
    required this.type,
    required this.label,
    required this.fullAddress,
    this.isDefault = false,
  });

  IconData get icon {
    switch (type) {
      case LocationType.home:
        return Icons.home_outlined;
      case LocationType.work:
        return Icons.work_outline_rounded;
      case LocationType.other:
        return Icons.location_on_outlined;
    }
  }
}