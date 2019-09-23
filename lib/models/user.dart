class User{

  String id;
  String userName;
  String email;
  String password;
  String userType;
  String registerTime;

  User(
    this.id,
    this.userName,
    this.email,
    this.password,
    this.userType,
    this.registerTime);

  User.fromJson(Map<String, dynamic> data) {
    id = data['id'] ;
    userName = data['user_name'] ;
    email = data['e_mail'] ;
    password = data['password'] ;
    userType = data['user_type'] ;
    registerTime = data['register_time'] ;
  }
}