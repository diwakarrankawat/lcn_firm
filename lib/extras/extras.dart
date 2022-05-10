import 'package:flutter/material.dart';

enum dataState { loading, success, error }
enum Gender { unselected, male, female }

class DataHolder {
  dynamic data;
  dataState state = dataState.loading;
  Exception? error;

  void loaded(dynamic data) {
    this.data = data;
    state = dataState.success;
  }

  void failed(dynamic error) {
    this.error = error;
    state = dataState.error;
  }
}


//InputDecoration = Decora