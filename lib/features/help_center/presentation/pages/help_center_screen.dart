import 'package:flutter/material.dart';
import 'package:food_delivery/core/utils/responsiveness/app_responsive.dart';
import 'package:food_delivery/features/help_center/domain/entities/help_topic.dart';
import 'package:food_delivery/features/help_center/presentation/pages/help_center_detail_screen.dart';
import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/constants/strings/app_string.dart';
import '../../../../core/common/text_styles/name_textstyles.dart';

class HelpCenterScreen extends StatefulWidget {
  final VoidCallback? onAppBarBackPressed;

  const HelpCenterScreen({Key? key, this.onAppBarBackPressed}) : super(key: key);

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final _textStyles = RobotoTextStyles();
  String _searchText = "";

  final List<HelpTopic> _allHelpTopics = [
    HelpTopic(id: '1', question: "How do I create a new account?", answer: "To create a new account, please follow these simple steps:\n\n1. Open the app and navigate to the login screen.\n2. Below the login form, you'll see an option to \"Register\". Tap on that.\n3. You will be prompted to enter your Phone Number, Email and Full Name for your account. Please make sure to use a valid Phone Number.\n4. After entering your Phone Number, Email and Full Name, tap on the \"Register\" button.\n5. A code will be sent to your phone number provided for verification. Please check your inbox and enter the code in the Verification screen to verify your account.\n6. Once your account is verified, the app will automatically log you in.\n7. You can enter some other personal information or skip it.\n8. You can set the required security level for your account or ignore it.\n9. You are now done creating your account.\n\nIf you encounter any issues during the sign-up process, feel free to reach out to our support team for assistance.",),
    HelpTopic(id: '2', question: "I forgot my password. How do I reset it?", answer: "If you've forgotten your password, you can easily reset it by following these steps...\n1. Go to the login screen.\n2. Tap on the 'Forgot Password?' link.\n3. Enter your registered email address.\n4. You will receive an email with a link or a code to reset your password.\n5. Follow the instructions in the email to set a new password.",),
    HelpTopic(id: '3', question: "I'm having trouble logging into my account. How can I resolve this?", answer: "If you're having trouble logging in, please try the following...\n- Double-check your email and password for typos.\n- Ensure your Caps Lock key is off.\n- Try resetting your password using the 'Forgot Password?' link.\n- If the problem persists, contact our support team with details of the issue.",),
    HelpTopic(id: '4', question: "How do I place a new order?", answer: "Placing a new order is simple! Just follow these steps...\n1. Browse through our restaurants or search for a specific item.\n2. Add items to your cart.\n3. Proceed to checkout.\n4. Confirm your delivery address and payment method.\n5. Place your order!",),
    HelpTopic(id: '5', question: "I'm experiencing issues with payment. How can I resolve them?", answer: "If you're facing payment issues, consider these solutions...\n- Ensure your card details are correct and a_valid.\n- Check if your card has sufficient funds.\n- Try a different payment method.\n- Contact your bank to see if there are any restrictions on your card.\n- If problems continue, please contact our support team.",),
    HelpTopic(id: '6', question: "I want to cancel an order I've placed. How can I do this?", answer: "You can cancel an order if it has not yet been processed by the restaurant...\n1. Go to your 'Orders' screen.\n2. Find the active order you wish to cancel.\n3. If cancellation is available, you will see a 'Cancel Order' button or option.\n4. Follow the prompts to confirm cancellation.\nPlease note that orders already being prepared cannot be cancelled.",),
    HelpTopic(id: '7', question: "Where can I find detailed information about a specific product?", answer: "To find detailed information about a product...\n1. Navigate to the restaurant's menu.\n2. Tap on the product you are interested in.\n3. The product detail page will show ingredients, allergens (if available), and other relevant information.",),
    HelpTopic(id: '8', question: "I'm encountering an issue with a product or service. How can I report this?", answer: "We're sorry to hear you're having an issue! You can report it by...\n- Contacting our support team directly through the app's Help Center (Email or Call buttons).\n- Providing as much detail as possible, including order numbers, screenshots, and a description of the problem.",),
    HelpTopic(id: '9', question: "How do I use a specific feature within your app?", answer: "Our app has many features to enhance your experience. You can usually find information on how to use them by...\n- Exploring the relevant section of the app (e.g., Profile settings for account features).\n- Checking our Help Center FAQs for guides on specific features.\n- If you can't find an answer, our support team will be happy to assist you.",),
    HelpTopic(id: '10', question: "What is the estimated delivery time for my order?", answer: "The estimated delivery time is provided once you place your order and is updated in real-time in the 'Orders' section. It depends on the restaurant's preparation time and the distance to your location.",),
    HelpTopic(id: '11', question: "How do I track my order?", answer: "You can track your order in real-time by...\n1. Going to the 'Orders' section in the app.\n2. Selecting your active order.\n3. You will see a map and status updates indicating your order's progress.",),
    HelpTopic(id: '12', question: "I haven't received my order. How can I resolve this?", answer: "If your order is significantly delayed or you haven't received it...\n- First, check the real-time tracking in the 'Orders' section.\n- If there's a persistent issue, please contact our support team immediately using the Help Center buttons, providing your order ID.",),
    HelpTopic(id: '13', question: "How do I update my personal information in my account?", answer: "You can update your personal information (like name, phone number, or delivery addresses) by...\n1. Navigating to the 'Profile' screen.\n2. Tapping the 'Edit' icon next to your name or a_ccessing the relevant section (e.g., 'My Locations').\n3. Making the necessary changes and saving them.",),
    HelpTopic(id: '14', question: "I want to change the email or phone number associated with my account. How can I do this?", answer: "To change your registered email or phone number, you may need to...\n- Go to your 'Profile' settings.\n- Look for an 'Account Security' or 'Edit Profile' section.\n- For security reasons, changing primary contact information might require additional verification steps. If you face difficulties, please contact support.",),
    HelpTopic(id: '15', question: "I'm concerned about the security of my account. What measures can I take to protect my account?", answer: "Protecting your account is important. We recommend...\n- Using a strong, unique password.\n- Enabling any available security features like PIN, Face ID, or Touch ID in the 'Security' settings.\n- Being cautious about sharing your login details.\n- Regularly reviewing your account activity.",),
  ];
  List<HelpTopic> _filteredHelpTopics = [];

