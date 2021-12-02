
class GraphImageRequestModel {
  String auth_image_graph;
  String groupids;

  GraphImageRequestModel({
    required this.auth_image_graph,
    required this.groupids,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "jsonrpc": "2.0",
      "method": "image.get",
      "params": {
        "output": "extend",
        "select_image": true,
        "imageids": "58"
      },
      "auth": "${auth_image_graph}",
      "id": 1
    };
    return map;
  }
}
