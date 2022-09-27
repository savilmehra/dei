import '../model/product_entity.dart';
import '../model/products_response.dart';

abstract class MainState {}

class LoadingState extends MainState {}

class LoadedState extends MainState {
  final List<Items> products;
  LoadedState({required this.products});
}

class ErrorState extends MainState {
final  String errorMessage;

  ErrorState(this.errorMessage);

}

class EmptyState extends MainState {
  final  String errorMessage;
  EmptyState(this.errorMessage);
}
