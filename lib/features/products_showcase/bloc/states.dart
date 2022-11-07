

import '../models/fielSpinResponse.dart';

abstract class MainState {}

class LoadingState extends MainState {}

class LoadedState extends MainState {
  final List<FileSpinFiles> products;
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
