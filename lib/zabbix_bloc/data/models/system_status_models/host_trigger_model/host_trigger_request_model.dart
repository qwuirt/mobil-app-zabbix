class HostTriggerRequestModel {
  String host_trigger_auth;

  HostTriggerRequestModel({
    required this.host_trigger_auth,
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
        "filter": {"value": 1, "status": 0},
        "sortorder": "DESC",
        "skipDependent": "true",
        "selectHosts": ["hostid", "name", "status"],
        "selectGroups": ["gropid", "name"],
        "selectLastEvent": "eventid"
      },
      "auth": "$host_trigger_auth",
      "id": 1
    };
    return map;
  }
}