  @override
  void initState() {
    super.initState();
    _filteredHelpTopics = List.from(_allHelpTopics);
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchText = query.toLowerCase();
      if (_searchText.isEmpty) {
        _filteredHelpTopics = List.from(_allHelpTopics);
      } else {
        _filteredHelpTopics = _allHelpTopics
            .where((topic) =>
        topic.question.toLowerCase().contains(_searchText) ||
            topic.answer.toLowerCase().contains(_searchText))
            .toList();
      }
    });
  }

  void _navigateToDetail(HelpTopic topic) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HelpCenterDetailScreen(topic: topic),
      ),
    );
  }

  Widget _buildFloatingActionButtons() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: AppResponsive.height(20) + MediaQuery.of(context).padding.bottom,
        right: AppResponsive.width(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'help_center_email_fab',
            onPressed: () {},
            backgroundColor: AppColors.primary50,
            elevation: 2,
            mini: true,
            child: Image.asset(
              'assets/icons/help_center/email_outlined.png',
              width: AppResponsive.width(20),
              height: AppResponsive.width(20),
              color: AppColors.primary500,
            ),
          ),
          SizedBox(height: AppResponsive.height(16)),
          FloatingActionButton(
            heroTag: 'help_center_call_fab',
            onPressed: () {},
            backgroundColor: AppColors.primary50,
            elevation: 2,
            mini: true,
            child: Image.asset(
              'assets/icons/help_center/call_outlined.png',
              width: AppResponsive.width(20),
              height: AppResponsive.width(20),
              color: AppColors.primary500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        shadowColor: AppColors.neutral200.withOpacity(0.7),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800, size: 20),
          onPressed: widget.onAppBarBackPressed ?? () => Navigator.maybePop(context),
        ),
        title: Text(
          AppStrings.helpCenter,
          style: _textStyles.semiBold(color: AppColors.neutral900, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _buildFaqList(),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _buildFloatingActionButtons(),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppResponsive.width(24),
          vertical: AppResponsive.height(16)),
      child: SizedBox(
        height: AppResponsive.height(48),
        child: TextField(
          onChanged: _onSearchChanged,
          style: _textStyles.regular(color: AppColors.textPrimary, fontSize: 14),
          decoration: InputDecoration(
            hintText: AppStrings.search,
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
                onPressed: () {},
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
    );
  }

  Widget _buildFaqList() {
    if (_filteredHelpTopics.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(AppResponsive.width(20.0)),
          child: Text(
            _searchText.isNotEmpty ? AppStrings.notFoundHelpTopics : AppStrings.noHelpTopics,
            style: _textStyles.semiBold(color: AppColors.neutral500, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.width(24), vertical: AppResponsive.height(0)),
      itemCount: _filteredHelpTopics.length,
      itemBuilder: (context, index) {
        final topic = _filteredHelpTopics[index];
        return ListTile(
          title: Text(topic.question, style: _textStyles.regular(fontSize: 14, color: AppColors.textPrimary)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.neutral400),
          contentPadding: EdgeInsets.symmetric(vertical: AppResponsive.height(12)), // Paddingni oshirish
          onTap: () => _navigateToDetail(topic),
        );
      },
      separatorBuilder: (context, index) => const Divider(height: 0.5, color: AppColors.neutral100, indent: 0, endIndent: 0), // To'liq chiziq
    );
  }
}