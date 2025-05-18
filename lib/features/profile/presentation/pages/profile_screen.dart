import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/features/messages/presentation/pages/messages_screen.dart';
import 'package:food_delivery/features/profile/presentation/pages/invite_friends_screen.dart';
import 'package:food_delivery/features/profile/presentation/pages/security_screen.dart';
import 'package:food_delivery/features/help_center/presentation/pages/help_center_screen.dart';
import 'package:food_delivery/features/profile/presentation/pages/term_of_service_screen.dart';
import 'package:food_delivery/features/profile/presentation/pages/privacy_policy_screen.dart';
import 'package:food_delivery/features/profile/presentation/pages/about_app_screen.dart';
import 'package:food_delivery/features/payment/presentation/pages/payment_methods_screen.dart';
import 'package:food_delivery/features/profile/presentation/pages/my_locations_screen.dart';
import 'package:food_delivery/features/profile/presentation/pages/promotion_information_screen.dart';
import '../../../../core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';


class ProfileScreen extends StatefulWidget {
  final VoidCallback? onAppBarBackPressed;

  const ProfileScreen({Key? key, this.onAppBarBackPressed}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _textStyles = RobotoTextStyles();

  final Map<String, String> _dummyUser = {
    'name': 'Thomas K. Wilson',
    'phoneNumber': '(+44) 20 1234 5629',
    'email': 'thomas.abc.inc@gmail.com',
    'avatarPath': 'assets/images/profile_avatar.png',
  };

  String _selectedLanguage = AppStrings.english;
  bool _pushNotification = true;
  bool _darkMode = false;
  bool _sound = true;
  bool _automaticallyUpdated = false;

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.height(16))),
          title: Text(AppStrings.logoutConfirmation, style: _textStyles.semiBold(fontSize: 16, color: AppColors.textPrimary)),
          content: Text(AppStrings.areYouSureLogout, style: _textStyles.regular(fontSize: 14, color: AppColors.textSecondary)),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actionsPadding: EdgeInsets.only(bottom: AppResponsive.height(16), left: AppResponsive.width(16), right: AppResponsive.width(16)),
          actions: <Widget>[
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.neutral300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.height(25))), padding: EdgeInsets.symmetric(vertical: AppResponsive.height(12)),),
                child: Text(AppStrings.cancel, style: _textStyles.semiBold(fontSize: 14, color: AppColors.textSecondary)),
                onPressed: () => Navigator.of(dialogContext).pop(),
              ),
            ),
            SizedBox(width: AppResponsive.width(12)),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary500, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.height(25))), padding: EdgeInsets.symmetric(vertical: AppResponsive.height(12)),),
                child: Text(AppStrings.yes, style: _textStyles.semiBold(fontSize: 14, color: AppColors.white)),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleEditProfile() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Edit Profile (Not Implemented)")));
  }

  void _showMoreOptions() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("More options (Not Implemented)")));
  }

  void _navigateTo(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral50,
      appBar: AppBar(
        backgroundColor: AppColors.white, elevation: 0.5, shadowColor: AppColors.neutral200.withOpacity(0.7),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800, size: 20), onPressed: widget.onAppBarBackPressed ?? () => Navigator.maybePop(context),),
        title: Text(AppStrings.profile, style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),),
        centerTitle: true,
        actions: [IconButton(icon: const Icon(Icons.more_horiz, color: AppColors.neutral800, size: 24), onPressed: _showMoreOptions,)],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24), vertical: AppResponsive.height(20)),
        children: [
          _buildUserInfoSection(),
          SizedBox(height: AppResponsive.height(16)),
          _buildLogoutButton(),
          SizedBox(height: AppResponsive.height(24)),
          _buildProfileMenuSection1(),
          SizedBox(height: AppResponsive.height(24)),
          _buildLanguageSection(),
          SizedBox(height: AppResponsive.height(16)),
          _buildSwitchSettingsSection(),
          SizedBox(height: AppResponsive.height(24)),
          _buildProfileMenuSection2(),
          SizedBox(height: AppResponsive.height(30)),
        ],
      ),
    );
  }

  Widget _buildSectionContainer({required List<Widget> children}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppResponsive.height(8)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppResponsive.height(16)),
        boxShadow: [BoxShadow(color: AppColors.neutral200.withOpacity(0.6), spreadRadius: 1, blurRadius: 4, offset: const Offset(0, 2),),],
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: children),
    );
  }

  Widget _buildUserInfoSection() {
    return Container(
      padding: EdgeInsets.all(AppResponsive.width(16)),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(AppResponsive.height(16)), boxShadow: [BoxShadow(color: AppColors.neutral200.withOpacity(0.6), spreadRadius: 1, blurRadius: 4, offset: const Offset(0, 2),)],),
      child: Row(
        children: [
          CircleAvatar(
            radius: AppResponsive.width(30),
            backgroundImage: _dummyUser['avatarPath'] != null && _dummyUser['avatarPath']!.isNotEmpty ? AssetImage(_dummyUser['avatarPath']!) as ImageProvider : null,
            backgroundColor: AppColors.neutral100,
            child: _dummyUser['avatarPath'] == null || _dummyUser['avatarPath']!.isEmpty ? Icon(Icons.person_outline, size: AppResponsive.width(28), color: AppColors.neutral500) : null,
          ),
          SizedBox(width: AppResponsive.width(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_dummyUser['name']!, style: _textStyles.semiBold(color: AppColors.textPrimary, fontSize: 18),),
                SizedBox(height: AppResponsive.height(4)),
                Text(_dummyUser['phoneNumber']!, style: _textStyles.regular(color: AppColors.textSecondary, fontSize: 12),),
                SizedBox(height: AppResponsive.height(2)),
                Text(_dummyUser['email']!, style: _textStyles.regular(color: AppColors.textSecondary, fontSize: 12),),
              ],
            ),
          ),
          InkWell(
            onTap: _handleEditProfile, borderRadius: BorderRadius.circular(AppResponsive.width(20)),
            child: Container(padding: EdgeInsets.all(AppResponsive.width(10)), decoration: const BoxDecoration(color: AppColors.primary50, shape: BoxShape.circle,), child: Icon(Icons.edit_outlined, color: AppColors.primary500, size: AppResponsive.width(20))),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return ElevatedButton.icon(
      icon: const Icon(Icons.logout_outlined, color: AppColors.primary500, size: 22),
      label: Text(AppStrings.logout, style: _textStyles.semiBold(color: AppColors.primary500, fontSize: 16),),
      onPressed: _handleLogout,
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary50, elevation: 0, padding: EdgeInsets.symmetric(vertical: AppResponsive.height(16)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12)),), shadowColor: Colors.transparent,),
    );
  }

  Widget _buildProfileMenuSection1() {
    return _buildSectionContainer(
      children: [
        _buildMenuItem(icon: Icons.location_on_outlined, title: AppStrings.myLocations, onTap: () => _navigateTo(MyLocationsScreen(onAppBarBackPressed: widget.onAppBarBackPressed))),
        _buildMenuItem(icon: Icons.local_offer_outlined, title: AppStrings.myPromotions, onTap: () => _navigateTo(const PromotionInformationScreen())),
        _buildMenuItem(icon: Icons.payment_outlined, title: AppStrings.paymentMethods, onTap: () => _navigateTo(PaymentMethodsScreen(onAppBarBackPressed: widget.onAppBarBackPressed))),
        _buildMenuItem(icon: Icons.chat_bubble_outline, title: AppStrings.messages, onTap: () => _navigateTo(MessagesScreen(onAppBarBackPressed: widget.onAppBarBackPressed))),
        _buildMenuItem(icon: Icons.people_alt_outlined, title: AppStrings.inviteFriends, onTap: () => _navigateTo(const InviteFriendsScreen())),
        _buildMenuItem(icon: Icons.security_outlined, title: AppStrings.security, onTap: () => _navigateTo(SecurityScreen(onAppBarBackPressed: widget.onAppBarBackPressed))),
        _buildMenuItem(icon: Icons.help_outline, title: AppStrings.helpCenter, onTap: () => _navigateTo(HelpCenterScreen(onAppBarBackPressed: widget.onAppBarBackPressed)), hasDivider: false),
      ],
    );
  }

  Widget _buildProfileMenuSection2() {
    return _buildSectionContainer(
      children: [
        _buildMenuItem(icon: Icons.article_outlined, title: AppStrings.termOfService, onTap: () => _navigateTo(const TermOfServiceScreen())),
        _buildMenuItem(icon: Icons.privacy_tip_outlined, title: AppStrings.privacyPolicy, onTap: () => _navigateTo(const PrivacyPolicyScreen())),
        _buildMenuItem(icon: Icons.info_outline, title: AppStrings.aboutApp, onTap: () => _navigateTo(const AboutAppScreen()), hasDivider: false),
      ],
    );
  }

  Widget _buildMenuItem({required IconData icon, required String title, required VoidCallback onTap, bool hasDivider = true}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(icon, color: AppColors.neutral700, size: AppResponsive.width(22)),
          title: Text(title, style: _textStyles.regular(color: AppColors.textPrimary, fontSize: 14)),
          trailing: Icon(Icons.arrow_forward_ios, color: AppColors.neutral400, size: AppResponsive.width(16)),
          contentPadding: EdgeInsets.symmetric(vertical: AppResponsive.height(6), horizontal: AppResponsive.width(16)),
          dense: true,
          onTap: onTap,
        ),
        if(hasDivider) Divider(height: 0.5, indent: AppResponsive.width(16+22+16.0), color: AppColors.neutral100, thickness: 0.5,)
      ],
    );
  }

  Widget _buildLanguageSection() {
    return _buildSectionContainer(
        children: [
          ListTile(
            leading: Icon(Icons.language_outlined, color: AppColors.neutral700, size: AppResponsive.width(22)),
            title: Text(AppStrings.language, style: _textStyles.regular(color: AppColors.textPrimary, fontSize: 14)),
            trailing: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedLanguage,
                icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.neutral500),
                elevation: 2,
                style: _textStyles.regular(color: AppColors.primary500, fontSize: 14),
                onChanged: (String? newValue) {
                  if (newValue != null) { setState(() { _selectedLanguage = newValue; });}
                },
                items: <String>[AppStrings.english, AppStrings.uzbek, AppStrings.russian]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
              ),
            ),
            contentPadding: EdgeInsets.only(left: AppResponsive.width(16), right: AppResponsive.width(16), top: AppResponsive.height(6), bottom: AppResponsive.height(6)),
            dense: true,
          ),
        ]
    );
  }

  Widget _buildSwitchSettingsSection() {
    return _buildSectionContainer(
      children: [
        _buildSwitchItem(iconAssetPathOrData: Icons.notifications_active_outlined, title: AppStrings.pushNotification, value: _pushNotification, onChanged: (val) => setState(() => _pushNotification = val)),
        _buildSwitchItem(iconAssetPathOrData: Icons.dark_mode_outlined, title: AppStrings.darkMode, value: _darkMode, onChanged: (val) => setState(() => _darkMode = val)),
        _buildSwitchItem(iconAssetPathOrData: Icons.volume_up_outlined, title: AppStrings.sound, value: _sound, onChanged: (val) => setState(() => _sound = val)),
        _buildSwitchItem(iconAssetPathOrData: Icons.update_outlined, title: AppStrings.automaticallyUpdated, value: _automaticallyUpdated, onChanged: (val) => setState(() => _automaticallyUpdated = val), hasDivider: false),
      ],
    );
  }

  Widget _buildSwitchItem({required dynamic iconAssetPathOrData, required String title, required bool value, required ValueChanged<bool> onChanged, bool hasDivider = true}) {
    Widget leadingIcon;
    if (iconAssetPathOrData is IconData) {
      leadingIcon = Icon(iconAssetPathOrData, color: AppColors.neutral700, size: AppResponsive.width(22));
    } else if (iconAssetPathOrData is String) {
      if (iconAssetPathOrData.toLowerCase().endsWith('.svg')) {
        leadingIcon = Image.asset(iconAssetPathOrData, color: AppColors.neutral700, width: AppResponsive.width(22), height: AppResponsive.width(22));
      } else {
        leadingIcon = Image.asset(iconAssetPathOrData, color: AppColors.neutral700, width: AppResponsive.width(22), height: AppResponsive.width(22));
      }
    } else {
      leadingIcon = SizedBox(width: AppResponsive.width(22));
    }

    return Column(
      children: [
        ListTile(
          leading: leadingIcon,
          title: Text(title, style: _textStyles.regular(color: AppColors.textPrimary, fontSize: 14)),
          trailing: Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary500,
            inactiveThumbColor: AppColors.neutral300,
            inactiveTrackColor: AppColors.neutral200.withOpacity(0.5),
            activeTrackColor: AppColors.primary500.withOpacity(0.4),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          contentPadding: EdgeInsets.only(left: AppResponsive.width(16), right:AppResponsive.width(8), top: AppResponsive.height(2), bottom: AppResponsive.height(2)),
          dense: true,
        ),
        if(hasDivider) Divider(height: 0.5, indent: AppResponsive.width(16+22+16.0), color: AppColors.neutral100, thickness: 0.5,)
      ],
    );
  }
}