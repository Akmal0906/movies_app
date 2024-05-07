import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'carousel_state.dart';

class CarouselCubit extends Cubit<CarouselInitial> {
  CarouselCubit() : super(const CarouselInitial(0));

  changeIndex(int index){
    emit(CarouselInitial(index));
  }
}
