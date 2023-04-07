class Account {
  String id;
  String name;
  String userId;
  DateTime? createdTime;
  DateTime? updateTime;

  Account(
      {this.id = '',
      this.name = '',
      this.userId = '',
      this.createdTime,
      this.updateTime});
}
