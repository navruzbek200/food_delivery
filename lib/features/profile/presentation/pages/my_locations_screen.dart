import 'package:flutter/material.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/features/profile/domain/entities/location_item.dart';

import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';

class MyLocationsScreen extends StatefulWidget {
  final VoidCallback? onAppBarBackPressed;

  const MyLocationsScreen({Key? key, this.onAppBarBackPressed}) : super(key: key);

  @override
  State<MyLocationsScreen> createState() => _MyLocationsScreenState();
}

class _MyLocationsScreenState extends State<MyLocationsScreen> {
  final _textStyles = RobotoTextStyles();

  final List<LocationItem> _locations = [
    LocationItem(id: '1', type: LocationType.home, label: 'Home', fullAddress: '123 Greenfield Ave, Apt 4B, Springfield, USA', isDefault: true),
    LocationItem(id: '2', type: LocationType.work, label: 'Office', fullAddress: '456 Business Rd, Suite 700, Metropolis, USA'),
    LocationItem(id: '3', type: LocationType.other, label: "Aunt's House", fullAddress: '789 Suburbia Ln, Smalltown, USA'),
  ];

  String? _selectedLocationId;

  @override
  void initState() {
    super.initState();
    final defaultLocation = _locations.firstWhere((loc) => loc.isDefault, orElse: () {
      if (_locations.isNotEmpty) {
        _locations.first.isDefault = true;
        return _locations.first;
      }
      return LocationItem(id: '', type: LocationType.other, label: '', fullAddress: '');
    });
    if(defaultLocation.id.isNotEmpty) {
      _selectedLocationId = defaultLocation.id;
    }
  }

  void _selectDefaultLocation(String locationId) {
    setState(() {
      _selectedLocationId = locationId;
      for (var loc in _locations) {
        loc.isDefault = (loc.id == locationId);
      }
    });
  }

  void _editLocation(LocationItem location) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Edit ${location.label} (Not Implemented)")));
  }

  void _deleteLocation(LocationItem location) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext){
          return AlertDialog(
            title: Text("Delete Location", style: _textStyles.semiBold(fontSize: 16, color: AppColors.textPrimary)),
            content: Text("Are you sure you want to delete '${location.label}'?", style: _textStyles.regular(fontSize: 14, color: AppColors.textSecondary)),
            actions: [
              TextButton(
                child: Text(AppStrings.cancel, style: _textStyles.medium(color: AppColors.neutral600, fontSize: 14)),
                onPressed: () => Navigator.of(dialogContext).pop(),
              ),
              TextButton(
                child: Text(AppStrings.delete, style: _textStyles.medium(color: AppColors.primary500, fontSize: 14)),
                onPressed: (){
                  Navigator.of(dialogContext).pop();
                  setState(() {
                    _locations.removeWhere((loc) => loc.id == location.id);
                    if (_selectedLocationId == location.id) {
                      if (_locations.isNotEmpty) {
                        _selectedLocationId = _locations.first.id;
                        _locations.first.isDefault = true;
                      } else {
                        _selectedLocationId = null;
                      }
                    }
                  });
                },
              )
            ],
          );
        }
    );
  }

  void _addNewLocation() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Add New Location (Not Implemented)")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral50,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        shadowColor: AppColors.neutral200.withOpacity(0.7),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800, size: 20),
          onPressed: widget.onAppBarBackPressed ?? () => Navigator.maybePop(context),
        ),
        title: Text(
          AppStrings.myLocations,
          style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: _locations.isEmpty
                ? Center(
              child: Padding(
                padding: EdgeInsets.all(AppResponsive.width(20.0)),
                child: Text(
                  AppStrings.noLocationsAdded,
                  style: _textStyles.regular(color: AppColors.neutral500, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            )
                : ListView.builder(
              padding: EdgeInsets.all(AppResponsive.width(16)),
              itemCount: _locations.length,
              itemBuilder: (context, index) {
                final location = _locations[index];
                return _buildLocationTile(location);
              },
            ),
          ),
          _buildAddNewLocationButton(),
        ],
      ),
    );
  }

  Widget _buildLocationTile(LocationItem location) {
    bool isSelectedAsDefault = location.id == _selectedLocationId;

    return Card(
      margin: EdgeInsets.only(bottom: AppResponsive.height(12)),
      elevation: isSelectedAsDefault ? 2.0 : 1.0,
      shadowColor: isSelectedAsDefault ? AppColors.primary100.withOpacity(0.8) : AppColors.neutral200.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppResponsive.height(12)),
        side: isSelectedAsDefault
            ? const BorderSide(color: AppColors.primary300, width: 1.5)
            : BorderSide(color: AppColors.neutral200.withOpacity(0.8), width: 1.0),
      ),
      color: AppColors.white,
      child: ListTile(
        leading: Padding(
          padding: EdgeInsets.all(AppResponsive.width(8.0)),
          child: Icon(
            location.icon,
            color: isSelectedAsDefault ? AppColors.primary500 : AppColors.neutral700,
            size: AppResponsive.width(26),
          ),
        ),
        title: Text(
          location.label,
          style: _textStyles.semiBold(
              color: isSelectedAsDefault ? AppColors.primary500 : AppColors.textPrimary,
              fontSize: 15
          ),
        ),
        subtitle: Text(
          location.fullAddress,
          style: _textStyles.regular(color: AppColors.textSecondary, fontSize: 13,),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: PopupMenuButton<String>(
          icon: Icon(Icons.more_vert_rounded, color: isSelectedAsDefault ? AppColors.primary500 : AppColors.neutral500),
          tooltip: "More options",
          onSelected: (String choice) {
            if (choice == 'edit') {
              _editLocation(location);
            } else if (choice == 'delete') {
              _deleteLocation(location);
            } else if (choice == 'set_default') {
              _selectDefaultLocation(location.id);
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            if(!location.isDefault)
              PopupMenuItem<String>(value: 'set_default', child: Text('Set as Default', style: _textStyles.regular(fontSize: 14, color: AppColors.textPrimary))),
            PopupMenuItem<String>(value: 'edit', child: Text('Edit', style: _textStyles.regular(fontSize: 14, color: AppColors.textPrimary))),
            PopupMenuItem<String>(value: 'delete', child: Text('Delete', style: _textStyles.regular(fontSize: 14, color: AppColors.primary500))),
          ],
        ),
        onTap: () => _selectDefaultLocation(location.id),
        contentPadding: EdgeInsets.symmetric(horizontal: AppResponsive.width(12), vertical: AppResponsive.height(10)),
      ),
    );
  }

  Widget _buildAddNewLocationButton() {
    return Padding(
      padding: EdgeInsets.all(AppResponsive.width(24)) + EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.add_location_alt_outlined, size: 20),
        label: Text(AppStrings.addNewAddress, style: _textStyles.semiBold(fontSize: 16, color: AppColors.white)),
        onPressed: _addNewLocation,
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary500,
            foregroundColor: AppColors.white,
            padding: EdgeInsets.symmetric(vertical: AppResponsive.height(16)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppResponsive.height(12)),),
            textStyle: _textStyles.semiBold(fontSize: 16, color: AppColors.white)
        ),
      ),
    );
  }
}