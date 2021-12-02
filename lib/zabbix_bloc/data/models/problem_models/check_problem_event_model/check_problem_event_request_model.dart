
class CheckProblemEventRequestModel {
  String auth_problem;
  String eventids;

  CheckProblemEventRequestModel({
    required this.auth_problem,
    required this.eventids,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "jsonrpc": "2.0",
      "method": "event.get",
      "params": {
        "output": [
          "acknowledges",
          "eventid"
        ],
        "select_acknowledges": [
          "message",
          "alias",
          "clock"
        ],
        "eventids": "$eventids"
      },
      "auth": "$auth_problem",
      "id": 1
    };
    return map;
  }
}
