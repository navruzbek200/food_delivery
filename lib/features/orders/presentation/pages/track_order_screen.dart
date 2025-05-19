import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/features/orders/presentation/pages/cancel_order_screen.dart';
import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';

class TrackOrderScreen extends StatefulWidget {
  final String orderId;
  final Map<String, dynamic>? completeOrderData;

  const TrackOrderScreen({
    Key? key,
    required this.orderId,
    this.completeOrderData,
  }) : super(key: key);

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  final _textStyles = RobotoTextStyles();
  Timer? _timer;
  int _remainingSeconds = 600;
  bool _canCancelOrder = true;
  int _currentMapStep = 1;
  final String _driverName = "David Wayne";
  final String _driverAvatarPath = 'assets/images/profile_avatar.png';
  final String _driverRating = "4.9";
  final String _driverId = "DW2125";
  final String _mapBasePath = 'assets/images/orders_map.png';
  final List<String> _mapPathImages = [
    'assets/images/map_path_step1.png',
    'assets/images/map_path_step2.png',
    'assets/images/map_path_step3.png',
    'assets/images/map_path_step4.png',
  ];
  final String _estimatedDeliveryTime = "10:25";

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _canCancelOrder = true;
    _remainingSeconds = 600;
    _currentMapStep = 1;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
          if ((600 - _remainingSeconds) >= 300) {
            _canCancelOrder = false;
          }
          if (_remainingSeconds == (600 - 150)) {
            _currentMapStep = 2;
          } else if (_remainingSeconds == (600 - 300)) {
            _currentMapStep = 3;
          } else if (_remainingSeconds == (600 - 450)) {
            _currentMapStep = 4;
          }
        } else {
          timer.cancel();
          _canCancelOrder = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedTime {
    return _estimatedDeliveryTime;
  }


  void _cancelOrder() async { 
    if (_canCancelOrder) {
      _timer?.cancel(); 

      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CancelOrderScreen(orderId: widget.orderId),
        ),
      );

      if (result == true && mounted) {
        Navigator.pop(context, true); 
      } else if (mounted) {
        if (_remainingSeconds > 0 && (600 - _remainingSeconds) < 300) { 
          _startTimer(); 
        } else {
          setState(() {
            _canCancelOrder = false;
          });
        }
      }
    }
  }

  void _viewOrderDetails() {}


  @override
  Widget build(BuildContext context) {
    String currentMapPathImage = _mapPathImages.length >= _currentMapStep
        ? _mapPathImages[_currentMapStep - 1]
        : _mapPathImages.first;
    Alignment courierAlignment = Alignment.center;
    if (_currentMapStep == 1) courierAlignment = const Alignment(-0.5, -0.3);
    if (_currentMapStep == 2) courierAlignment = const Alignment(0.0, -0.1);
    if (_currentMapStep == 3) courierAlignment = const Alignment(0.3, 0.2);
    if (_currentMapStep == 4) courierAlignment = const Alignment(0.6, 0.5);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800, size: 20), onPressed: () => Navigator.maybePop(context),),
        title: Text(AppStrings.trackOrderTitle, style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(_mapBasePath, fit: BoxFit.cover, errorBuilder: (c,e,s) => Center(child: Text("Map Error", style: _textStyles.regular(color: AppColors.primary500, fontSize: 16))),),
                Image.asset(currentMapPathImage, fit: BoxFit.contain, errorBuilder: (c,e,s) => const SizedBox.shrink(),),
                Positioned(top: AppResponsive.height(50), left: AppResponsive.width(70), child: Icon(Icons.storefront_outlined, color: AppColors.primary500, size: AppResponsive.width(35), shadows: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 5)]),),
                Positioned(bottom: AppResponsive.height(60), right: AppResponsive.width(90), child: Icon(Icons.home_filled, color: AppColors.green500, size: AppResponsive.width(35), shadows: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 5)]),),
                Align(alignment: courierAlignment, child: Icon(Icons.delivery_dining_rounded, color: AppColors.primary500, size: AppResponsive.width(45), shadows: [BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 6)]),),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24), vertical: AppResponsive.width(20)),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(AppResponsive.height(30)), topRight: Radius.circular(AppResponsive.height(30)),),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15, offset: const Offset(0, -5),)],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildDriverInfoPanel(),
                    Divider(height: AppResponsive.height(30), thickness: 1, color: AppColors.neutral100),
                    _buildOrderStatusPanel(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverInfoPanel() { 
    return Row(
      children: [
        CircleAvatar(radius: AppResponsive.width(28), backgroundImage: AssetImage(_driverAvatarPath), backgroundColor: AppColors.neutral100,),
        SizedBox(width: AppResponsive.width(12)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_driverName, style: _textStyles.semiBold(fontSize: 16, color: AppColors.textPrimary)),
              SizedBox(height: AppResponsive.height(4)),
              Row(
                children: [
                  const Icon(Icons.star_rounded, color: AppColors.secondary500, size: 16),
                  SizedBox(width: AppResponsive.width(4)),
                  Text(_driverRating, style: _textStyles.medium(fontSize: 13, color: AppColors.textSecondary)),
                  Text("  |  ID: $_driverId", style: _textStyles.regular(fontSize: 13, color: AppColors.neutral500)),
                ],
              ),
            ],
          ),
        ),
        IconButton(icon: Image.asset('assets/icons/chat_icon.png', width: AppResponsive.width(24), height: AppResponsive.width(24), color: AppColors.neutral700), onPressed: () {}, visualDensity: VisualDensity.compact,),
        IconButton(icon: Image.asset('assets/icons/call_icon.png', width: AppResponsive.width(24), height: AppResponsive.width(24), color: AppColors.neutral700), onPressed: () {}, visualDensity: VisualDensity.compact,),
      ],
    );
  }
  Widget _buildOrderStatusPanel() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.estimatedDeliveryTime, style: _textStyles.regular(fontSize: 14, color: AppColors.textSecondary)),
            Text(_formattedTime, style: _textStyles.semiBold(fontSize: 14, color: AppColors.textPrimary)),
          ],
        ),
        SizedBox(height: AppResponsive.height(20)),
        Row(
          children: [
            Image.asset('assets/icons/my_order_icon.png', width: AppResponsive.width(36), height: AppResponsive.width(36), color: AppColors.primary500),
            SizedBox(width: AppResponsive.width(10)),
            Expanded(child: Text(AppStrings.myOrder, style: _textStyles.medium(fontSize: 15, color: AppColors.textPrimary))),
            TextButton(
              onPressed: _viewOrderDetails,
              child: Text(AppStrings.details, style: _textStyles.medium(fontSize: 14, color: AppColors.primary500)),
            )
          ],
        ),
        SizedBox(height: AppResponsive.height(20)),
        if (_canCancelOrder)
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: _cancelOrder, 
              style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary600,
                  padding: EdgeInsets.symmetric(vertical: AppResponsive.height(14)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.height(28)), side: BorderSide(color: AppColors.primary100.withOpacity(0.9), width: 1.5)),
                  backgroundColor: AppColors.primary50.withOpacity(0.7)
              ),
              child: Text(AppStrings.cancelOrder, style: _textStyles.semiBold(fontSize: 15, color: AppColors.primary500)),
            ),
          )
        else if (_remainingSeconds <= 0)
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppResponsive.height(14.0)),
            child: Text(AppStrings.orderCompletedStatus,
              style: _textStyles.semiBold(fontSize: 15, color: AppColors.green600),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}