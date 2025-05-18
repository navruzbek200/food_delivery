import 'package:flutter/material.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  final String _policyContent =
      "Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot Europa usa li sam vocabular. Li lingues differe solmen in li grammatica, li pronunciation e li plu commun vocabules. Omnicos directeal desirabilite de un nov lingua franca: On refusa continuar payar custosi traductores. At solmen va esser necessi far uniform grammatica, pronunciation e plu sommun paroles. Ma quande lingues coalesce, li grammatica del resultant lingue es plu simplic e regulari quam ti del coalescent lingues. Li nov lingua franca va esser plu simplic e regulari quam li existent Europan lingues.\n\n"
      "It va esser tam simplic quam Occidental in fact, it va esser Occidental. A un Angleso it va semblar un simplificat Angles, quam un skeptic Cambridge amico dit me que Occidental es.Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot Europa usa li sam vocabular. Li lingues differe solmen in li grammatica, li pronunciation e li plu commun vocabules. Omnicos directe al desirabilite de un nov lingua franca: On refusa continuar payar custosi traductores. At solmen va esser necessi far uniform grammatica, pronunciation e plu sommun paroles.\n\n"
      "The European languages are members of the same family. Their separate existence is a myth. For science, music, sport, etc, Europe uses the same vocabulary.\n\n"
      "The languages only differ in their grammar, their pronunciation and their most common words. Everyone realizes why a new common language would be desirable: one could refuse to pay..."; // Matnni to'liq davom ettiring

  @override
  Widget build(BuildContext context) {
    final _textStyles = RobotoTextStyles();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        shadowColor: AppColors.neutral200.withOpacity(0.7),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800, size: 20),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          AppStrings.privacyPolicy,
          style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppResponsive.width(24)),
        child: Text(
          _policyContent,
          style: _textStyles.regular(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}