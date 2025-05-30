import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/features/category/presentation/bloc/category_event.dart';
import 'package:food_delivery/features/category/presentation/bloc/category_foods/category_foods_bloc.dart';
import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';
import '../bloc/category_foods/category_foods_state.dart';

class CategoryItemsScreen extends StatefulWidget {
  final int category_id;
  final String categoryName;
  final String categoryIconPath;

  const CategoryItemsScreen({
    Key? key,
    required this.category_id,
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
    context.read<CategoryFoodsBloc>().add(
      CategoryFoodsEvent(id: widget.category_id),
    );
  }

  void _onSearchChanged(String query) {
    setState(() {});
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
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.neutral800,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: AppResponsive.width(28),
              height: AppResponsive.height(28),
              child:
                  isSvg
                      ? Image.asset(widget.categoryIconPath)
                      : Image.asset(widget.categoryIconPath),
            ),
            SizedBox(width: AppResponsive.width(8)),
            Text(
              widget.categoryName,
              style: _textStyles.semiBold(
                color: AppColors.neutral900,
                fontSize: 18,
              ),
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
              vertical: AppResponsive.height(16),
            ),
            child: SizedBox(
              height: AppResponsive.height(48),
              child: TextField(
                onChanged: _onSearchChanged,
                style: _textStyles.regular(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: "${AppStrings.search} ${widget.categoryName}",
                  hintStyle: _textStyles.regular(
                    color: AppColors.neutral400,
                    fontSize: 14,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(
                      left: AppResponsive.width(12),
                      right: AppResponsive.width(8),
                    ),
                    child: Icon(
                      Icons.search,
                      color: AppColors.neutral500,
                      size: AppResponsive.height(22),
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 0,
                    minHeight: 0,
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(
                      left: AppResponsive.width(8),
                      right: AppResponsive.width(12),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.tune_outlined,
                        color: AppColors.primary500,
                        size: AppResponsive.height(22),
                      ),
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                  filled: true,
                  fillColor: AppColors.neutral50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppResponsive.height(12),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppResponsive.height(12),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppResponsive.height(12),
                    ),
                    borderSide: BorderSide(
                      color: AppColors.primary300,
                      width: 1.0,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: AppResponsive.height(10),
                  ),
                ),
              ),
            ),
          ),

          BlocBuilder<CategoryFoodsBloc, CategoryFoodsState>(
            builder: (context, state) {
              if (state is CategoryFoodsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CategoryFoodsLoaded) {
                final foods = state.category;
                if (foods == null || foods == foods.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        AppStrings.notFound,
                        style: _textStyles.semiBold(
                          color: AppColors.neutral500,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else {
                  //     return Expanded(
                  //       child: GridView.builder(
                  //         padding: const EdgeInsets.all(16),
                  //         itemCount: state.category.length,
                  //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //           crossAxisCount: 2,
                  //           childAspectRatio: 0.68,
                  //           mainAxisSpacing: 16,
                  //           crossAxisSpacing: 16,
                  //         ),
                  //         itemBuilder: (context, index) {
                  //           final food = state.category[index];
                  //           return GestureDetector(
                  //             onTap: () {},
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color: AppColors.white,
                  //                 borderRadius: BorderRadius.circular(16),
                  //                 boxShadow: [
                  //                   BoxShadow(
                  //                     color: AppColors.neutral200,
                  //                     blurRadius: 6,
                  //                     offset: Offset(0, 2),
                  //                   ),
                  //                 ],
                  //               ),
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Stack(
                  //                     children: [
                  //                       ClipRRect(
                  //                         borderRadius: const BorderRadius.only(
                  //                           topLeft: Radius.circular(16),
                  //                           topRight: Radius.circular(16),
                  //                         ),
                  //                         child: Image.network(
                  //                           food.img_url,
                  //                           height: 130,
                  //                           width: double.infinity,
                  //                           fit: BoxFit.cover,
                  //                           errorBuilder: (
                  //                             context,
                  //                             error,
                  //                             stackTrace,
                  //                           ) {
                  //                             return Container(
                  //                               height: 130,
                  //                               color: AppColors.neutral200,
                  //                               child: const Icon(
                  //                                 Icons.broken_image,
                  //                                 size: 40,
                  //                               ),
                  //                             );
                  //                           },
                  //                         ),
                  //                       ),
                  //                       Positioned(
                  //                         top: 8,
                  //                         right: 8,
                  //                         child: Container(
                  //                           decoration: BoxDecoration(
                  //                             color: Colors.black.withOpacity(0.5),
                  //                             shape: BoxShape.circle,
                  //                           ),
                  //                           child: const Padding(
                  //                             padding: EdgeInsets.all(6.0),
                  //                             child: Icon(
                  //                               Icons.favorite_border,
                  //                               color: Colors.white,
                  //                               size: 18,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //
                  //                   Padding(
                  //                     padding: const EdgeInsets.symmetric(
                  //                       horizontal: 8,
                  //                       vertical: 4,
                  //                     ),
                  //                     child: Column(
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.start,
                  //                       children: [
                  //                         Text(
                  //                           food.name,
                  //                           style: _textStyles.semiBold(
                  //                             color: AppColors.neutral700,
                  //                             fontSize: 14,
                  //                           ),
                  //                           maxLines: 1,
                  //                           overflow: TextOverflow.ellipsis,
                  //                         ),
                  //                         const SizedBox(height: 4),
                  //                         Text(
                  //                           ("\$${food.price}"),
                  //                           style: _textStyles.bold(
                  //                             color: AppColors.primary500,
                  //                             fontSize: 14,
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                   // Text(food.name),
                  //                   // Text("\$${food.price}"),
                  //                 ],
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //       ),
                  //     );
                  return Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: foods.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.68,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                      itemBuilder: (context, index) {
                        final food = foods[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                    child: AspectRatio(
                                      aspectRatio: 1.1,
                                      child: Image.network(
                                        food.img_url,
                                        height: 130,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return Container(
                                            height: 130,
                                            color: Colors.grey[200],
                                            child: const Icon(
                                              Icons.broken_image,
                                              size: 40,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.neutral200,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Name
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                child: Text(
                                  food.name,
                                  style: _textStyles.semiBold(
                                    color: AppColors.neutral700,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // Rating
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: AppColors.secondary500,
                                      size: 16,
                                    ),
                                    SizedBox(width: 4),
                                    Text("4.9"),
                                    const SizedBox(width: 4),
                                  ],
                                ),
                              ),
                              // const Spacer(),
                              // Price
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "\$${food.price}",
                                      style: _textStyles.bold(
                                        fontSize: 16,
                                        color: AppColors.primary500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              } else if (state is CategoryFoodsError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox.shrink();
            },
          ),
          // Expanded(
          //   child: Center(
          //     child: Text(
          //       AppStrings.notFound,
          //       style: _textStyles.semiBold(
          //         color: AppColors.neutral500,
          //         fontSize: 20,
          //       ),
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
