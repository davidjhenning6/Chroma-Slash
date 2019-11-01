import 'package:flutter/widgets.dart';

/// This class is used for a custom route that has
/// no back gesture.
class NoBackRoute extends PageRoute<void> {
  final WidgetBuilder builder;
  NoBackRoute({
    @required this.builder,
    RouteSettings settings,
  }) : super(settings: settings, fullscreenDialog: false);

  @override
  bool get opaque => true;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 150);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final res = builder(context);
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: res,
      ),
    );
  }
}
