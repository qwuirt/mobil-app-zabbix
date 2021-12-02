
class ScriptsHostRequestModel {
  String auth_host;
  String groupids;

  ScriptsHostRequestModel({
    required this.auth_host,
    required this.groupids,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "jsonrpc": "2.0",
      "method": "host.get",
      "params": {
        "output": "name",
        "sortfield": "name",
        "groupids": "${groupids}"
      },
      "auth": "${auth_host}",
      "id": 1
    };
    return map;
  }
}
