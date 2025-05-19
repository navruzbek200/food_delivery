import 'package:flutter/material.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';

class CategoryItemsScreen extends StatefulWidget {
  final String categoryName;
  final String categoryIconPath;

  const CategoryItemsScreen({
    Key? key,
    required this.categoryName,
    required this.categoryIconPath,
    // this.onAppBarBackPressed,
  }) : super(key: key);

  @override
  State<CategoryItemsScreen> createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  final _textStyles = RobotoTextStyles();


  @override
  void initState() {
    super.initState();
  }


  void _onSearchChanged(String query) {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSvg = widget.categoryIconPath.toLowerCase().endsWith('.svg');

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        shadowColor: AppColors.neutral100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: AppResponsive.width(28),
              height: AppResponsive.height(28),
              child: isSvg
                  ? Image.asset(widget.categoryIconPath)
                  : Image.asset(widget.categoryIconPath),
            ),
            SizedBox(width: AppResponsive.width(8)),
            Text(
              widget.categoryName,
              style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppResponsive.width(24),
                vertical: AppResponsive.height(16)),
            child: SizedBox(
              height: AppResponsive.height(48),
              child: TextField(
                onChanged: _onSearchChanged,
                style: _textStyles.regular(color: AppColors.textPrimary, fontSize: 14),
                decoration: InputDecoration(
                  hintText: "${AppStrings.search} ${widget.categoryName}",
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
                      onPressed: () {  },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                  filled: true,
                  fillColor: AppColors.neutral50,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12)), borderSide: BorderSide.none,),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12)), borderSide: BorderSide.none,),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12)), borderSide: BorderSide(color: AppColors.primary300, width: 1.0),),
                  contentPadding: EdgeInsets.symmetric(vertical: AppResponsive.height(10)),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                AppStrings.notFound,
                style: _textStyles.semiBold(color: AppColors.neutral500, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}