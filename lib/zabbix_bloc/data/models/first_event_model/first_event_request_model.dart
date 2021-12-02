class FirstEventRequestModel {
  String time_from;
  String time_till;
  String first_auth_event;

  FirstEventRequestModel({
    required this.time_from,
    required this.time_till,
    required this.first_auth_event,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "jsonrpc": "2.0",
      "method": "event.get",
      "params": {
        "output": [
          "clock",
          "acknowledged",
          "name",
          "hosts",
          "r_eventid",
          "severity"
        ],
        "time_from": "${time_from}",
        "time_till": "${time_till}",
        "selectHosts":[
          "name"
        ],
        "filter": {
          "value": 1
        },
        "sortfield": "eventid",
        "sortorder": "DESC"
      },
      "auth": "${first_auth_event}",
      "id": 1
    };
    return map;
  }
}


