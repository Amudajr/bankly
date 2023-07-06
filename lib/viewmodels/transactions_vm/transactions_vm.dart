import '../../models/transactions_model.dart';
import '../../repository/api_client.dart';
import '../../repository/api_response.dart';
import '../../services/endpoint.dart';

class TransactionsViewModel {
  static Future<List<TransactionsModel>> getTransactions(
      String? query, String filter) async {
    ApiResponse data = await ApiClient.initialiseGetRequest(
      url: EndPoints.transactions,
    );
    if (filter == 'description') {
      if (data.isSuccessful) {
        return (data.data as List)
            .where((element) =>
                element['trnNarration'].contains(query?.toLowerCase()))
            .map((e) => TransactionsModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } else if (filter == 'type') {
      if (data.isSuccessful) {
        return (data.data as List)
            .where(
                (element) => element['trnDrCr'].contains(query?.toLowerCase()))
            .map((e) => TransactionsModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } else if (filter == 'amount') {
      if (data.isSuccessful) {
        return (data.data as List)
            .where(
                (element) => element['amount'].contains(query?.toLowerCase()))
            .map((e) => TransactionsModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } else if (filter == 'account number') {
      if (data.isSuccessful) {
        return (data.data as List)
            .where((element) => element['counterPartyAccountNumber']
                .contains(query?.toLowerCase()))
            .map((e) => TransactionsModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } else if (filter == 'account name') {
      if (data.isSuccessful) {
        return (data.data as List)
            .where((element) => element['counterPartyAccountName']
                .contains(query?.toLowerCase()))
            .map((e) => TransactionsModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } else if (filter == 'bank name') {
      if (data.isSuccessful) {
        return (data.data as List)
            .where((element) => element['trnCounterPartyBankName']
                .contains(query?.toLowerCase()))
            .map((e) => TransactionsModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } else {
      if (data.isSuccessful) {
        return (data.data as List)
            .map((e) => TransactionsModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    }
  }

  static Future<List<TransactionsModel>> getCredit(
      String? query, String filter) async {
    ApiResponse data = await ApiClient.initialiseGetRequest(
      url: EndPoints.transactions,
    );
    if (filter == 'description') {
      if (data.isSuccessful) {
        return (data.data as List)
            .where((element) =>
                element['trnDrCr'] == 'deposit' &&
                element['trnNarration'].contains(query?.toLowerCase() ?? ''))
            .map((e) => TransactionsModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } else if (filter == 'amount') {
      if (data.isSuccessful) {
        return (data.data as List)
            .where((element) =>
                element['trnDrCr'] == 'deposit' &&
                element['amount'].contains(query?.toLowerCase() ?? ''))
            .map((e) => TransactionsModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } else if (filter == 'account name') {
      if (data.isSuccessful) {
        return (data.data as List)
            .where((element) =>
                element['trnDrCr'] == 'deposit' &&
                element['counterPartyAccountName']
                    .contains(query?.toLowerCase() ?? ''))
            .map((e) => TransactionsModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } else if (filter == 'account number') {
      if (data.isSuccessful) {
        return (data.data as List)
            .where((element) =>
                element['trnDrCr'] == 'deposit' &&
                element['counterPartyAccountNumber']
                    .contains(query?.toLowerCase() ?? ''))
            .map((e) => TransactionsModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } else if (filter == 'bank name') {
      if (data.isSuccessful) {
        return (data.data as List)
            .where((element) =>
                element['trnDrCr'] == 'deposit' &&
                element['counterPartyBankName']
                    .contains(query?.toLowerCase() ?? ''))
            .map((e) => TransactionsModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } else {
      if (data.isSuccessful) {
        return (data.data as List)
            .where((element) => element['trnDrCr'] == 'deposit')
            .map((e) => TransactionsModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    }
  }

  static Future<List<TransactionsModel>> getDebit(
      String? query, String filter) async {
    ApiResponse data = await ApiClient.initialiseGetRequest(
      url: EndPoints.transactions,
    );

    if (filter == 'description') {
      if (data.isSuccessful) {
        return (data.data as List)
            .where((element) =>
                element['trnDrCr'] == 'withdrawal' ||
                element['trnDrCr'] == 'invoice' &&
                    element['trnNarration'].contains(query?.toLowerCase()))
            .map((e) => TransactionsModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } else if (filter == 'amount') {
      if (data.isSuccessful) {
        return (data.data as List)
            .where((element) =>
                element['trnDrCr'] == 'withdrawal' ||
                element['trnDrCr'] == 'invoice' &&
                    element['amount'].contains(query?.toLowerCase()))
            .map((e) => TransactionsModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } else if (filter == 'account name') {
      if (data.isSuccessful) {
        return (data.data as List)
            .where((element) =>
                element['trnDrCr'] == 'withdrawal' ||
                element['trnDrCr'] == 'invoice' &&
                    element['counterPartyAccountName']
                        .contains(query?.toLowerCase()))
            .map((e) => TransactionsModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } else if (filter == 'account number') {
      if (data.isSuccessful) {
        return (data.data as List)
            .where((element) =>
                element['trnDrCr'] == 'withdrawal' ||
                element['trnDrCr'] == 'invoice' &&
                    element['counterPartyAccountNumber']
                        .contains(query?.toLowerCase()))
            .map((e) => TransactionsModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } else if (filter == 'bank name') {
      if (data.isSuccessful) {
        return (data.data as List)
            .where((element) =>
                element['trnDrCr'] == 'withdrawal' ||
                element['trnDrCr'] == 'invoice' &&
                    element['counterPartyBankName']
                        .contains(query?.toLowerCase()))
            .map((e) => TransactionsModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } else {
      if (data.isSuccessful) {
        return (data.data as List)
            .where((element) =>
                element['trnDrCr'] == 'withdrawal' ||
                element['trnDrCr'] == 'invoice')
            .map((e) => TransactionsModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    }
  }
}
