
class ItemHistoryRequestModel {
  String auth;
  String itemid;
  String time_from;
  String history;

  ItemHistoryRequestModel({
    required this.auth,
    required this.itemid,
    required this.time_from,
    required this.history,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "jsonrpc": "2.0",
      "method": "history.get",
      "params": {
        "output": "extend",
        "sortfield": "clock",
        "sortorder": "DESC",
        "itemids": "$itemid",
        "history": "$history",
        "time_from": "$time_from"
      },
      "auth": "$auth",
      "id": 1
    };
    return map;
  }
}
