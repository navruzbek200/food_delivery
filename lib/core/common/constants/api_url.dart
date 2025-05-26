
abstract class ApiUrls {
  static const String baseUrl = 'https://fast-food-production-1c5c.up.railway.app/';

  static const String auth = 'auth/';
  static const String register = '/register';
  static const String confirmEmail = '/confirm';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String resendCode = '/resend-code';
  static const String logout = '/logout';
class ApiUrl {
  // Orders
  static String baseUrl = "https://fast-food-production-1c5c.up.railway.app";
  static String orderId = "$baseUrl/orders/";
  static String orders = "$baseUrl/orders";
  static String ordersAll = "$baseUrl/orders/all";
  static String ordersCompleted = "$baseUrl/orders/completed";
  static String ordersActive = "$baseUrl/orders/active";
  // Categories
  static String categories = "$baseUrl/categories";
  static String categoriesId = "$baseUrl/categories/";
  static String categoriesIdFoods = "$baseUrl/categories/";


}