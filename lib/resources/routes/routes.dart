import 'package:MedEase/resources/routes/pages.dart';
import 'package:get/get.dart';


import '../../utils/bottom_widget.dart';
import '../../view/appointments/check_appointments.dart';
import '../../view/book_appointment/book_appointment.dart';
import '../../view/categories/categories.dart';
import '../../view/category/categeory_view.dart';
import '../../view/doctor_detail/doctordetail_view.dart';
import '../../view/doctor_profile/doctor_profile.dart';
import '../../view/home/home_view.dart';
import '../../view/login/login_view.dart';
import '../../view/new_password/new_password_view.dart';
import '../../view/onboarding/onboarding_view.dart';
import '../../view/otp/otp_view.dart';
import '../../view/profile/profile_view.dart';
import '../../view/profile_bottom/profile_bottom_view.dart';
import '../../view/register/registration_view.dart';
import '../../view/video_messenger/video_messenger.dart';
import '../../view/voice_messenger/voice_messenger.dart';
import '../../viewmodel/binding/appointments/check_appointments_binding.dart';
import '../../viewmodel/binding/book_appointment/book_appointment_binding.dart';
import '../../viewmodel/binding/categories/categories_binding.dart';
import '../../viewmodel/binding/categories_/categories_binding.dart';
import '../../viewmodel/binding/dashboard/dashboard_binding.dart';
import '../../viewmodel/binding/doctor_detail/doctor_detail_binding.dart';
import '../../viewmodel/binding/doctor_profile/doctor_profile_binding.dart';
import '../../viewmodel/binding/home/home_binding.dart';
import '../../viewmodel/binding/login/login_binding.dart';
import '../../viewmodel/binding/onboarding/onboarding_binding.dart';
import '../../viewmodel/binding/profile/profile_binding.dart';
import '../../viewmodel/binding/register/register_binding.dart';
import '../../viewmodel/binding/video_messenger/video_messenger_binding.dart';
import '../../viewmodel/binding/voice_messenger/voice_messenger_binding.dart';



class Pages {
  static appRoutes() => [
        GetPage(
          name: Routes.onboardingView,
          page: () => const OnboardingView(),
          binding: OnBoardingBinding(),
        ),
        GetPage(
          name: Routes.loginView,
          page: () => const LoginView(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: Routes.registerView,
          page: () => const RegisterView(),
          binding: RegisterBinding(),
        ),
        GetPage(
          name: Routes.otpView,
          page: () => const OtpView(),
          // binding: RegisterBinding(),
        ),
        GetPage(
          name: Routes.newPassword,
          page: () => const NewPassword(),
          // binding: RegisterBinding(),
        ),
        GetPage(
          name: Routes.profileView,
          page: () => const ProfileView(),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: Routes.homeView,
          page: () => const HomeView(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: Routes.dashboard,
          page: () => const BottomWidget(),
          binding: DashboardBinding(),
        ),
        GetPage(
          name: Routes.category,
          page: () => const CategoryView(),
          binding: CategoryBinding(),
        ),
        GetPage(
          name: Routes.doctorDetail,
          page: () => const DoctorDetail(),
          binding: DoctorDetailBinding(),
        ),
        GetPage(
          name: Routes.bookAppointment,
          page: () => const BookAppointment(),
          binding: BookAppointmentBinding(),
        ),
        GetPage(
          name: Routes.doctorProfile,
          page: () => const DoctorProfile(),
          binding: DoctorProfileBinding(),
        ),
        GetPage(
          name: Routes.checkAppointments,
          page: () => const CheckAppointments(),
          binding: CheckAppointmentBinding(),
        ),
         GetPage(
          name: Routes.categories,
          page: () => const CategoriesView(),
          binding: CategoriesBinding(),
        ),
         GetPage(
          name: Routes.checkProfile,
          page: () => const ProfileBottom(),
          // binding: CategoriesBinding(),
        ),
         GetPage(
          name: Routes.videoPage,
          page: () => const VideoCallPage(),
          binding: VideoMessengerBinding(),
        ),  GetPage(
          name: Routes.voicePage,
          page: () => const VoiceCallPage(),
          binding: VoiceMessengerBinding(),
        ),
      ];
}
