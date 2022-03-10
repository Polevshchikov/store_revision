import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/feature/presentation/pages/home/ui/utils/enum_navbar_items.dart';

part 'bottom_navigation_state.dart';

@injectable
class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(BottomNavigationActive());

  void changeScreen(NavbarItems itemName) {
    switch (itemName) {
      case NavbarItems.archive:
        emit(BottomNavigationArchive());
        break;
      case NavbarItems.active:
        emit(BottomNavigationActive());
        break;
      case NavbarItems.pdf:
        emit(BottomNavigationPdf());
        break;
      default:
        emit(BottomNavigationActive());
    }
  }
}
