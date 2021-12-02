
class ProblemEventRequestModel {
  String auth_problem;
  String trigger;

  ProblemEventRequestModel({
    required this.auth_problem,
    required this.trigger,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "jsonrpc": "2.0",
      "method": "event.get",
      "params": {
        "output": [
          "acknowledged",
          "eventid",
          "clock",
          "value"
        ],
        "select_acknowledges": [
          "message"
        ],
        "limit": "50",
        "sortfield": "clock",
        "sortorder": "DESC",
        "objectids": "$trigger"
      },
      "auth": "$auth_problem",
      "id": 1
    };
    return map;
  }
}
