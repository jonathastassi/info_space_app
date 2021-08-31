abstract class IRoutes {
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName,
  );

  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  });

  void pop<T extends Object?>([T? result]);
}
