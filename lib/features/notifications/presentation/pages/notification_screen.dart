import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/notification_item.dart';
import '../../domain/entities/notification_type.dart';
import '../widgets/notification_item_card.dart';
import '../widgets/notification_group_header.dart';
import '../widgets/notification_search_bar.dart';

class NotificationScreen extends StatefulWidget {
  final VoidCallback? onAppBarBackPressed;

  const NotificationScreen({Key? key, this.onAppBarBackPressed})
    : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _textStyles = RobotoTextStyles();
  String _searchText = "";

  final List<NotificationItem> _allNotifications = [
    NotificationItem(
      id: '1',
      type: NotificationType.discount,
      title: 'Get 20% Discount Code',
      subtitle: 'Get discount codes from sharing with friends.',
      dateTime: DateTime.now().subtract(const Duration(minutes: 10)),
      isRead: false,
    ),
    NotificationItem(
      id: '2',
      type: NotificationType.discount,
      title: 'Get 10% Discount Code',
      subtitle: 'Holiday discount code.',
      dateTime: DateTime.now().subtract(const Duration(hours: 1, minutes: 20)),
      isRead: false,
    ),
    NotificationItem(
      id: '3',
      type: NotificationType.orderReceived,
      title: 'Order Received',
      subtitle: 'Order #SP_0023900 has been delivered successfully.',
      dateTime: DateTime.now().subtract(const Duration(hours: 2, minutes: 15)),
    ),
    NotificationItem(
      id: '4',
      type: NotificationType.orderOnTheWay,
      title: 'Order on the Way',
      subtitle: 'Your delivery driver is on the way with your order.',
      dateTime: DateTime.now().subtract(const Duration(hours: 2, minutes: 20)),
    ),
    NotificationItem(
      id: '5',
      type: NotificationType.orderConfirmed,
      title: 'Your Order is Confirmed',
      subtitle: 'Your order #SP_0023900 has been confirmed.',
      dateTime: DateTime.now().subtract(const Duration(hours: 2, minutes: 31)),
    ),
    NotificationItem(
      id: '6',
      type: NotificationType.orderSuccessful,
      title: 'Order Successful',
      subtitle: 'Order #SP_0023900 has been placed successfully.',
      dateTime: DateTime.now().subtract(const Duration(hours: 2, minutes: 34)),
      isRead: true,
    ),
    NotificationItem(
      id: '7',
      type: NotificationType.orderCancelled,
      title: 'Order Cancelled',
      subtitle: 'Order #SP_0023450 has been cancelled.',
      dateTime: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
    ),
    NotificationItem(
      id: '8',
      type: NotificationType.accountSetup,
      title: 'Account Setup Successful',
      subtitle: 'Congratulations! Your account setup was successful.',
      dateTime: DateTime.now().subtract(
        const Duration(days: 1, hours: 3, minutes: 15),
      ),
      isRead: true,
    ),
    NotificationItem(
      id: '9',
      type: NotificationType.cardConnected,
      title: 'Credit Card Connected',
      subtitle:
          'Congratulations! Your credit card has been successfully added.',
      dateTime: DateTime.now().subtract(
        const Duration(days: 1, hours: 3, minutes: 20),
      ),
    ),
    NotificationItem(
      id: '10',
      type: NotificationType.discount,
      title: 'Get 5% Discount Code',
      subtitle: 'Discount code for new users.',
      dateTime: DateTime.now().subtract(
        const Duration(days: 1, hours: 10, minutes: 20),
      ),
      isRead: false,
    ),
  ];

  List<NotificationItem> _filteredNotifications = [];
  Map<String, List<NotificationItem>> _groupedNotifications = {};

  @override
  void initState() {
    super.initState();
    _filterAndGroupNotifications();
  }

  void _filterAndGroupNotifications({String query = ""}) {
    setState(() {
      _searchText = query.toLowerCase();
      if (_searchText.isEmpty) {
        _filteredNotifications = List.from(_allNotifications);
      } else {
        _filteredNotifications =
            _allNotifications.where((notification) {
              final titleMatch = notification.title.toLowerCase().contains(
                _searchText,
              );
              final subtitleMatch =
                  notification.subtitle?.toLowerCase().contains(_searchText) ??
                  false;
              return titleMatch || subtitleMatch;
            }).toList();
      }
      _sortAndGroup();
    });
  }

