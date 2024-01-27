part of 'nobooks_app.dart';

class NobooksWidgetInitializer extends StatelessWidget {
  final Widget child;

  const NobooksWidgetInitializer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: child,
    );
  }
}
