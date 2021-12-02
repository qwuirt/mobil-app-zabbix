
class LoginRequestModel  {
  String login;
  String password;

  LoginRequestModel({
    required this.login,
    required this.password,
});




  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "jsonrpc": "2.0",
      "method": "user.login",
      "params": {
        "user": "${login.trim()}",
        "password": "${password.trim()}",
      },
      "id": 1,
    };
    return map;
  }
}