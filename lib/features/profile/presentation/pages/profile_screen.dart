import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import '../../profile_widgets/additional_links_section_widget.dart';
import '../../profile_widgets/language_setting_widget.dart';
import '../../profile_widgets/logout_button_widget.dart';
import '../../profile_widgets/profile_menu_section_widget.dart';
import '../../profile_widgets/switch_settings_section_widget.dart';
import '../../profile_widgets/user_info_header_widget.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback? onAppBarBackPressed;

  const ProfileScreen({Key? key, this.onAppBarBackPressed}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _textStyles = RobotoTextStyles();

  Map<String, String> _dummyUser = {
    'name': 'Thomas K. Wilson',
    'phoneNumber': '(+44) 20 1234 5629',
    'email': 'thomas.abc.inc@gmail.com',
    'avatarPath': 'assets/images/profile_avatar.png',
  };

  String _selectedLanguage = 'English';
  bool _pushNotification = true;
  bool _darkMode = false;
  bool _sound = true;
  bool _automaticallyUpdated = false;

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            AppStrings.logoutConfirmation,
            style: _textStyles.semiBold(
              fontSize: 16,
              color: AppColors.neutral900,
            ),
          ),
          content: Text(
            AppStrings.areYouSureLogout,
            style: _textStyles.regular(
              fontSize: 14,
              color: AppColors.neutral700,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                AppStrings.cancel,
                style: _textStyles.medium(
                  fontSize: 14,
                  color: AppColors.neutral600,
                ),
              ),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary500,
              ),
              child: Text(
                AppStrings.yes,
                style: _textStyles.medium(fontSize: 14, color: AppColors.white),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                print("User logged out (simulated)");
              },
            ),
          ],
        );
      },
    );
  }

  void _handleEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditProfileScreen()),
    );
    if (result != null && result is Map<String, String> && mounted) {
      setState(() {
        _dummyUser = Map.from(result);
      });
    } else if (result == true && mounted) {
      setState(() {});
    }
  }

  void _showMoreOptions() {
    print("More options (three dots) pressed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral100,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800),
          onPressed:
              widget.onAppBarBackPressed ?? () => Navigator.maybePop(context),
        ),
        title: Text(
          AppStrings.profile,
          style: _textStyles.semiBold(
            color: AppColors.neutral900,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: AppColors.neutral800),
            onPressed: _showMoreOptions,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: AppResponsive.height(20)),
            UserInfoHeaderWidget(
              name: _dummyUser['name']!,
              phoneNumber: _dummyUser['phoneNumber']!,
              email: _dummyUser['email']!,
              avatarPath: _dummyUser['avatarPath'],
              onEditProfile: _handleEditProfile,
            ),
            SizedBox(height: AppResponsive.height(16)),
            LogoutButtonWidget(onLogout: _handleLogout),
            SizedBox(height: AppResponsive.height(24)),
            const ProfileMenuSectionWidget(),
            SizedBox(height: AppResponsive.height(24)),
            LanguageSettingWidget(
              selectedLanguage: _selectedLanguage,
              onLanguageChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedLanguage = newValue;
                  });
                }
              },
            ),
            SizedBox(height: AppResponsive.height(16)),
            SwitchSettingsSectionWidget(
              pushNotificationValue: _pushNotification,
              onPushNotificationChanged:
                  (val) => setState(() => _pushNotification = val),
              darkModeValue: _darkMode,
              onDarkModeChanged: (val) => setState(() => _darkMode = val),
              soundValue: _sound,
              onSoundChanged: (val) => setState(() => _sound = val),
              autoUpdateValue: _automaticallyUpdated,
              onAutoUpdateChanged:
                  (val) => setState(() => _automaticallyUpdated = val),
            ),
            SizedBox(height: AppResponsive.height(24)),
            const AdditionalLinksSectionWidget(),
            SizedBox(height: AppResponsive.height(30)),
          ],
        ),
      ),
    );
  }
}
