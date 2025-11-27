import 'package:get/get.dart';

import '../modules/AddKhataClients/bindings/add_khata_clients_binding.dart';
import '../modules/AddKhataClients/views/add_khata_clients_view.dart';
import '../modules/KhataBills/bindings/khata_bills_binding.dart';
import '../modules/KhataBills/views/khata_bills_view.dart';
import '../modules/KhataClients/bindings/khata_clients_binding.dart';
import '../modules/KhataClients/views/khata_clients_view.dart';
import '../modules/KhataClientsProfile/bindings/khata_clients_profile_binding.dart';
import '../modules/KhataClientsProfile/views/khata_clients_profile_view.dart';
import '../modules/KhataOnboard/bindings/khata_onboard_binding.dart';
import '../modules/KhataOnboard/views/khata_onboard_view.dart';
import '../modules/KhataReceive/bindings/khata_receive_binding.dart';
import '../modules/KhataReceive/views/khata_receive_view.dart';
import '../modules/KhataRegister/bindings/khata_register_binding.dart';
import '../modules/KhataRegister/views/khata_register_view.dart';
import '../modules/KhataSend/bindings/khata_send_binding.dart';
import '../modules/KhataSend/views/khata_send_view.dart';
import '../modules/MakeKhataBills/bindings/make_khata_bills_binding.dart';
import '../modules/MakeKhataBills/views/make_khata_bills_view.dart';
import '../modules/News/bindings/news_binding.dart';
import '../modules/News/views/news_view.dart';
import '../modules/Onboard/bindings/onboard_binding.dart';
import '../modules/Onboard/views/onboard_view.dart';
import '../modules/Splash/bindings/splash_binding.dart';
import '../modules/Splash/views/splash_view.dart';
import '../modules/User/Categorys/bindings/categorys_binding.dart';
import '../modules/User/Categorys/views/categorys_view.dart';
import '../modules/User/Dashboard/bindings/dashboard_binding.dart';
import '../modules/User/Dashboard/views/dashboard_view.dart';
import '../modules/User/Login/bindings/login_binding.dart';
import '../modules/User/Login/views/login_view.dart';
import '../modules/User/MyBookings/bindings/my_bookings_binding.dart';
import '../modules/User/MyBookings/views/my_bookings_view.dart';
import '../modules/User/Register/bindings/register_binding.dart';
import '../modules/User/Register/views/register_view.dart';
import '../modules/User/Scrap/bindings/scrap_binding.dart';
import '../modules/User/Scrap/views/scrap_view.dart';
import '../modules/User/ScrapBooking/bindings/scrap_booking_binding.dart';
import '../modules/User/ScrapBooking/views/scrap_booking_view.dart';
import '../modules/User/ScrapHome/bindings/scrap_home_binding.dart';
import '../modules/User/ScrapHome/views/scrap_home_view.dart';
import '../modules/User/Setting/bindings/setting_binding.dart';
import '../modules/User/Setting/views/setting_view.dart';
import '../modules/User/SettingUtils/ConnectWithUS/bindings/connect_with_u_s_binding.dart';
import '../modules/User/SettingUtils/ConnectWithUS/views/connect_with_u_s_view.dart';
import '../modules/User/SettingUtils/HelpSupport/bindings/help_support_binding.dart';
import '../modules/User/SettingUtils/HelpSupport/views/help_support_view.dart';
import '../modules/User/SettingUtils/Security/bindings/security_binding.dart';
import '../modules/User/SettingUtils/Security/views/security_view.dart';
import '../modules/User/SettingUtils/UpdateProfile/bindings/update_profile_binding.dart';
import '../modules/User/SettingUtils/UpdateProfile/views/update_profile_view.dart';
import '../modules/User/SubCategory/bindings/sub_category_binding.dart';
import '../modules/User/SubCategory/views/sub_category_view.dart';
import '../modules/User/VenderList/bindings/vender_list_binding.dart';
import '../modules/User/VenderList/views/vender_list_view.dart';
import '../modules/User/home/bindings/home_binding.dart';
import '../modules/User/home/views/home_view.dart';
import '../modules/Vendor/AddVenderService/bindings/add_vender_service_binding.dart';
import '../modules/Vendor/AddVenderService/views/add_vender_service_view.dart';
import '../modules/Vendor/VenderBooking/bindings/vender_booking_binding.dart';
import '../modules/Vendor/VenderBooking/views/vender_booking_view.dart';
import '../modules/Vendor/VendorDashboard/bindings/vendor_dashboard_binding.dart';
import '../modules/Vendor/VendorDashboard/views/vendor_dashboard_view.dart';
import '../modules/Vendor/VendorHome/bindings/vendor_home_binding.dart';
import '../modules/Vendor/VendorHome/views/vendor_home_view.dart';
import '../modules/Vendor/VendorLogin/bindings/vendor_login_binding.dart';
import '../modules/Vendor/VendorLogin/views/vendor_login_view.dart';
import '../modules/Vendor/VendorNotification/bindings/VendorNotificationBinding.dart';
import '../modules/Vendor/VendorNotification/views/vendorNotificationView.dart';
import '../modules/Vendor/VendorRegister/bindings/vendor_register_binding.dart';
import '../modules/Vendor/VendorRegister/views/vendor_register_view.dart';
import '../modules/Vendor/VendorSetting/bindings/vendor_setting_binding.dart';
import '../modules/Vendor/VendorSetting/views/vendor_setting_view.dart';
import '../modules/Vendor/VendorSkill/bindings/vendorSkillBinding.dart';
import '../modules/Vendor/VendorSkill/views/vendorSkillView.dart';
import '../modules/passwordRecovery/bindings/otpVerifyBinding.dart';
import '../modules/passwordRecovery/bindings/passwordRecoveryBinding.dart';
import '../modules/passwordRecovery/bindings/passwordResetBinding.dart';
import '../modules/passwordRecovery/views/otpVerifyView.dart';
import '../modules/passwordRecovery/views/passwordRecoveryView.dart';
import '../modules/passwordRecovery/views/passwordResetView.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.NEWS,
      page: () => const NewsView(),
      binding: NewsBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.SUB_CATEGORY,
      page: () => const SubCategoryView(),
      binding: SubCategoryBinding(),
    ),
    GetPage(
      name: _Paths.VENDER_LIST,
      page: () => const VenderListView(),
      binding: VenderListBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARD,
      page: () => const OnboardView(),
      binding: OnboardBinding(),
    ),
    GetPage(
      name: _Paths.MY_BOOKINGS,
      page: () => const MyBookingsView(),
      binding: MyBookingsBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORYS,
      page: () => const CategorysView(),
      binding: CategorysBinding(),
    ),
    GetPage(
      name: _Paths.VENDOR_DASHBOARD,
      page: () => const VendorDashboardView(),
      binding: VendorDashboardBinding(),
    ),
    GetPage(
      name: _Paths.VENDOR_HOME,
      page: () => const VendorHomeView(),
      binding: VendorHomeBinding(),
    ),
    GetPage(
      name: _Paths.VENDOR_LOGIN,
      page: () => const VendorLoginView(),
      binding: VendorLoginBinding(),
    ),
    GetPage(
      name: _Paths.VENDOR_REGISTER,
      page: () => const VendorRegisterView(),
      binding: VendorRegisterBinding(),
    ),
    GetPage(
      name: _Paths.ADD_VENDER_SERVICE,
      page: () => const AddVenderServiceView(),
      binding: AddVenderServiceBinding(),
    ),
    GetPage(
      name: _Paths.VENDER_BOOKING,
      page: () => const VenderBookingView(),
      binding: VenderBookingBinding(),
    ),
    GetPage(
      name: _Paths.VENDER_SETTING,
      page: () => const VendorSettingView(),
      binding: VendorSettingBinding(),
    ),
    GetPage(
      name: _Paths.HELP_SUPPORT,
      page: () => const HelpSupportView(),
      binding: HelpSupportBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => const UpdateProfileView(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      name: _Paths.SECURITY,
      page: () => const SecurityView(),
      binding: SecurityBinding(),
    ),
    GetPage(
      name: _Paths.CONNECT_WITH_U_S,
      page: () => const ConnectWithUSView(),
      binding: ConnectWithUSBinding(),
    ),

    // Added By Aasim Ahmad
    GetPage(
      name: _Paths.PASSWORD_RECOVERY,
      page: () => PasswordRecoveryView(),
      binding: PasswordRecoveryBinding(),
    ),
    GetPage(
      name: _Paths.OTP_VERIFY,
      page: () => OtpVerifyView(),
      binding: OtpVerifyBinding(),
    ),
    GetPage(
      name: _Paths.PASSWORD_RESET,
      page: () => PasswordResetView(),
      binding: PasswordResetBinding(),
    ),
    GetPage(
      name: _Paths.VENDOR_NOTIFICATION,
      page: () => VendorNotificationView(),
      binding: VendorNotificationBinding(),
    ),
    GetPage(
      name: _Paths.VENDOR_SKILL,
      page: () => VendorSkillView(),
      binding: VendorSkillBinding(),
    ),
    GetPage(
      name: _Paths.SCRAP,
      page: () => const ScrapView(),
      binding: ScrapBinding(),
    ),
    GetPage(
      name: _Paths.SCRAP_BOOKING,
      page: () => const ScrapBookingView(),
      binding: ScrapBookingBinding(),
    ),
    GetPage(
      name: _Paths.SCRAP_HOME,
      page: () => const ScrapHomeView(),
      binding: ScrapHomeBinding(),
    ),
    GetPage(
      name: _Paths.KHATA_CLIENTS,
      page: () => const KhataClientsView(),
      binding: KhataClientsBinding(),
    ),
    GetPage(
      name: _Paths.ADD_KHATA_CLIENTS,
      page: () => const AddKhataClientsView(),
      binding: AddKhataClientsBinding(),
    ),
    GetPage(
      name: _Paths.KHATA_SEND,
      page: () => const KhataSendView(),
      binding: KhataSendBinding(),
    ),
    GetPage(
      name: _Paths.KHATA_RECEIVE,
      page: () => const KhataReceiveView(),
      binding: KhataReceiveBinding(),
    ),
    GetPage(
      name: _Paths.KHATA_CLIENTS_PROFILE,
      page: () => const KhataClientsProfileView(),
      binding: KhataClientsProfileBinding(),
    ),
    GetPage(
      name: _Paths.KHATA_BILLS,
      page: () => const KhataBillsView(),
      binding: KhataBillsBinding(),
    ),
    GetPage(
      name: _Paths.MAKE_KHATA_BILLS,
      page: () => const MakeKhataBillsView(),
      binding: MakeKhataBillsBinding(),
    ),
    GetPage(
      name: _Paths.KHATA_ONBOARD,
      page: () => const KhataOnboardView(),
      binding: KhataOnboardBinding(),
    ),
    GetPage(
      name: _Paths.KHATA_REGISTER,
      page: () => const KhataRegisterView(),
      binding: KhataRegisterBinding(),
    ),
  ];
}
