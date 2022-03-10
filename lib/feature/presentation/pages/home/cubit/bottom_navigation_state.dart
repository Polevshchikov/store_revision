part of 'bottom_navigation_cubit.dart';

abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

class BottomNavigationPdf extends BottomNavigationState {
  final int itemIndex = 2;
}

class BottomNavigationArchive extends BottomNavigationState {
  final int itemIndex = 1;
}

class BottomNavigationActive extends BottomNavigationState {
  final int itemIndex = 0;
}
