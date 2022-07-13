import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/base/base_state.dart';

abstract class BaseCubit<St extends BaseState> extends Cubit<St> {
  BaseCubit(St initialState) : super(initialState);

  void dispose() {}

  void init() {}
}
