
class ConfirmationProblemRequestModel {
  String auth_problem;
  String eventid;
  String action;
  String message;

  ConfirmationProblemRequestModel({
    required this.auth_problem,
    required this.eventid,
    required this.action,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "jsonrpc": "2.0",
      "method": "event.acknowledge",
      "params": {
        "eventids": "$eventid",
        "action": "$action",
        "message": "$message"
      },
      "auth": "$auth_problem",
      "id": 1
    };
    return map;
  }
}
