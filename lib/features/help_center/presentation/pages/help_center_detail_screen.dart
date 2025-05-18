import 'package:flutter/material.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/features/help_center/domain/entities/help_topic.dart';
import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';

class HelpCenterDetailScreen extends StatelessWidget {
  final HelpTopic topic;

  const HelpCenterDetailScreen({Key? key, required this.topic}) : super(key: key);
  Widget _buildFloatingActionButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: AppResponsive.height(20) + MediaQuery.of(context).padding.bottom,
        right: AppResponsive.width(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'detail_screen_email_fab',
            onPressed: () {
              print("Email FAB on Detail Screen Tapped for topic: ${topic.question}");
            },
            backgroundColor: AppColors.primary50,
            elevation: 2,
            mini: true,
            child: Image.asset(
              'assets/icons/help_center/email_outlined.png',
              width: AppResponsive.width(20),
              height: AppResponsive.width(20),
              color: AppColors.primary500,
            ),
          ),
          SizedBox(height: AppResponsive.height(16)),
          FloatingActionButton(
            heroTag: 'detail_screen_call_fab',
            onPressed: () {
              print("Call FAB on Detail Screen Tapped for topic: ${topic.question}");
            },
            backgroundColor: AppColors.primary50,
            elevation: 2,
            mini: true,
            child: Image.asset(
              'assets/icons/help_center/call_outlined.png',
              width: AppResponsive.width(20),
              height: AppResponsive.width(20),
              color: AppColors.primary500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _textStyles = RobotoTextStyles();
    List<String> answerSteps = topic.answer.split('\n').where((line) => line.trim().isNotEmpty).toList();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        shadowColor: AppColors.neutral200.withOpacity(0.7),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppStrings.help,
          style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppResponsive.width(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              topic.question,
              style: _textStyles.bold(fontSize: 20, color: AppColors.textPrimary),
            ),
            SizedBox(height: AppResponsive.height(20)),
            ...answerSteps.map((step) {
              bool isNumberedStep = RegExp(r"^\d+\.\s+").hasMatch(step);
              String stepText = step.replaceFirst(RegExp(r"^\d+\.\s+"), "");

              return Padding(
                padding: EdgeInsets.only(bottom: AppResponsive.height(isNumberedStep ? 8 : 12)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isNumberedStep)
                      Padding(
                        padding: EdgeInsets.only(right: AppResponsive.width(8)),
                        child: Text(
                          "${RegExp(r"^\d+").firstMatch(step)![0]}.",
                          style: _textStyles.regular(fontSize: 14, color: AppColors.textSecondary,),
                        ),
                      ),
                    Expanded(
                      child: Text(
                        stepText,
                        style: _textStyles.regular(fontSize: 14, color: AppColors.textSecondary,),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            SizedBox(height: AppResponsive.height(80)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _buildFloatingActionButtons(context),
    );
  }
}