void stateListener<T>(
  void Function() listener,
) {
  Future.delayed(const Duration(milliseconds: 200), (() {
    listener.call();
  }));
}
