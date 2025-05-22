import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import '../../../../../core/common/text_styles/name_textstyles.dart';


class PromoBannersWidget extends StatelessWidget {
  final List<Map<String, dynamic>> promoBannersData;

  const PromoBannersWidget({
    Key? key,
    required this.promoBannersData,
  }) : super(key: key);

  static final _textStyles = RobotoTextStyles();

  Color _hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = AppResponsive.width(304);
    double cardHeight = AppResponsive.height(144);
    final double borderRadius = AppResponsive.height(16);
    final double listHorizontalPadding = AppResponsive.width(16);
    final double cardInternalPadding = AppResponsive.width(16);

    return Container(
      height: cardHeight,
      margin: EdgeInsets.symmetric(vertical: AppResponsive.height(10)),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: promoBannersData.length,
        padding: EdgeInsets.symmetric(horizontal: listHorizontalPadding),
        itemBuilder: (context, index) {
          final banner = promoBannersData[index];
          final Color line1Color = banner['line1Color'] as Color? ?? AppColors.neutral700;
          final Color line2Color = banner['line2Color'] as Color? ?? AppColors.primary500;
          final Color line3Color = banner['line3Color'] as Color? ?? AppColors.neutral800;
          final Color bgColor = banner['bgColor'] != null
              ? _hexToColor(banner['bgColor'] as String)
              : AppColors.neutral100;

          return Container(
            width: cardWidth,
            height: cardHeight,
            margin: EdgeInsets.only(right: AppResponsive.width(8)),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(borderRadius),
              image: DecorationImage(
                image: AssetImage(banner['image'] as String),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.15),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(cardInternalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    banner['line1'] as String,
                    style: _textStyles.regular(color: line1Color, fontSize: 12),
                  ),
                  SizedBox(height: AppResponsive.height(6)),
                  Text(
                    banner['line2'] as String,
                    style: _textStyles.bold(color: line2Color, fontSize: 20)
                        .copyWith(letterSpacing: -0.5, height: 1.2),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppResponsive.height(4)),
                  Text(
                    banner['line3'] as String,
                    style: _textStyles.semiBold(color: line3Color, fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}