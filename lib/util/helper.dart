import 'package:flutter/material.dart';


Iterable<E> mapIndexed<E, T>(
    Iterable<T> items, E Function(int index, T item) f) sync* {
  var index = 0;

  for (final item in items) {
    yield f(index, item);
    index = index + 1;
  }
    }



class SlideUpRoute extends PageRouteBuilder {
  final Widget page;
  SlideUpRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
        );
}

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
    bool fullscreenDialog = false,
  }) : super(builder: builder, settings: settings, fullscreenDialog: fullscreenDialog);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    final PageTransitionsTheme theme = Theme.of(context).pageTransitionsTheme;
    Animation<double> onlyForwardAnimation;
    
    switch (animation.status) {
      case AnimationStatus.reverse:
      case AnimationStatus.dismissed:
      case AnimationStatus.forward:
          onlyForwardAnimation = kAlwaysDismissedAnimation;
          break;
      case AnimationStatus.completed:
        onlyForwardAnimation = animation;
        break;
    }
    return theme.buildTransitions<T>(this, context, onlyForwardAnimation, secondaryAnimation, child);
  }
}