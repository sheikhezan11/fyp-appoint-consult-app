import 'package:MedEase/resources/routes/pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../utils/bottom_widget.dart';
import '../../view/appointments/check_appointments.dart';
import '../../view/book_appointment/book_appointment.dart';
import '../../view/categories/categories.dart';
import '../../view/category/categeory_view.dart';
import '../../view/doctor_detail/doctordetail_view.dart';
import '../../view/doctor_profile/doctor_profile.dart';
import '../../view/home/home_view.dart';
import '../../view/location/location_view.dart';
import '../../view/login/login_view.dart';
import '../../view/new_password/new_password_view.dart';
import '../../view/onboarding/onboarding_view.dart';
import '../../view/otp/otp_view.dart';
import '../../view/profile/profile_view.dart';
import '../../view/profile_bottom/profile_bottom_view.dart';
import '../../view/register/registration_view.dart';
import '../../view/video_messenger/video_messenger.dart';
import '../../viewmodel/binding/appointments/check_appointments_binding.dart';
import '../../viewmodel/binding/book_appointment/book_appointment_binding.dart';
import '../../viewmodel/binding/categories/categories_binding.dart';
import '../../viewmodel/binding/categories_/categories_binding.dart';
import '../../viewmodel/binding/dashboard/dashboard_binding.dart';
import '../../viewmodel/binding/doctor_detail/doctor_detail_binding.dart';
import '../../viewmodel/binding/doctor_profile/doctor_profile_binding.dart';
import '../../viewmodel/binding/home/home_binding.dart';
import '../../viewmodel/binding/location_view/location_view_binding.dart';
import '../../viewmodel/binding/login/login_binding.dart';
import '../../viewmodel/binding/onboarding/onboarding_binding.dart';
import '../../viewmodel/binding/profile/profile_binding.dart';
import '../../viewmodel/binding/register/register_binding.dart';
import '../../viewmodel/binding/video_messenger/video_messenger_binding.dart';

class Pages {
  static Transition get _routeTransition => Transition.rightToLeft;
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboardingView:
        return GetPageRoute(
          settings: settings,
          page: () => const OnboardingView(),
          binding: OnBoardingBinding(),
          transition: _routeTransition,
        );
      case Routes.loginView:
        return GetPageRoute(
          settings: settings,
          page: () => const LoginView(),
          binding: LoginBinding(),
          transition: _routeTransition,
        );
      case Routes.registerView:
        return GetPageRoute(
          settings: settings,
          page: () => const RegisterView(),
          binding: RegisterBinding(),
          transition: _routeTransition,
        );
      case Routes.otpView:
        return GetPageRoute(
          settings: settings,
          page: () => const OtpView(),
          transition: _routeTransition,
        );
      case Routes.newPassword:
        return GetPageRoute(
          settings: settings,
          page: () => const NewPassword(),
          transition: _routeTransition,
        );
      case Routes.profileView:
        return GetPageRoute(
          settings: settings,
          page: () => const ProfileView(),
          binding: ProfileBinding(),
          transition: _routeTransition,
        );
      case Routes.homeView:
        return GetPageRoute(
          settings: settings,
          page: () => const HomeView(),
          binding: HomeBinding(),
          transition: _routeTransition,
        );
      case Routes.dashboard:
        return GetPageRoute(
          settings: settings,
          page: () => const BottomWidget(),
          binding: DashboardBinding(),
          transition: _routeTransition,
        );
      case Routes.category:
        return GetPageRoute(
          settings: settings,
          page: () => const CategoryView(),
          binding: CategoryBinding(),
          transition: _routeTransition,
        );
      case Routes.doctorDetail:
        return GetPageRoute(
          settings: settings,
          page: () => const DoctorDetail(),
          binding: DoctorDetailBinding(),
          transition: _routeTransition,
        );
      case Routes.bookAppointment:
        return GetPageRoute(
          settings: settings,
          page: () => const BookAppointment(),
          binding: BookAppointmentBinding(),
          transition: _routeTransition,
        );
      case Routes.doctorProfile:
        return GetPageRoute(
          settings: settings,
          page: () => const DoctorProfile(),
          binding: DoctorProfileBinding(),
          transition: _routeTransition,
        );
      case Routes.checkAppointments:
        return GetPageRoute(
          settings: settings,
          page: () => const CheckAppointments(),
          binding: CheckAppointmentBinding(),
          transition: _routeTransition,
        );
      case Routes.categories:
        return GetPageRoute(
          settings: settings,
          page: () => const CategoriesView(),
          binding: CategoriesBinding(),
          transition: _routeTransition,
        );
      case Routes.checkProfile:
        return GetPageRoute(
          settings: settings,
          page: () => const ProfileBottom(),
          transition: _routeTransition,
        );
      case Routes.videoPage:
        return GetPageRoute(
          settings: settings,
          page: () => const VideoCallPage(),
          binding: VideoMessengerBinding(),
          transition: _routeTransition,
        );
      case Routes.location:
        return GetPageRoute(
          settings: settings,
          // ignore: prefer_const_constructors
          page: () =>  LocationView(),
          binding: LocationBinding(),
          transition: _routeTransition,
        );
      default:
        return null;
    }
  }
}
