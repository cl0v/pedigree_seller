import 'dart:async';

import 'package:rxdart/subjects.dart';

class SimpleBloc<T> {
  final _controller = StreamController<T>();
  Stream<T> get stream => _controller.stream;

  add(T obj) {
    if (!_controller.isClosed) {
      _controller.add(obj);
    }
  }

  subscribe(Stream<T> s) {
    _controller.addStream(s);
  }

  addError(Object obj) {
    if (!_controller.isClosed) {
      _controller.addError(obj);
    }
  }

  dispose() {
    _controller.close();
  }
}

class BehaviorBloc<T> {
  final _controller = BehaviorSubject<T>();
  Stream<T> get stream => _controller.stream;

  add(T obj) {
    if (!_controller.isClosed) {
      _controller.add(obj);
    }
  }

  subscribe(Stream<T> s) {
    _controller.addStream(s);
  }

  addError(Object obj) {
    if (!_controller.isClosed) {
      _controller.addError(obj);
    }
  }

  dispose() {
    _controller.close();
  }

}
