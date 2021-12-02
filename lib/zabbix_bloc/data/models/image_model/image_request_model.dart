class ImageRequestModel {
  String auth;
  String imageids;

  ImageRequestModel({
    required this.auth,
    required this.imageids,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "jsonrpc": "2.0",
      "method": "image.get",
      "params": {
        "output": "extend",
        "select_image": true,
        "imageids": imageids,
      },
      "auth": "$auth",
      "id": 1
    };
    return map;
  }
}
