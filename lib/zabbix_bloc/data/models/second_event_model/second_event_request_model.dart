class SecondEventRequestModel {
  List eventids;
  String second_auth_event;

  SecondEventRequestModel({
    required this.eventids,
    required this.second_auth_event,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "jsonrpc": "2.0",
      "method": "event.get",
      "params": {
        "output": [
          "clock",
          "r_eventid"
        ],
        "eventids": eventids,
      },
      "auth": "${second_auth_event}",
      "id": 1
    };
    return map;
  }
}


