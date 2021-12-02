
class OverviewHostRequestModel {
  String auth_host_overview;
  String groupids;

  OverviewHostRequestModel({
    required this.auth_host_overview,
    required this.groupids,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "jsonrpc": "2.0",
      "method": "host.get",
      "params": {
        "output": "name",
        "sortfield": "name",
        "groupids": "${groupids}"
      },
      "auth": "${auth_host_overview}",
      "id": 1
    };
    return map;
  }
}
