class CoinModel {
  String? code;
  String? codein;
  String? name;
  double? high;
  double? low;
  double? varBid;
  double? pctChange;
  double? bid;
  double? ask;
  String? timestamp;
  String? createDate;
  String? iconPath;

  CoinModel({
    this.code,
    this.codein,
    this.name,
    this.high,
    this.low,
    this.varBid,
    this.pctChange,
    this.bid,
    this.ask,
    this.timestamp,
    this.createDate,
    this.iconPath,
  });

  CoinModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    codein = json['codein'];
    name = json['name'];
    high = double.parse(json['high']);
    low = double.parse(json['low']);
    varBid = double.parse(json['varBid']);
    pctChange = double.parse(json['pctChange']);
    bid = double.parse(json['bid']);
    ask = double.parse(json['ask']);
    timestamp = json['timestamp'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['codein'] = this.codein;
    data['name'] = this.name;
    data['high'] = this.high;
    data['low'] = this.low;
    data['varBid'] = this.varBid;
    data['pctChange'] = this.pctChange;
    data['bid'] = this.bid;
    data['ask'] = this.ask;
    data['timestamp'] = this.timestamp;
    data['create_date'] = this.createDate;
    return data;
  }
}
