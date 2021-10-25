import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeChatList()) {
    on<HomeLoadedChatList>(_onLoadChatList);
    on<HomeLoadedAccountDirectories>(_onLoadAccountDirectories);
  }

  _onLoadChatList(HomeLoadedChatList event, Emitter<HomeState> emit) {
    emit(const HomeChatList());
  }

  _onLoadAccountDirectories(HomeLoadedAccountDirectories event, Emitter<HomeState> emit) {
    emit(const HomeAccountDirectories());
  }

}
