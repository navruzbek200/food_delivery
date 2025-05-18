import 'package:flutter/material.dart';
import 'notification_type.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';

class NotificationItem {
  final String id;
  final NotificationType type;
  final String title;
  final String? subtitle;
  final DateTime dateTime;
  bool isRead;
  final String? deepLink;

  NotificationItem({
    required this.id,
    required this.type,
    required this.title,
    this.subtitle,
    required this.dateTime,
    this.isRead = false,
    this.deepLink,
  });

  String get iconAssetPath {
    switch (type) {
      case NotificationType.discount:
        return 'assets/icons/notifications/discount.svg';
      case NotificationType.orderCancelled:
        return 'assets/icons/notifications/order_cancelled.svg';
      case NotificationType.orderConfirmed:
        return 'assets/icons/notifications/order_confirmed.svg';
      case NotificationType.orderOnTheWay:
        return 'assets/icons/notifications/order_on_the_way.svg';
      case NotificationType.orderReceived:
        return 'assets/icons/notifications/order_received.svg';
      case NotificationType.orderSuccessful:
        return 'assets/icons/notifications/order_successful.svg';
      case NotificationType.accountSetup:
        return 'assets/icons/notifications/account_setup.svg';
      case NotificationType.cardConnected:
        return 'assets/icons/notifications/card_connected.svg';
      case NotificationType.general:
      return 'assets/icons/notifications/discount.svg';
    }
  }

  Color get iconBackgroundColor {
    switch (type) {
      case NotificationType.discount:
        return AppColors.secondary50;
      case NotificationType.orderReceived:
      case NotificationType.orderConfirmed:
      case NotificationType.orderOnTheWay:
      case NotificationType.orderSuccessful:
      case NotificationType.accountSetup:
      case NotificationType.cardConnected:
        return AppColors.green50;
      case NotificationType.orderCancelled:
        return AppColors.primary50;
      case NotificationType.general:
        return AppColors.neutral100;
    }
  }

}