///获取user信息,便于区分不同用户
abstract class UserIdProvider {
  String? getUserId();
}
