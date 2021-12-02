
class ScriptExecuteRequestModel {
  String auth_script;
  String hostids;
  String scriptid;

  ScriptExecuteRequestModel({
    required this.auth_script,
    required this.hostids,
    required this.scriptid,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "jsonrpc": "2.0",
      "method": "script.execute",
      "params": {
        "scriptid": "${scriptid}",
        "hostid": "${hostids}"
      },
      "auth": "${auth_script}",
      "id": 1
    };
    return map;
  }
}
