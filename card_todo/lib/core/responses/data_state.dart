class DataState<Fail, Success> {
  Success? data;
  Fail? failure;
  DataState({this.data, this.failure});

  void run(
      {required Function(Success? data) success,
      required Function(Fail? failure) error}) {
    if (this is DataFailed) {
      error(this.failure);
    }
    if (this is DataSuccess) {
      success(this.data);
    }
  }
}

class DataSuccess<Fail, Success> extends DataState<Fail, Success> {
  DataSuccess([Success? data]) : super(data: data);
}

class DataFailed<Fail, Success> extends DataState<Fail, Success> {
  DataFailed(Fail failure) : super(failure: failure);
}
