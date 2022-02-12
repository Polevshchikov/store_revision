part of 'bottom_navigation_cubit.dart';

abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

class BottomNavigationAchievements extends BottomNavigationState {
  final int itemIndex = 0;
}

class BottomNavigationProfile extends BottomNavigationState {
  final int itemIndex = 1;
}
