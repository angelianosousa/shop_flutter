import 'package:flutter/material.dart';

class CounterState {
  int _value = 0;

  void inc() => _value++;
  void dec() => _value--;
  
  int get value => _value;

  bool diff(CounterState old){
    return _value != old._value;
  }
}

class CounterProvider extends InheritedWidget {
  final CounterState state = CounterState();

  CounterProvider({super.key, required super.child});

  static CounterProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(covariant CounterProvider oldWidget) {
    return oldWidget.state.diff(state);
  }
  
}