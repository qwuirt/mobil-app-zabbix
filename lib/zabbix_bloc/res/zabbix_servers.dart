class ZabbixServers {
  String urlApi;
  String username;
  String password;
  dynamic valueItemProblems;
  String selectPriorityProblems;
  dynamic valueItemSystemStatus;
  String selectPrioritySystemStatus;

  ZabbixServers({
    this.urlApi = '',
    this.username = '',
    this.password = '',
    this.selectPrioritySystemStatus = '0',
    this.selectPriorityProblems = '0',
    this.valueItemProblems = '',
    this.valueItemSystemStatus = '',
  });
}