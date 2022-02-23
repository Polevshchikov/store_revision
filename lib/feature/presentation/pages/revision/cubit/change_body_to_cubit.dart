import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'change_body_to_state.dart';

@injectable
class ChangeBodyToCubit extends Cubit<ChangeBodyToState> {
  ChangeBodyToCubit() : super(ShowRevisionState());

  void changeToRevision() => emit(ShowRevisionState());
  void changeToAddProduct() => emit(ShowProductAddState());
}
