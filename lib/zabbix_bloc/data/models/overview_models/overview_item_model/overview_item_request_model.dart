
class OverviewItemRequestModel {
  String auth_overview;
  String hostids;

  OverviewItemRequestModel({
    required this.auth_overview,
  required this.hostids,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "jsonrpc": "2.0",
      "method": "item.get",
      "params": {
        "output": [
          "lastvalue",
          "name",
          "units",
          "value_type"
        ],
        "hostids": "${hostids}",
        "sortfield": "name"
      },
      "auth": "${auth_overview}",
      "id": 1
    };
    return map;
  }
}
