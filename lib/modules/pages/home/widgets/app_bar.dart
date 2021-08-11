import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/shared/utils/app_constants.dart';
import 'package:pokedex/theme/app_theme.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: false,
      expandedHeight: 170.0,
      collapsedHeight: 70,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 17),
          child: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
            color: Colors.black,
          ),
        )
      ],
      backgroundColor: AppTheme.colors.background,
      flexibleSpace: Stack(children: [
        FlexibleSpaceBar(
          centerTitle: false,
          titlePadding: EdgeInsets.only(left: 15, bottom: 10),
          title: Row(
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (_, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * pi,
                    child: child,
                  );
                },
                child: SvgPicture.asset(
                  AppConstants.blackPokeballLogo,
                  height: 24,
                  width: 24,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text("Pokedex", style: AppTheme.texts.homePageTitle),
            ],
          ),
        ),
      ]),
    );
  }
}
