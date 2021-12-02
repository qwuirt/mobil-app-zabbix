
class GraphHostgroupRequestModel {
  String auth_hostgroup_graph;

  GraphHostgroupRequestModel({
    required this.auth_hostgroup_graph,
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
      "auth": "${auth_hostgroup_graph}",
      "id": 1
    };
    return map;
  }
}
