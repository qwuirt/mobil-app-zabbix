
class GraphHostRequestModel {
  String auth_host_graph;
  String groupids;

  GraphHostRequestModel({
    required this.auth_host_graph,
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
      "auth": "${auth_host_graph}",
      "id": 1
    };
    return map;
  }
}
