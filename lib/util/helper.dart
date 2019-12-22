import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
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
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}

// class SlideBack extends PageRouteBuilder {
//   final Widget page;
//   SlideBack({this.page})
//       : super(
//             pageBuilder: (
//               BuildContext context,
//               Animation<double> animation,
//               Animation<double> secondaryAnimation,
//             ) =>
//                 page,
//             transitionsBuilder: (
//               BuildContext context,
//               Animation<double> animation,
//               Animation<double> secondaryAnimation,
//               Widget child,
//             ) =>
//                 SlideTransition(
//                   position: AlignmentTween(
//                     begin: const Offset(0.0, 1.0),
//                     end: Offset.zero,
//                   ).animate(animation),
//                   child: SlideTransition(
//                     position: TweenOffset(
//                       begin: Offset.zero,
//                       end: const Offset(0.0, 1.0),
//                     ).animate(secondaryAnimation),
//                     child: child,
//                   ),
//                 ));
// }
