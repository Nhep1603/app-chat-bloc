import 'package:chat_app_bloc/bloc/account_directories/account_directories_bloc.dart';
import 'package:chat_app_bloc/bloc/authentication/authentication_bloc.dart';
import 'package:chat_app_bloc/bloc/home/home_bloc.dart';
import 'package:chat_app_bloc/repository/repo_user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'account_directories/account_directories.dart';
import 'chat_list/chat_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final currentUser =
        context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
            context.select((HomeBloc bloc) => bloc.state is HomeChatList)
                ? 'Chat'
                : 'Account Directories'),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipOval(
            child: Image.network(
              currentUser.img,
              fit: BoxFit.cover,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthenticationBloc>().add(AuthenticationLoggedOut());
            },
            icon: const FaIcon(
              FontAwesomeIcons.signOutAlt,
              color: Color(0xff0D83D6),
            ),
            tooltip: 'Sign out',
          )
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (value) {
          if (value == 0) {
            context.read<HomeBloc>().add(HomeLoadedChatList());
          } else {
            context.read<HomeBloc>().add(HomeLoadedAccountDirectories());
          }
          _pageController.animateToPage(
            value,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        children: [
          const ChatList(),
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AccountDirectoriesBloc(
                  repoUserList: context.read<RepoUserList>(),
                )..add(AccountDirectoriesStarted()),
              ),
            ],
            child: const AccountDirectories(),
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(45.0),
          topLeft: Radius.circular(45.0),
        ),
        child: BottomNavigationBar(
          selectedItemColor: const Color(0xff15099F),
          currentIndex:
              context.select((HomeBloc bloc) => bloc.state is HomeChatList)
                  ? 0
                  : 1,
          onTap: (value) {
            _pageController.animateToPage(
              value,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.comment,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.user,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
