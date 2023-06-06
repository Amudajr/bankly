class TransactionsModel {
  String? trnAmount;
  String? trnCounterPartyService;
  String? trnDate;
  String? trnCounterpartyBankCode;
  String? trnContractReference;
  String? trnPaymentReference;
  String? trnCounterPartyReference;
  String? logourl;
  String? trnDrCr;
  String? accountNumber;
  String? accountName;
  String? counterPartyAccountNumber;
  String? counterPartyAccountName;
  String? journalNarration;
  String? trnCounterPartyBankName;
  String? ftCounterPartySwitchCode;
  String? trnNarration;
  String? source;
  String? bankCode;
  String? branchCode;
  String? maker;
  String? checker;
  String? bankName;
  String? trnId;

  TransactionsModel(
      {this.trnAmount,
      this.trnCounterPartyService,
      this.trnDate,
      this.trnCounterpartyBankCode,
      this.trnContractReference,
      this.trnPaymentReference,
      this.trnCounterPartyReference,
      this.logourl,
      this.trnDrCr,
      this.accountNumber,
      this.accountName,
      this.counterPartyAccountNumber,
      this.counterPartyAccountName,
      this.journalNarration,
      this.trnCounterPartyBankName,
      this.ftCounterPartySwitchCode,
      this.trnNarration,
      this.source,
      this.bankCode,
      this.branchCode,
      this.maker,
      this.checker,
      this.bankName,
      this.trnId});

  TransactionsModel.fromJson(Map<String, dynamic> json) {
    trnAmount = json['trnAmount'];
    trnCounterPartyService = json['trnCounterPartyService'];
    trnDate = json['trnDate'];
    trnCounterpartyBankCode = json['trnCounterpartyBankCode'];
    trnContractReference = json['trnContractReference'];
    trnPaymentReference = json['trnPaymentReference'];
    trnCounterPartyReference = json['trnCounterPartyReference'];
    logourl = json['logourl'];
    trnDrCr = json['trnDrCr'];
    accountNumber = json['accountNumber'];
    accountName = json['accountName'];
    counterPartyAccountNumber = json['counterPartyAccountNumber'];
    counterPartyAccountName = json['counterPartyAccountName'];
    journalNarration = json['journalNarration'];
    trnCounterPartyBankName = json['trnCounterPartyBankName'];
    ftCounterPartySwitchCode = json['ftCounterPartySwitchCode'];
    trnNarration = json['trnNarration'];
    source = json['source'];
    bankCode = json['bankCode'];
    branchCode = json['branchCode'];
    maker = json['maker'];
    checker = json['checker'];
    bankName = json['bankName'];
    trnId = json['trnId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trnAmount'] = trnAmount;
    data['trnCounterPartyService'] = trnCounterPartyService;
    data['trnDate'] = trnDate;
    data['trnCounterpartyBankCode'] = trnCounterpartyBankCode;
    data['trnContractReference'] = trnContractReference;
    data['trnPaymentReference'] = trnPaymentReference;
    data['trnCounterPartyReference'] = trnCounterPartyReference;
    data['logourl'] = logourl;
    data['trnDrCr'] = trnDrCr;
    data['accountNumber'] = accountNumber;
    data['accountName'] = accountName;
    data['counterPartyAccountNumber'] = counterPartyAccountNumber;
    data['counterPartyAccountName'] = counterPartyAccountName;
    data['journalNarration'] = journalNarration;
    data['trnCounterPartyBankName'] = trnCounterPartyBankName;
    data['ftCounterPartySwitchCode'] = ftCounterPartySwitchCode;
    data['trnNarration'] = trnNarration;
    data['source'] = source;
    data['bankCode'] = bankCode;
    data['branchCode'] = branchCode;
    data['maker'] = maker;
    data['checker'] = checker;
    data['bankName'] = bankName;
    data['trnId'] = trnId;
    return data;
  }
}
