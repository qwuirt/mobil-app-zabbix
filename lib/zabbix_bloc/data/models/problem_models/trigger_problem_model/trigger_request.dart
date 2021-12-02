class TriggerRequestModel {
  String auth_triger;

  TriggerRequestModel({
    required this.auth_triger,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "jsonrpc": "2.0",
      "method": "trigger.get",
      "params": {
        "output": [
          "triggerid",
          "description",
          "value",
          "priority",
          "manual_close"
        ],
        "monitored": "true",
        "sortfield": "lastchange",
        "filter": {
          "value": 1,
          "status": 0
        },
        "sortorder": "DESC",
        "skipDependent": "true",
        "selectHosts": [
          "hostid",
          "name",
          "status"
        ],
        "selectLastEvent": "eventid"
      },
      "auth": "${auth_triger.trim()}",
      "id": 1
    };
    return map;
  }
}
