
class HostgroupRequestModel {
  String auth_hostgroup;

  HostgroupRequestModel({
    required this.auth_hostgroup,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "jsonrpc": "2.0",
      "method": "hostgroup.get",
      "params": {
        "output": [
          "name"
        ],
        "sortfield": "name",
        "monitored_hosts": "true"
      },
      "auth": "${auth_hostgroup}",
      "id": 1
    };
    return map;
  }
}