  void _sortAndGroup() {
    _filteredNotifications.sort((a, b) => b.dateTime.compareTo(a.dateTime));

    Map<String, List<NotificationItem>> tempGrouped = {};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    for (var notification in _filteredNotifications) {
      String groupKey;
      final notificationDate = DateTime(
        notification.dateTime.year,
        notification.dateTime.month,
        notification.dateTime.day,
      );

      if (notificationDate == today) {
        groupKey = AppStrings.today;
      } else if (notificationDate == yesterday) {
        groupKey = AppStrings.yesterday;
      } else {
        groupKey = DateFormat('dd MMM yyyy').format(notification.dateTime);
      }

      tempGrouped.putIfAbsent(groupKey, () => []).add(notification);
    }

    List<String> sortedKeys = tempGrouped.keys.toList();
    sortedKeys.sort((a, b) {
      if (a == AppStrings.today) return -1;
      if (b == AppStrings.today) return 1;
      if (a == AppStrings.yesterday) return -1;
      if (b == AppStrings.yesterday) return 1;
      try {
        DateTime dateA = DateFormat('dd MMM yyyy').parse(a);
        DateTime dateB = DateFormat('dd MMM yyyy').parse(b);
        return dateB.compareTo(dateA);
      } catch (e) {
        return 0;
      }
    });

    _groupedNotifications = {
      for (var key in sortedKeys) key: tempGrouped[key]!,
    };
  }

  void _markAsRead(NotificationItem item) {
    if (!item.isRead) {
      setState(() {
        item.isRead = true;
        final indexInAll = _allNotifications.indexWhere((n) => n.id == item.id);
        if (indexInAll != -1) {
          _allNotifications[indexInAll].isRead = true;
        }
      });
      print("Notification '${item.title}' marked as read.");
    }
  }

  void _handleMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.done_all),
                title: const Text('Mark all as read'),
                onTap: () {
                  _markAllAsRead();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings_outlined),
                title: const Text('Notification settings'),
                onTap: () {
                  Navigator.pop(context);
                  print("Navigate to Notification Settings");
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _markAllAsRead() {
    bool changed = false;
    for (var notification in _allNotifications) {
      if (!notification.isRead) {
        notification.isRead = true;
        changed = true;
      }
    }
    if (changed && mounted) {
      setState(() {});
      print("All notifications marked as read.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800),
          onPressed: widget.onAppBarBackPressed,
        ),
        title: Text(
          AppStrings.notification,
          style: _textStyles.semiBold(
            color: AppColors.neutral900,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: AppColors.neutral800),
            onPressed: _handleMoreOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          NotificationSearchBar(
            onChanged: (query) => _filterAndGroupNotifications(query: query),
            onFilterPressed: () {
              print("Filter button in NotificationScreen tapped");
            },
          ),
          Expanded(child: _buildNotificationList()),
        ],
      ),
    );
  }

  Widget _buildNotificationList() {
    if (_searchText.isNotEmpty && _filteredNotifications.isEmpty) {
      return Center(
        child: Text(
          AppStrings.notFound,
          style: _textStyles.semiBold(
            color: AppColors.neutral500,
            fontSize: 20,
          ),
        ),
      );
    }
    if (_allNotifications.isEmpty && _searchText.isEmpty) {
      return Center(
        child: Text(
          AppStrings.empty,
          style: _textStyles.semiBold(
            color: AppColors.neutral500,
            fontSize: 20,
          ),
        ),
      );
    }

    List<Widget> listItems = [];
    _groupedNotifications.forEach((groupTitle, notificationsInGroup) {
      listItems.add(NotificationGroupHeader(title: groupTitle));
      listItems.addAll(
        notificationsInGroup.map(
          (item) => NotificationItemCard(
            item: item,
            onTap: () {
              _markAsRead(item);
              print("Tapped on notification: ${item.title}");
            },
          ),
        ),
      );
    });

    if (listItems.isEmpty && _searchText.isEmpty) {
      return Center(
        child: Text(
          AppStrings.empty,
          style: _textStyles.semiBold(
            color: AppColors.neutral500,
            fontSize: 20,
          ),
        ),
      );
    }

    return ListView(
      padding: EdgeInsets.only(bottom: AppResponsive.height(16)),
      children: listItems,
    );
  }
}
