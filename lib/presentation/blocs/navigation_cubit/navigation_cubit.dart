import 'package:bloc/bloc.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(0));

  changeIndex(int index) {
    emit(NavigationState(index));
  }
}
