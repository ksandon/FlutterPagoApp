import 'dart:convert';

NiubizQueryResponse niubizQueryResponseFromJson(String str) => NiubizQueryResponse.fromJson(json.decode(str));

String niubizQueryResponseToJson(NiubizQueryResponse data) => json.encode(data.toJson());

class NiubizQueryResponse {
    NiubizQueryResponse({
        this.order,
        this.dataMap,
    });

    Order order;
    DataMap dataMap;

    factory NiubizQueryResponse.fromJson(Map<String, dynamic> json) => NiubizQueryResponse(
        order: Order.fromJson(json["order"]),
        dataMap: DataMap.fromJson(json["dataMap"]),
    );

    Map<String, dynamic> toJson() => {
        "order": order.toJson(),
        "dataMap": dataMap.toJson(),
    };
}

class DataMap {
    DataMap({
        this.terminal,
        this.traceNumber,
        this.eciDescription,
        this.merchant,
        this.card,
        this.quotaNiDiscount,
        this.status,
        this.actionDescription,
        this.idUnico,
        this.amount,
        this.quotaNumber,
        this.quotaNiAmount,
        this.quotaNiProgram,
        this.authorizationCode,
        this.currency,
        this.transactionDate,
        this.actionCode,
        this.bin,
        this.eci,
        this.brand,
        this.quotaNiType,
        this.authorizedAmount,
        this.quotaAmount,
        this.adquirente,
        this.settlement,
        this.transactionId,
        this.quotaNiMessage,
        this.quotaDeferred,
    });

    String terminal;
    String traceNumber;
    String eciDescription;
    String merchant;
    String card;
    String quotaNiDiscount;
    String status;
    String actionDescription;
    String idUnico;
    String amount;
    String quotaNumber;
    String quotaNiAmount;
    String quotaNiProgram;
    String authorizationCode;
    String currency;
    String transactionDate;
    String actionCode;
    String bin;
    String eci;
    String brand;
    String quotaNiType;
    String authorizedAmount;
    String quotaAmount;
    String adquirente;
    String settlement;
    String transactionId;
    String quotaNiMessage;
    String quotaDeferred;

    factory DataMap.fromJson(Map<String, dynamic> json) => DataMap(
        terminal: json["TERMINAL"],
        traceNumber: json["TRACE_NUMBER"],
        eciDescription: json["ECI_DESCRIPTION"],
        merchant: json["MERCHANT"],
        card: json["CARD"],
        quotaNiDiscount: json["QUOTA_NI_DISCOUNT"],
        status: json["STATUS"],
        actionDescription: json["ACTION_DESCRIPTION"],
        idUnico: json["ID_UNICO"],
        amount: json["AMOUNT"],
        quotaNumber: json["QUOTA_NUMBER"],
        quotaNiAmount: json["QUOTA_NI_AMOUNT"],
        quotaNiProgram: json["QUOTA_NI_PROGRAM"],
        authorizationCode: json["AUTHORIZATION_CODE"],
        currency: json["CURRENCY"],
        transactionDate: json["TRANSACTION_DATE"],
        actionCode: json["ACTION_CODE"],
        bin: json["BIN"],
        eci: json["ECI"],
        brand: json["BRAND"],
        quotaNiType: json["QUOTA_NI_TYPE"],
        authorizedAmount: json["AUTHORIZED_AMOUNT"],
        quotaAmount: json["QUOTA_AMOUNT"],
        adquirente: json["ADQUIRENTE"],
        settlement: json["SETTLEMENT"],
        transactionId: json["TRANSACTION_ID"],
        quotaNiMessage: json["QUOTA_NI_MESSAGE"],
        quotaDeferred: json["QUOTA_DEFERRED"],
    );

    Map<String, dynamic> toJson() => {
        "TERMINAL": terminal,
        "TRACE_NUMBER": traceNumber,
        "ECI_DESCRIPTION": eciDescription,
        "MERCHANT": merchant,
        "CARD": card,
        "QUOTA_NI_DISCOUNT": quotaNiDiscount,
        "STATUS": status,
        "ACTION_DESCRIPTION": actionDescription,
        "ID_UNICO": idUnico,
        "AMOUNT": amount,
        "QUOTA_NUMBER": quotaNumber,
        "QUOTA_NI_AMOUNT": quotaNiAmount,
        "QUOTA_NI_PROGRAM": quotaNiProgram,
        "AUTHORIZATION_CODE": authorizationCode,
        "CURRENCY": currency,
        "TRANSACTION_DATE": transactionDate,
        "ACTION_CODE": actionCode,
        "BIN": bin,
        "ECI": eci,
        "BRAND": brand,
        "QUOTA_NI_TYPE": quotaNiType,
        "AUTHORIZED_AMOUNT": authorizedAmount,
        "QUOTA_AMOUNT": quotaAmount,
        "ADQUIRENTE": adquirente,
        "SETTLEMENT": settlement,
        "TRANSACTION_ID": transactionId,
        "QUOTA_NI_MESSAGE": quotaNiMessage,
        "QUOTA_DEFERRED": quotaDeferred,
    };
}

class Order {
    Order({
        this.purchaseNumber,
        this.amount,
        this.currency,
        this.externalTransactionId,
        this.authorizedAmount,
        this.authorizationCode,
        this.actionCode,
        this.status,
        this.traceNumber,
        this.transactionDate,
        this.transactionId,
    });

    String purchaseNumber;
    double amount;
    String currency;
    String externalTransactionId;
    double authorizedAmount;
    String authorizationCode;
    String actionCode;
    String status;
    String traceNumber;
    String transactionDate;
    String transactionId;

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        purchaseNumber: json["purchaseNumber"],
        amount: json["amount"],
        currency: json["currency"],
        externalTransactionId: json["externalTransactionId"],
        authorizedAmount: json["authorizedAmount"],
        authorizationCode: json["authorizationCode"],
        actionCode: json["actionCode"],
        status: json["status"],
        traceNumber: json["traceNumber"],
        transactionDate: json["transactionDate"],
        transactionId: json["transactionId"],
    );

    Map<String, dynamic> toJson() => {
        "purchaseNumber": purchaseNumber,
        "amount": amount,
        "currency": currency,
        "externalTransactionId": externalTransactionId,
        "authorizedAmount": authorizedAmount,
        "authorizationCode": authorizationCode,
        "actionCode": actionCode,
        "status": status,
        "traceNumber": traceNumber,
        "transactionDate": transactionDate,
        "transactionId": transactionId,
    };
}
