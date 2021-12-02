
class OverviewHostgroupRequestModel {
  String auth_hostgroup_overview;

  OverviewHostgroupRequestModel({
    required this.auth_hostgroup_overview,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "jsonrpc": "2.0",
      "method": "hostgroup.get",
      "params": {
        "output": [
          "name"
        ],
        "sortfield": "name"
      },
      "auth": "${auth_hostgroup_overview}",
      "id": 1
    };
    return map;
  }
}
