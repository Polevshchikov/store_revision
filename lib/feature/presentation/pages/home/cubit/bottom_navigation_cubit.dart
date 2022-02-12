import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/feature/presentation/pages/home/ui/utils/enum_navbar_items.dart';

part 'bottom_navigation_state.dart';

@injectable
class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(BottomNavigationProfile());

  void changeScreen(NavbarItems itemName) {
    switch (itemName) {
      case NavbarItems.achievements:
        emit(BottomNavigationAchievements());
        break;
      case NavbarItems.forum:
        emit(BottomNavigationProfile());
        break;
      default:
        emit(BottomNavigationProfile());
    }
  }
}
