import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';

import '../../../../../core/common/text_styles/name_textstyles.dart';

class OfferCardWidget extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;
  final String? oldPrice;
  final String? rating;
  final bool isLiked;
  final VoidCallback onLikePressed;
  final VoidCallback onTap;

  const OfferCardWidget({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.price,
    this.oldPrice,
    this.rating,
    required this.isLiked,
    required this.onLikePressed,
    required this.onTap,
  }) : super(key: key);

  static final _textStyles = RobotoTextStyles();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppResponsive.height(12)),
      child: SizedBox(
        width: AppResponsive.width(160.5),
        child: Card(
          elevation: 1.5,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppResponsive.height(12)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                          onError: (e, s) => print("Error loading offer image $imagePath: $e"),
                        ),
                      ),
                    ),
                    Positioned(
                      top: AppResponsive.height(6),
                      right: AppResponsive.width(6),
                      child: InkWell(
                        onTap: onLikePressed,
                        borderRadius: BorderRadius.circular(AppResponsive.height(15)),
                        child: Container(
                          padding: EdgeInsets.all(AppResponsive.width(4)),
                          decoration: BoxDecoration(
                            color: AppColors.black.withOpacity(0.35),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? AppColors.primary500 : AppColors.white,
                            size: AppResponsive.height(18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(AppResponsive.width(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text( name, style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis,),
                    SizedBox(height: AppResponsive.height(4)),
                    if (rating != null && rating!.isNotEmpty)
                      Row(children: [ Icon(Icons.star, color: Colors.amber, size: AppResponsive.height(14)), SizedBox(width: AppResponsive.width(4)), Text( rating!, style: _textStyles.regular(color: AppColors.neutral700, fontSize: 12))]),
                    SizedBox(height: AppResponsive.height(6)),
                    Row(children: [ Text( price, style: _textStyles.semiBold(color: AppColors.primary500, fontSize: 14)), SizedBox(width: AppResponsive.width(8)), if (oldPrice != null && oldPrice!.isNotEmpty) Text( oldPrice!, style: _textStyles.regular( color: AppColors.neutral400, fontSize: 12, decoration: TextDecoration.lineThrough),),]),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}