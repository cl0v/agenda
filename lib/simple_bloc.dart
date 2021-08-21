import 'dart:async';

class SimpleBloc<T> {
  StreamController<T> _controller = StreamController<T>.broadcast();
  StreamSink<T> get _input => _controller.sink;
  Stream<T> get stream => _controller.stream;

  add(T event) {
    print(event);
    _input.add(event);
  }

  dispose() {
    _controller.close();
  }
}
