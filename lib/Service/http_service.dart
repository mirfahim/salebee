class HttpService<T> {
  bool isSuccessful;
  T data;
  String message;
  int reponseCode;
  HttpService(this.isSuccessful, this.data, this.message, this.reponseCode);
}