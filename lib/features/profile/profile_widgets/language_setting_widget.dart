// file: features/profile/presentation/widgets/language_setting_widget.dart
import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';

class LanguageSettingWidget extends StatelessWidget {
  final String selectedLanguage;
  final ValueChanged<String?> onLanguageChanged;
  final List<String> availableLanguages;

  const LanguageSettingWidget({
    Key? key,
    required this.selectedLanguage,
    required this.onLanguageChanged,
    this.availableLanguages = const ['English', 'O‘zbekcha', 'Русский'],
  }) : super(key: key);

  static final _textStyles = RobotoTextStyles();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(16), vertical: AppResponsive.height(4)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppResponsive.height(12)),
        boxShadow: [ BoxShadow( color: AppColors.neutral200.withOpacity(0.5), spreadRadius: 1, blurRadius: 3, offset: const Offset(0, 1),),],
      ),
      child: ListTile(
        leading: Icon(Icons.language_outlined, color: AppColors.neutral800, size: AppResponsive.width(22)),
        title: Text(AppStrings.language, style: _textStyles.regular(color: AppColors.neutral900, fontSize: 14)),
        trailing: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedLanguage,
            icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.neutral500),
            elevation: 2,
            style: _textStyles.regular(color: AppColors.primary500, fontSize: 14),
            onChanged: onLanguageChanged,
            items: availableLanguages.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
          ),
        ),
        contentPadding: EdgeInsets.zero,
        dense: true,
      ),
    );
  }
}