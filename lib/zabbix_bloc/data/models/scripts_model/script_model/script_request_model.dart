
class ScriptRequestModel {
  String auth_script;
  String hostids;

  ScriptRequestModel({
    required this.auth_script,
    required this.hostids,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "jsonrpc": "2.0",
      "method": "script.get",
      "params": {
        "output": [
          "name",
          "scriptid"
        ],
        "sortfield": "name",
        "hostids": "${hostids}"
      },
      "auth": "${auth_script}",
      "id": 1
    };
    return map;
  }
}
