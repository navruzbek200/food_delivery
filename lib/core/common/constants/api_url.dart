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
  // baseurl
  static const String orderId = "$baseUrl/orders/";
  static const String orders = "$baseUrl/orders";
  static const String ordersAll = "$baseUrl/orders/all";
  static const String ordersCompleted = "$baseUrl/orders/completed";
  static const String ordersActive = "$baseUrl/orders/active";
  // Categories
  static const String categories = "$baseUrl/categories";
  static const String categoriesId = "$baseUrl/categories/";
  static const String categoriesIdFoods = "$baseUrl/categories/";


}