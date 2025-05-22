import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import '../../../../../core/common/text_styles/name_textstyles.dart';
import '../../pages/special_offers.dart';
import 'offer_card_widget.dart';

class SpecialOffersPreviewWidget extends StatelessWidget {
  final List<Map<String, String>> offersData;
  final Function(int originalIndexInDataSource, bool newLikeState) onLikeToggleInDataSource;
  final Function(Map<String, String> offerData) onItemTap;

  const SpecialOffersPreviewWidget({
    Key? key,
    required this.offersData,
    required this.onLikeToggleInDataSource,
    required this.onItemTap,
  }) : super(key: key);

  static final _textStyles = RobotoTextStyles();

  @override
  Widget build(BuildContext context) {
    const int previewItemCount = 3;
    final List<Map<String, String>> previewOffers =
    offersData.length > previewItemCount
        ? offersData.take(previewItemCount).toList()
        : offersData;

    if (previewOffers.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.specialOffers, style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18)),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SpecialOffersPage()),
                  );
                },
                style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(50, 30), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(AppStrings.viewAll, style: _textStyles.medium(color: AppColors.primary500, fontSize: 14)),
                    SizedBox(width: AppResponsive.width(4)),
                    Icon(Icons.arrow_forward_ios, color: AppColors.primary500, size: AppResponsive.height(14)),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppResponsive.height(16)),
        Container(
          height: AppResponsive.height(190),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: previewOffers.length,
            padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(16)),
            itemBuilder: (context, index) {
              final offer = previewOffers[index];
              bool isLiked = (offer['isLiked']?.toLowerCase() == 'true');

              int originalIndex = offersData.indexWhere((o) => o['name'] == offer['name'] && o['price'] == offer['price']);

              return Padding(
                padding: EdgeInsets.only(right: index < previewOffers.length - 1 ? AppResponsive.width(8) : 0),
                child: OfferCardWidget(
                  imagePath: offer['image']!,
                  name: offer['name']!,
                  price: offer['price']!,
                  oldPrice: offer['oldPrice'],
                  rating: offer['rating'],
                  isLiked: isLiked,
                  onLikePressed: () {
                    if (originalIndex != -1) {
                      onLikeToggleInDataSource(originalIndex, !isLiked);
                    }
                  },
                  onTap: () => onItemTap(offer),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}