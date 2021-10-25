part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState({required this.page});

  final int page;

  @override
  List<Object> get props => [page];
}

class HomeChatList extends HomeState {
  const HomeChatList() : super(page: 0);
}

class HomeAccountDirectories extends HomeState {
  const HomeAccountDirectories() : super(page: 1);
}
