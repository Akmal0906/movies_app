part of 'carousel_cubit.dart';

sealed class CarouselState extends Equatable {
  const CarouselState();
}

final class CarouselInitial extends Equatable {
  final int index;
  const CarouselInitial(this.index);
  @override
  List<Object> get props => [index];
}
