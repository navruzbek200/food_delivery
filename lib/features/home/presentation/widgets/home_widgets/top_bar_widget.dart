import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/features/home/presentation/pages/my_basket_screen.dart';
import '../../../../../core/common/text_styles/name_textstyles.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({Key? key}) : super(key: key);

  static final _textStyles = RobotoTextStyles();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24.0)),
      child: SizedBox(
        height: AppResponsive.height(51),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppStrings.deliverTo, style: _textStyles.regular(color: AppColors.neutral600, fontSize: 14)),
                SizedBox(height: AppResponsive.height(4)),
                InkWell(
                  onTap: () {
                    print("Select location tapped from TopBarWidget");
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(AppStrings.selectYourLocation, style: _textStyles.semiBold(color: AppColors.primary500, fontSize: 16)),
                      SizedBox(width: AppResponsive.width(4)),
                      Icon(Icons.keyboard_arrow_down, color: AppColors.primary500, size: AppResponsive.height(20)),
                    ],
                  ),
                )
              ],
            ),
            IconButton(
              icon: Icon(Icons.shopping_bag_outlined, color: AppColors.neutral800, size: AppResponsive.height(28)),
              onPressed: () {
                print("Cart icon tapped from TopBarWidget");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyBasketScreen(),
                  ),
                );
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}