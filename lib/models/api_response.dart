enum Status {
  EMPTY,
  LOADING,
  COMPLETED,
  ERROR,
}

class ApiResponse<T> {
  Status status;
  T? data;
  String? message;

  ApiResponse.empty() : status = Status.EMPTY;
  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.COMPLETED;
  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return 'Status: $status with message $message\nData: $data';
  }
}
