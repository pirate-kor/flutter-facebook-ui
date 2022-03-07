import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_ui/config/palette.dart';
import 'package:flutter_facebook_ui/datas/data.dart';
import 'package:flutter_facebook_ui/models/models.dart';
import 'package:flutter_facebook_ui/widgets/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile: _HomeScreenMobile(),
          desktop: _HomeScreenDesktop(),
        ),
      ),
    );
  }
}

class _HomeScreenMobile extends StatelessWidget {
  const _HomeScreenMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Colors.white,
          title: Text(
            'facebook',
            style: const TextStyle(
              color: Palette.facebookBlue,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2,
            ),
          ),
          centerTitle: false,
          floating: true,
          actions: [
            CircleButton(
                icon: Icons.search,
                iconSize: 30.0,
                onPressed: () {
                  print('Search');
                }),
            CircleButton(
                icon: MdiIcons.facebookMessenger,
                iconSize: 30.0,
                onPressed: () {
                  print('Messenger');
                }),
          ],
        ),
        SliverToBoxAdapter(
          child: CreatePostContainer(
            currentUser: currentUser,
          ),
        ),
        SliverPadding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
            sliver: SliverToBoxAdapter(
              child: Rooms(onlineUsers: onlineUsers),
            )),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
          sliver: SliverToBoxAdapter(
            child: Stories(currentUser: currentUser, stories: stories),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          final Post post = posts[index];
          return PostContainer(post: post);
        }, childCount: posts.length))
      ],
    );
  }
}

class _HomeScreenDesktop extends StatelessWidget {
  const _HomeScreenDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            flex: 2,
            child: Container(
              color: Colors.orange,
            )),
        const Spacer(),
        Container(
            width: 600.0,
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                    padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                    sliver: SliverToBoxAdapter(
                      child: Rooms(onlineUsers: onlineUsers),
                    )),
                SliverToBoxAdapter(
                  child: CreatePostContainer(
                    currentUser: currentUser,
                  ),
                ),
                
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                  sliver: SliverToBoxAdapter(
                    child: Stories(currentUser: currentUser, stories: stories),
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  final Post post = posts[index];
                  return PostContainer(post: post);
                }, childCount: posts.length))
              ],
            )),
        const Spacer(),
        Flexible(
            flex: 2,
            child: Container(
              color: Colors.orange,
            )),
      ],
    );
  }
}
