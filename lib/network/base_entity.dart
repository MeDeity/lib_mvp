class BaseEntity<T> {
  ///错误代码
  int code;
  ///主要应对一些接口的code返回值是字符串的问题(SUCCESS OR FAIL)
  String status;
  ///错误消息
  String message;
  ///接口返回的数据
  T data;
  ///总条数
  int total;

  BaseEntity(this.code,this.message, this.data,{this.status:"FAILED",this.total:0});
}
