// lib/features/home/presentation/pages/food_detail.dart
import 'package:flutter/material.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/features/home/presentation/pages/my_basket_screen.dart';

class FoodDetailPage extends StatefulWidget {
  final Map<String, dynamic> foodItem;

  const FoodDetailPage({Key? key, required this.foodItem}) : super(key: key);

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  final _textStyles = RobotoTextStyles();
  late bool _isLiked;
  int _quantity = 1;
  late Map<String, bool> _selectedOptionsState;
  late List<Map<String, dynamic>> _additionalOptionsList;

  bool _showFullDescription = false;

  @override
  void initState() {
    super.initState();

    _isLiked = (widget.foodItem['isLiked']?.toString().toLowerCase() == 'true');

    var rawOptions = widget.foodItem['additionalOptions'];
    if (rawOptions is List) {
      _additionalOptionsList = List<Map<String, dynamic>>.from(
          rawOptions.map((e) {
            if (e is Map<String, dynamic>) {
              return e;
            } else if (e is Map) {
              return Map<String, dynamic>.from(e);
            }
            return <String, dynamic>{};
          }).where((map) => map.isNotEmpty)
      );
    } else {
      _additionalOptionsList = [];
    }

    _selectedOptionsState = {};
    for (var option in _additionalOptionsList) {
      final optionName = option['name'] as String?;
      if (optionName != null) {
        var selectedValue = option['selected'];
        // Agar type 'radio' va selected true bo'lsa, guruhdagi boshqalarni false qilish kerak.
        // Bu logikani UI da _onOptionChanged da qildik, bu yerda faqat boshlang'ich holatni o'rnatamiz.
        _selectedOptionsState[optionName] = (selectedValue == true || selectedValue == 'true');
      }
    }
    // AppBar dagi savat sonini MyBasketPageUI dagi global listdan olish (agar kerak bo'lsa)
    // Bu misolda har safar FoodDetail ochilganda 0 dan boshlanadi.
    // Agar MyBasketPageUI._globalBasketItems dan olmoqchi bo'lsangiz:
    // _appBarBasketItemCount = _MyBasketPageUIState._globalBasketItems.length; // Yoki itemlarning umumiy soni
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      // Bu yerda `widget.foodItem['isLiked']` ni ham o'zgartirish kerak bo'lishi mumkin,
      // agar bu ma'lumot `SpecialOffersPage` ga qaytganda saqlanishi kerak bo'lsa.
      // Masalan: widget.foodItem['isLiked'] = _isLiked.toString();
      // Yoki global state orqali.
    });
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _onOptionChanged(String optionName, bool? newValue, String optionType, String? group) {
    setState(() {
      if (optionType == 'radio' && newValue == true && group != null) {
        // Guruhdagi boshqa radio tugmalarni o'chirish
        for (var option in _additionalOptionsList) {
          if (option['type'] == 'radio' && option['group'] == group && option['name'] != optionName) {
            final otherOptionName = option['name'] as String?;
            if(otherOptionName != null) _selectedOptionsState[otherOptionName] = false;
          }
        }
      }
      _selectedOptionsState[optionName] = newValue ?? false;
    });
  }

  void _addToBasket() {
    List<Map<String, dynamic>> selectedOptionsForBasket = [];
    _selectedOptionsState.forEach((optionName, isSelected) {
      if (isSelected) {
        final optionDetail = _additionalOptionsList.firstWhere(
              (opt) => opt['name'] == optionName,
          orElse: () => {'name': optionName, 'price': '+ £0.00'},
        );
        selectedOptionsForBasket.add({
          'name': optionName,
          'price': optionDetail['price'] as String,
        });
      }
    });

    Map<String, dynamic> itemDataForBasket = {
      'productId': widget.foodItem['name'] as String, // Unikal ID uchun yaxshiroq yechim kerak
      'name': widget.foodItem['name'] as String,
      'image': widget.foodItem['image'] as String,
      'currentPrice': widget.foodItem['price'] as String,
      'oldPrice': widget.foodItem['oldPrice'] as String?,
      'quantityToAdd': _quantity,
      'selectedOptionsDetails': selectedOptionsForBasket,
    };

    // _MyBasketPageUIState static klass nomidan foydalanish uchun my_basket_screen.dart da
    // _MyBasketPageUIState klassini fayldan tashqariga chiqarish kerak emas,
    // lekin addFoodItemToGlobalBasket metodi static bo'lgani uchun chaqirsa bo'ladi.
    // Eng to'g'ri yondashuv - bu metodni alohida service class ga chiqarish.
    // Hozircha to'g'ridan-to'g'ri _MyBasketPageUIState orqali chaqiramiz (agar import to'g'ri bo'lsa).
    // Agar MyBasketPageUI.addFoodItemToGlobalBasket qilib chaqirmoqchi bo'lsangiz, metod MyBasketPageUI class ichida static bo'lishi kerak.

    // Faraz qilaylik, my_basket_screen.dart da _MyBasketPageUIState klassi ichida
    // static addFoodItemToGlobalBasket metodi mavjud.
    // Uni chaqirish uchun to'g'ridan-to'g'ri klass nomini ishlatamiz (agar import qilingan bo'lsa).
    // Bu yaxshi amaliyot emas, lekin so'rovga binoan.
    // MyBasketPageUI._addFoodItemToGlobalBasket(itemDataForBasket); // Agar MyBasketPageUI ichida bo'lsa
// food_detail.dart ichidagi _addToBasket metodida
// ...
    MyBasketScreen.addFoodItemToGlobalBasket(itemDataForBasket);// ...

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.foodItem['name']} savatga qo\'shildi!'),
        backgroundColor: AppColors.primary500,
        duration: const Duration(seconds: 1),
      ),
    );

    // setState(() { // AppBar dagi sonni yangilash uchun (lokal)
    //   _appBarBasketItemCount = _MyBasketPageUIState._globalBasketItems.length;
    // });

    Navigator.pushReplacement( // pushReplacement orqali FoodDetail ni stackdan olib tashlaymiz
      context,
      MaterialPageRoute(builder: (context) => const MyBasketScreen()),
    );
  }


  @override
  Widget build(BuildContext context) {
    String description = widget.foodItem['description'] as String? ?? 'No description available.';
    String displayDescription = description;
    bool canShowMore = false;

    if (!_showFullDescription && description.length > 100) {
      displayDescription = '${description.substring(0, 100)}...';
      canShowMore = true;
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined, color: AppColors.neutral800, size: 28),
                onPressed: () {
                  Navigator.push( // AppBar dagi savat iconi bosilsa ham o'tish
                    context,
                    MaterialPageRoute(builder: (context) => const MyBasketScreen()),
                  );
                },
              ),
              // AppBar dagi savat sonini ko'rsatish uchun _appBarBasketItemCount ni ishlatish mumkin.
              // Hozir bu lokal va faqat shu sahifada o'zgaradi.
              // if (_appBarBasketItemCount > 0)
              // Agar MyBasketPageUI dagi global listdan olmoqchi bo'lsangiz:
              // if (_MyBasketPageUIState._globalBasketItems.isNotEmpty)
              //   Positioned(...)
            ],
          ),
          SizedBox(width: AppResponsive.width(16)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppResponsive.height(20)),
                  Text(
                    widget.foodItem['name'] as String,
                    style: _textStyles.semiBold(
                      color: AppColors.neutral900,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: AppResponsive.height(8)),
                  _buildPriceAndRating(),
                  SizedBox(height: AppResponsive.height(16)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          displayDescription,
                          style: _textStyles.regular(
                            color: AppColors.neutral700,
                            fontSize: 14,
                             // Qatorlar orasidagi masofa
                          ),
                        ),
                      ),
                      if (canShowMore || (_showFullDescription && description.length > 100))
                        Padding(
                          padding: EdgeInsets.only(left: AppResponsive.width(4)),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _showFullDescription = !_showFullDescription;
                              });
                            },
                            child: Text(
                              _showFullDescription ? ' See less' : ' See more',
                              style: _textStyles.medium(
                                color: AppColors.primary500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: AppResponsive.height(24)),
                  if (_additionalOptionsList.isNotEmpty) ...[
                    Text(
                      'Additional Options:', // ':' dan keyin bo'sh joy
                      style: _textStyles.semiBold(
                        color: AppColors.neutral900,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: AppResponsive.height(12)),
                    _buildAdditionalOptionsWidgets(),
                  ],
                  SizedBox(height: AppResponsive.height(100)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: _buildBottomBar(),
    );
  }

  Widget _buildImageSection() {
    return Stack( // Like button uchun Stack
      children: [
        SizedBox(
          height: AppResponsive.height(300),
          width: double.infinity,
          child: Image.asset(
            widget.foodItem['image'] as String,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
            const Center(child: Icon(Icons.broken_image, size: 50, color: AppColors.neutral400)),
          ),
        ),
        Positioned(
          top: AppResponsive.height(16),
          right: AppResponsive.width(16), // Chegaraga yaqinroq
          child: InkWell(
            onTap: _toggleLike,
            child: CircleAvatar(
              backgroundColor: AppColors.white.withOpacity(0.85), // Shaffoflik
              radius: AppResponsive.width(20),
              child: Icon(
                _isLiked ? Icons.favorite : Icons.favorite_border,
                color: _isLiked ? AppColors.primary500 : AppColors.neutral600, // Qizil rang yoqqanda
                size: AppResponsive.width(22), // Icon o'lchami
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceAndRating() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center, // Vertikal tekislash
      children: [
        Text(
          widget.foodItem['price'] as String,
          style: _textStyles.semiBold(
            color: AppColors.primary500,
            fontSize: 20,
          ),
        ),
        if (widget.foodItem['oldPrice'] != null && (widget.foodItem['oldPrice'] as String).isNotEmpty) ...[
          SizedBox(width: AppResponsive.width(8)),
          Text(
            widget.foodItem['oldPrice'] as String,
            style: _textStyles.medium(
              color: AppColors.neutral500,
              fontSize: 14,
            ),
          ),
        ],
        const Spacer(),
        Icon(Icons.star_rounded, color: AppColors.secondary500, size: AppResponsive.width(20)), // Yulduzcha iconi
        SizedBox(width: AppResponsive.width(4)),
        Text(
          widget.foodItem['rating'] as String? ?? 'N/A',
          style: _textStyles.semiBold(
            color: AppColors.neutral900,
            fontSize: 14,
          ),
        ),
        SizedBox(width: AppResponsive.width(4)),
        Text(
          widget.foodItem['reviews'] as String? ?? '(0 reviews)', // Agar reviews yo'q bo'lsa
          style: _textStyles.regular(
            color: AppColors.neutral600,
            fontSize: 14,
          ),
        ),
        SizedBox(width: AppResponsive.width(8)), // "See all review" uchun joy
        InkWell(
          onTap: (){ print("See all review tapped"); },
          child: Text(
            'See all review',
            style: _textStyles.medium(
              color: AppColors.primary500,
              fontSize: 14,// Tagchiziq rangi
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalOptionsWidgets() {
    return Column(
      children: _additionalOptionsList.map((optionMap) {
        final String name = optionMap['name'] as String? ?? 'Unknown Option';
        final String price = optionMap['price'] as String? ?? '+ £0.00';
        final String type = optionMap['type'] as String? ?? 'checkbox';
        final String? group = optionMap['group'] as String?;
        bool isSelected = _selectedOptionsState[name] ?? false;

        Widget controlWidget;
        if (type == 'radio') {
          controlWidget = Radio<bool>(
            value: true,
            groupValue: isSelected, // isSelected Radio ning o'zining holati
            onChanged: (bool? val) => _onOptionChanged(name, val, type, group),
            activeColor: AppColors.primary500,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          );
        } else {
          controlWidget = Checkbox(
            value: isSelected,
            onChanged: (bool? val) => _onOptionChanged(name, val, type, group),
            activeColor: AppColors.primary500,
            checkColor: AppColors.white,
            side: MaterialStateBorderSide.resolveWith(
                  (states) => BorderSide(
                  color: states.contains(MaterialState.selected) ? AppColors.primary500 : AppColors.neutral400, // Chegara rangi
                  width: 1.8
              ),
            ),
            visualDensity: VisualDensity.compact, // Compact ko'rinish
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(vertical: AppResponsive.height(7)), // Vertikal padding
          child: Row(
            children: [
              if (name.startsWith('Extra') || name.startsWith('Double'))
                SizedBox(width: AppResponsive.width(20)), // Sub-opsiya uchun joy
              Text(
                name,
                style: _textStyles.medium(
                  color: AppColors.neutral800,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              Text(
                price,
                style: _textStyles.medium(
                  color: AppColors.neutral700,
                  fontSize: 15,
                ),
              ),
              SizedBox(width: AppResponsive.width(10)),
              SizedBox(
                width: AppResponsive.width(24),
                height: AppResponsive.width(24),
                child: Transform.scale(
                    scale: 1.15, // Control widget o'lchami
                    alignment: Alignment.center,
                    child: controlWidget
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppResponsive.width(24),
        vertical: AppResponsive.height(16),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral300.withOpacity(0.5), // Soya rangi va shaffofligi
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.neutral100,
              borderRadius: BorderRadius.circular(AppResponsive.width(28)),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, color: AppColors.primary500),
                  onPressed: _decrementQuantity,
                  iconSize: AppResponsive.width(20),
                  padding: EdgeInsets.all(AppResponsive.width(10)), // Padding
                  constraints: const BoxConstraints(),
                  splashRadius: AppResponsive.width(22),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(16)),
                  child: Text(
                    '$_quantity',
                    style: _textStyles.semiBold(
                      color: AppColors.neutral900,
                      fontSize: 18,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: AppColors.primary500),
                  onPressed: _incrementQuantity,
                  iconSize: AppResponsive.width(20),
                  padding: EdgeInsets.all(AppResponsive.width(10)),
                  constraints: const BoxConstraints(),
                  splashRadius: AppResponsive.width(22),
                ),
              ],
            ),
          ),
          SizedBox(width: AppResponsive.width(16)),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary500,
                padding: EdgeInsets.symmetric(vertical: AppResponsive.height(16)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppResponsive.width(28)),
                ),
                elevation: 2,
              ),
              onPressed: _addToBasket,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_basket_outlined, color: AppColors.white, size: 20),
                  SizedBox(width: AppResponsive.width(10)),
                  Text(
                    'Add to Basket',
                    style: _textStyles.semiBold(
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}