import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/conversation_item.dart';

class MessagesScreen extends StatefulWidget {
  final VoidCallback? onAppBarBackPressed;

  const MessagesScreen({Key? key, this.onAppBarBackPressed}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final _textStyles = RobotoTextStyles();
  String _searchText = "";

  final List<ConversationItem> _allConversations = [
    ConversationItem(id: '1', correspondentName: 'David Wayne', avatarAssetPath: 'assets/images/avatars/avatar1.png', lastMessage: 'Thanks a bunch! Have a great day! 😊', lastMessageTimestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)), isRead: false,),
    ConversationItem(id: '2', correspondentName: 'Edward Davidson', avatarAssetPath: 'assets/images/avatars/avatar2.png', lastMessage: 'Great, thanks so much! ✍️', lastMessageTimestamp: DateTime.parse('2024-05-09 22:20:00'), isRead: true,),
    ConversationItem(id: '3', correspondentName: 'Angela Kelly', avatarAssetPath: 'assets/images/avatars/avatar3.png', lastMessage: 'Appreciate it! See you soon! 🚀', lastMessageTimestamp: DateTime.parse('2024-05-08 10:45:00'), isRead: false,),
    ConversationItem(id: '4', correspondentName: 'Jean Dare', avatarAssetPath: 'assets/images/avatars/avatar4.png', lastMessage: 'Hooray! 🎉', lastMessageTimestamp: DateTime.parse('2024-05-05 20:10:00'), isRead: true,),
    ConversationItem(id: '5', correspondentName: 'Dennis Borer', avatarAssetPath: 'assets/images/avatars/avatar5.png', lastMessage: 'Your order has been successfully delivered', lastMessageTimestamp: DateTime.parse('2024-05-05 17:02:00'), isRead: true,),
    ConversationItem(id: '6', correspondentName: 'Cayla Rath', avatarAssetPath: 'assets/images/avatars/avatar6.png', lastMessage: 'See you soon!', lastMessageTimestamp: DateTime.parse('2024-05-05 11:20:00'), isRead: false,),
    ConversationItem(id: '7', correspondentName: 'Erin Turcotte', avatarAssetPath: 'assets/images/avatars/avatar7.png', lastMessage: "I'm ready to drop off your delivery. 👍", lastMessageTimestamp: DateTime.parse('2024-05-02 19:35:00'), isRead: true,),
    ConversationItem(id: '8', correspondentName: 'Rodolfo Walter', avatarAssetPath: 'assets/images/avatars/avatar8.png', lastMessage: 'Appreciate it! Hope you enjoy it!', lastMessageTimestamp: DateTime.parse('2024-05-01 07:55:00'), isRead: true,),
  ];

  List<ConversationItem> _filteredConversations = [];

  @override
  void initState() {
    super.initState();
    _applyFilters();
  }

  void _applyFilters() {
    setState(() {
      if (_searchText.isEmpty) {
        _filteredConversations = List.from(_allConversations);
      } else {
        _filteredConversations = _allConversations.where((conv) {
          final nameMatch = conv.correspondentName.toLowerCase().contains(_searchText.toLowerCase());
          final messageMatch = conv.lastMessage.toLowerCase().contains(_searchText.toLowerCase());
          return nameMatch || messageMatch;
        }).toList();
      }
      _filteredConversations.sort((a, b) => b.lastMessageTimestamp.compareTo(a.lastMessageTimestamp));
    });
  }

  void _onSearchChanged(String query) {
    _searchText = query;
    _applyFilters();
  }

  void _showMoreOptions(BuildContext screenContext) {
    showModalBottomSheet(
      context: screenContext,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppResponsive.height(20)),
          topRight: Radius.circular(AppResponsive.height(20)),
        ),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.done_all_outlined, color: AppColors.primary500),
                title: Text(AppStrings.markAllAsRead, style: _textStyles.medium(color: AppColors.white, fontSize: 14.0)),
                onTap: () {
                  Navigator.pop(context);
                  _markAllConversationsAsRead();
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: AppColors.primary500),
                title: Text(AppStrings.deleteAllMessages, style: _textStyles.regular(color: AppColors.primary500, fontSize: 14.0)),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteAllConfirmationDialog(screenContext);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteAllConfirmationDialog(BuildContext screenContext) {
    showDialog(
      context: screenContext,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.height(16))),
          title: Text(AppStrings.deleteAllMessages, style: _textStyles.semiBold(fontSize: 16, color: AppColors.textPrimary)),
          content: Text(AppStrings.areYouSureDeleteAllMessages, style: _textStyles.regular(fontSize: 14, color: AppColors.textSecondary)),
          actions: <Widget>[
            TextButton(
              child: Text(AppStrings.cancel, style: _textStyles.medium(fontSize: 14, color: AppColors.neutral600)),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary500,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.height(8))),
              ),
              child: Text(AppStrings.delete, style: _textStyles.medium(fontSize: 14, color: AppColors.white)),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _deleteAllConversations();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteAllConversations() {
    setState(() {
      _allConversations.clear();
      _applyFilters();
    });
  }

  void _markAllConversationsAsRead() {
    bool changed = false;
    for (var conv in _allConversations) {
      if (!conv.isRead) {
        conv.isRead = true;
        changed = true;
      }
    }
    if (changed && mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        shadowColor: AppColors.neutral200,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800),
          onPressed: widget.onAppBarBackPressed ?? () => Navigator.maybePop(context),
        ),
        title: Text(
          AppStrings.messages,
          style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: AppColors.neutral800),
            onPressed: () => _showMoreOptions(context),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _buildConversationsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppResponsive.width(24),
          vertical: AppResponsive.height(16)),
      child: SizedBox(
        height: AppResponsive.height(42),
        child: TextField(
          onChanged: _onSearchChanged,
          style: _textStyles.regular(color: AppColors.textPrimary, fontSize: 14),
          decoration: InputDecoration(
            hintText: AppStrings.search,
            hintStyle: _textStyles.regular(color: AppColors.neutral400, fontSize: 14),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: AppResponsive.width(12), right: AppResponsive.width(8)),
              child: Icon(Icons.search, color: AppColors.neutral500, size: AppResponsive.height(22)),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            suffixIcon: Padding(
              padding: EdgeInsets.only(left: AppResponsive.width(8), right: AppResponsive.width(12)),
              child: IconButton(
                icon: Icon(Icons.tune_outlined, color: AppColors.primary500, size: AppResponsive.height(22)),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
            suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            filled: true,
            fillColor: AppColors.neutral50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppResponsive.height(12)),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppResponsive.height(12)),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppResponsive.height(12)),
              borderSide: BorderSide(color: AppColors.primary300, width: 1.0),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: AppResponsive.height(10)),
          ),
        ),
      ),
    );
  }

  Widget _buildConversationsList() {
    if (_filteredConversations.isEmpty) {
      return Center(
        child: Text(
          _searchText.isNotEmpty ? AppStrings.notFoundMessages : AppStrings.noMessagesYet,
          style: _textStyles.semiBold(color: AppColors.neutral500, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24), vertical: AppResponsive.height(8)),
      itemCount: _filteredConversations.length,
      itemBuilder: (context, index) {
        final conversation = _filteredConversations[index];
        return ListTile(
          leading: CircleAvatar(
            radius: AppResponsive.width(21),
            backgroundImage: conversation.avatarAssetPath != null && conversation.avatarAssetPath!.isNotEmpty
                ? AssetImage(conversation.avatarAssetPath!)
                : null,
            backgroundColor: AppColors.neutral200,
            child: conversation.avatarAssetPath == null || conversation.avatarAssetPath!.isEmpty
                ? Icon(Icons.person_outline, size: AppResponsive.width(20), color: AppColors.neutral500)
                : null,
          ),
          title: Text(
            conversation.correspondentName,
            style: _textStyles.semiBold(fontSize: 14, color: AppColors.textPrimary),
          ),
          subtitle: Text(
            conversation.lastMessage,
            style: _textStyles.regular(fontSize: 12, color: !conversation.isRead ? AppColors.textPrimary : AppColors.textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat('HH:mm').format(conversation.lastMessageTimestamp),
                style: _textStyles.regular(fontSize: 10, color: AppColors.neutral500),
              ),
              SizedBox(height: AppResponsive.height(4)),
              if (!conversation.isRead)
                Container(
                  width: AppResponsive.width(8),
                  height: AppResponsive.height(8),
                  decoration: const BoxDecoration(
                    color: AppColors.primary500,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          onTap: () {
            if (!conversation.isRead) {
              setState(() {
                conversation.isRead = true;
              });
            }
          },
          contentPadding: EdgeInsets.symmetric(vertical: AppResponsive.height(10)),
        );
      },
      separatorBuilder: (context, index) => Divider(
        height: 1,
        color: AppColors.neutral100,
        indent: AppResponsive.width(58 + 12.0),
        endIndent: AppResponsive.width(0),
      ),
    );
  }
}