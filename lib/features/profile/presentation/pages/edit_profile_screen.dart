import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/core/common/constants/colors/app_colors.dart';
import 'package:food_delivery/core/common/constants/strings/app_string.dart';
import 'package:food_delivery/core/common/text_styles/name_textstyles.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';


class EditProfileScreen extends StatefulWidget {

  const EditProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textStyles = RobotoTextStyles();

  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _locationController = TextEditingController();

  String? _selectedGender;
  DateTime? _selectedDate;

  String? _avatarImagePath  = 'assets/images/profile_avatar.png';

  @override
  void initState() {
    super.initState();
    _emailController.text = "thomas.abc.inc@gmail.com";

  }

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _fullNameController.dispose();
    _dobController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary500,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.neutral900,
            ),
            dialogBackgroundColor: AppColors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = "${picked.day.toString().padLeft(2,'0')}/${picked.month.toString().padLeft(2,'0')}/${picked.year}"; // Oddiy formatlash
      });
    }
  }

  void _handleContinue() {
    if (_formKey.currentState!.validate()) {
      print("Phone: ${_phoneController.text}");
      print("Email: ${_emailController.text}");
      print("Full Name: ${_fullNameController.text}");
      print("DOB: ${_dobController.text}");
      print("Gender: $_selectedGender");
      print("Location: ${_locationController.text}");
      print("Avatar Path: $_avatarImagePath");
      Navigator.of(context).pop();
    }
  }

  void _handleSkip() {
    Navigator.of(context).pop();
    print("Profile setup skipped");
  }

  void _pickImage() {
    print("Pick image tapped");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppStrings.yourProfile,
          style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppResponsive.width(24)),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildAvatarSection(),
              SizedBox(height: AppResponsive.height(32)),

              _buildTextFormField(
                controller: _phoneController,
                hintText: AppStrings.phoneNumber,
                keyboardType: TextInputType.phone,
                prefixIconWidget: _buildCountryFlag(),
                validator: (value) {
                  if (value == null || value.isEmpty) return AppStrings.pleaseEnterPhoneNumber;
                  return null;
                },
              ),
              SizedBox(height: AppResponsive.height(16)),
              _buildTextFormField(
                controller: _emailController,
                hintText: AppStrings.email,
                keyboardType: TextInputType.emailAddress,
                readOnly: true,
                prefixIcon: Icons.email_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) return AppStrings.pleaseEnterEmail;
                  if (!value.contains('@')) return AppStrings.pleaseEnterValidEmail;
                  return null;
                },
              ),
              SizedBox(height: AppResponsive.height(16)),
              _buildTextFormField(
                controller: _fullNameController,
                hintText: AppStrings.fullName,
                keyboardType: TextInputType.name,
                prefixIcon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) return AppStrings.pleaseEnterFullName;
                  return null;
                },
              ),
              SizedBox(height: AppResponsive.height(16)),
              _buildTextFormField(
                controller: _dobController,
                hintText: AppStrings.dateOfBirth,
                readOnly: true,
                onTap: () => _selectDate(context),
                prefixIcon: Icons.calendar_today_outlined,
                suffixIconWidget: Icon(Icons.calendar_today_outlined, color: AppColors.neutral500, size: AppResponsive.width(20)),
                validator: (value) {
                  if (value == null || value.isEmpty) return AppStrings.pleaseSelectDOB;
                  return null;
                },
              ),
              SizedBox(height: AppResponsive.height(16)),
              _buildGenderDropdown(),
              SizedBox(height: AppResponsive.height(16)),
              _buildTextFormField(
                controller: _locationController,
                hintText: AppStrings.yourLocation,
                prefixIcon: Icons.location_on_outlined,
                suffixIconWidget: Icon(Icons.my_location, color: AppColors.neutral500, size: AppResponsive.width(20)),
                onTap: () {
                  print("Select location tapped");
                },
                validator: (value) {
                  return null;
                },
              ),
              SizedBox(height: AppResponsive.height(40)),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary500,
                    padding: EdgeInsets.symmetric(vertical: AppResponsive.height(16)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppResponsive.height(28)),
                    ),
                  ),
                  child: Text(
                    AppStrings.continueText,
                    style: _textStyles.semiBold(color: AppColors.white, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: AppResponsive.height(16)),

              TextButton(
                onPressed: _handleSkip,
                child: Text(
                  AppStrings.skip,
                  style: _textStyles.medium(color: AppColors.neutral600, fontSize: 14),
                ),
              ),
              SizedBox(height: AppResponsive.height(20)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: AppResponsive.width(160),
          height: AppResponsive.width(160),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.neutral200.withOpacity(0.5),
          ),
        ),
        CircleAvatar(
          radius: AppResponsive.width(78),
          backgroundColor: AppColors.neutral100,
          backgroundImage: _avatarImagePath != null
              ? AssetImage(_avatarImagePath!) as ImageProvider
              : null,
          child: _avatarImagePath == null
              ? Icon(Icons.person_outline, size: AppResponsive.width(80), color: AppColors.neutral400)
              : null,
        ),
        Positioned(
          right: AppResponsive.width(5),
          bottom: AppResponsive.height(5),
          child: InkWell(
            onTap: _pickImage,
            child: Container(
              width: AppResponsive.width(42),
              height: AppResponsive.width(42),
              decoration: BoxDecoration(
                color: AppColors.primary500,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.15),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/profile/edit_icon.svg',
                  width: AppResponsive.width(20),
                  height: AppResponsive.width(20),
                  colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCountryFlag() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(12.0)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("🇬🇧", style: TextStyle(fontSize: 20)),
          SizedBox(width: AppResponsive.width(4)),
          Icon(Icons.keyboard_arrow_down, color: AppColors.neutral500, size: AppResponsive.width(18)),
        ],
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    IconData? prefixIcon,
    Widget? prefixIconWidget,
    TextInputType? keyboardType,
    bool readOnly = false,
    VoidCallback? onTap,
    Widget? suffixIconWidget,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onTap: onTap,
      style: _textStyles.regular(color: AppColors.neutral900, fontSize: 14),
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: _textStyles.regular(color: AppColors.neutral500, fontSize: 14),
        prefixIcon: prefixIconWidget ?? (prefixIcon != null
            ? Icon(prefixIcon, color: AppColors.neutral500, size: AppResponsive.width(20))
            : null),
        suffixIcon: suffixIconWidget,
        filled: true,
        fillColor: AppColors.white,
        contentPadding: EdgeInsets.symmetric(vertical: AppResponsive.height(18), horizontal: AppResponsive.width(16)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppResponsive.height(12)),
          borderSide: BorderSide(color: AppColors.neutral200, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppResponsive.height(12)),
          borderSide: BorderSide(color: AppColors.neutral200, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppResponsive.height(12)),
          borderSide: BorderSide(color: AppColors.primary300, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppResponsive.height(12)),
          borderSide: BorderSide(color: AppColors.primary500, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppResponsive.height(12)),
          borderSide: BorderSide(color: AppColors.primary500, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppResponsive.height(12)),
        border: Border.all(color: AppColors.neutral200, width: 1.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          value: _selectedGender,
          hint: Text(AppStrings.gender, style: _textStyles.regular(color: AppColors.neutral500, fontSize: 14)),
          icon: Icon(Icons.keyboard_arrow_down, color: AppColors.neutral500, size: AppResponsive.width(20)),
          isExpanded: true,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person_outline, color: AppColors.neutral500, size: AppResponsive.width(20)),
            prefixIconConstraints: BoxConstraints(minWidth: AppResponsive.width(40)),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: AppResponsive.height(4)),
          ),
          style: _textStyles.regular(color: AppColors.neutral900, fontSize: 14),
          items: [AppStrings.male, AppStrings.female, AppStrings.other]
              .map((label) => DropdownMenuItem(child: Text(label), value: label))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedGender = value;
            });
          },
          validator: (value) {
            if (value == null) return AppStrings.pleaseSelectGender;
            return null;
          },
        ),
      ),
    );
  }
}