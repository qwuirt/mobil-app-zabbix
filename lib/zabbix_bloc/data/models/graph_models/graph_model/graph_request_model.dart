
class GraphRequestModel {
  String auth_graph;
  String hostids;

  GraphRequestModel({
    required this.auth_graph,
    required this.hostids,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "jsonrpc": "2.0",
      "method": "graph.get",
      "params": {
        "output": [
          "name"
        ],
        "hostids": "${hostids}",
        "sortfield": "name"
      },
      "auth": "${auth_graph}",
      "id": 1
    };
    return map;
  }
}
