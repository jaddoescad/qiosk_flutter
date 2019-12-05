import 'package:flutter/material.dart';

Iterable<E> mapIndexed<E, T>(
    Iterable<T> items, E Function(int index, T item) f) sync* {
  var index = 0;

  for (final item in items) {
    yield f(index, item);
    index = index + 1;
  }
    }





  // String _validateEmail(String value) {
  //   if (Validate.isEmail(" ") == true) {
  //     return 'The E-mail Address must be a valid email address.';
  //   }

  //   return null;
  // }

  // // Add validate password function.
  // String _validatePassword(String value) {
  //   if (value.length < 8) {
  //     return 'The Password must be at least 8 characters.';
  //   }
    
  //   return null;
  // }

// class SlideUpRoute extends PageRouteBuilder {
//   final Widget page;
//   SlideUpRoute({this.page})
//       : super(
//           pageBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//           ) =>
//               page,
//           transitionsBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//             Widget child,
//           ) =>
//               SlideTransition(
//                 position: Tween<Offset>(
//                   begin: const Offset(0, 1),
//                   end: Offset.zero,
//                 ).animate(animation),
//                 child: child,
//               ),
//         );
// }

// class SlideUpRoute<T> extends MaterialPageRoute<T> {
//   SlideUpRoute({
//     @required WidgetBuilder builder,
//     RouteSettings settings,
//     bool fullscreenDialog = false,
//   }) : super(builder: builder, settings: settings, fullscreenDialog: fullscreenDialog);

//   @override
//   Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
//     final PageTransitionsTheme theme = Theme.of(context).pageTransitionsTheme;
//     Animation<double> onlyForwardAnimation;
//     switch (animation.status) {
//       case AnimationStatus.reverse:
//         // onlyForwardAnimation = animation;
//         break;
//       case AnimationStatus.dismissed:
//       case AnimationStatus.forward:
//           // onlyForwardAnimation = animation;
//           break;
//       case AnimationStatus.completed:
//         // onlyForwardAnimation = animation;
//         break;
//     }
//     return SlideTransition(
//                 position: Tween<Offset>(
//                   begin: const Offset(1, 0),
//                   end:const Offset(0, 0),
//                 ).animate(animation),
//                 child: child
//     );
//   }
// }

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


// class CustomPageRoute<T> extends MaterialPageRoute<T> {
//   CustomPageRoute({
//     @required WidgetBuilder builder,
//     RouteSettings settings,
//     bool fullscreenDialog = false,
//   }) : super(builder: builder, settings: settings, fullscreenDialog: fullscreenDialog);

//   @override
//   Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
//     final PageTransitionsTheme theme = Theme.of(context).pageTransitionsTheme;
//     Animation<double> onlyForwardAnimation;
//     switch (animation.status) {
//       case AnimationStatus.reverse:
//       print("reverse");
//         onlyForwardAnimation = animation;
//         break;
//       case AnimationStatus.dismissed:
//       print("dismissed");
//         onlyForwardAnimation = kAlwaysDismissedAnimation;
//         break;
//       case AnimationStatus.forward:
//       print("forward");
//           onlyForwardAnimation = kAlwaysCompleteAnimation;
//           break;
//       case AnimationStatus.completed:
//       print("complete");
//         onlyForwardAnimation = animation;
//         break;
//     }
//     return SlideTransition(
//                 position: Tween<Offset>(
//                   begin: const Offset(1, 0),
//                   end: Offset.zero,
//                 ).animate(onlyForwardAnimation),
//                 child: child
//     );
//   }
// }