class cardBoardPageModel {
  String tasklistId;
  String taskAlarmAfterTime;
  var taskUserIdChanged;
  var taskUpdateTime;
  String taskTimeEnter;
  var taskComment;
  String userIdOwnerTitle;
  String personIdOwner;
  String userIdCreatedTitle;
  String expertUserIdTitle;
  var taskUserIdChangedTitle;
  String orderStatusTitle;
  List<String> servicesTitle;
  String timeCreatedTitle;
  var taskUpdateTimeTitle;
  String timeUpdatedTitle;
  var orderTn;
  var inqueryTypeTitle;
  String invoicetoPTitle;
  var invoicetoCTitle;
  String priceunitTitle;
  var extraTitle;
  var batchNo;
  var fromWidTitle;
  var toWidTitle;
  var sentOutTitle;
  var bankaccountTitle;
  var paymentTypeTitle;
  var relatedserviceTitle;
  var paymentStatusTitle;
  var dateTitle;
  var clearingTypeTitle;
  var changeFieldValueTitle;
  String whTargetId;
  String orderApprovalsStatus;
  String id;
  var pathId;
  String tn;
  String userIdOwner;
  String timeCreated;
  String ip;
  String timeUpdated;
  String receiverCity;
  String receiverP;
  var receiverC;
  String senderCity;
  var senderP;
  String senderC;
  String invoicetoP;
  var invoicetoC;
  var warereceipt;
  String needClearanceInquery;
  String step;
  String transportType;
  String totalweight;
  var subbill;
  String orderStatus;
  var statusReason;
  var statusText;
  String services;
  String userIdCreated;
  String totalvweight;
  String totalcweight;
  var totalprice;
  String priceunit;
  String incoterms;
  String transportTimeType;
  var text;
  String factorrasmiBuy;
  String factorrasmiTransport;
  String factorrasmiClearance;
  String factorrasmi;
  String marketerId;
  var expertMarketerId;
  var recoveryMarketerId;
  String expertUserId;
  var latestExpertUserId;
  var internalCarriage;
  var internalCarriageFile;
  var needPart;
  var partText;
  var partCustom;
  var clearanceBaseprice;
  var clearanceBuylink;
  var clearanceInquiryHasProblem;
  String pickedup;
  var placeIdOwner;
  String allowBatching;
  var cleared;
  String approvalPickupTime;
  String orderType;
  var isChina;
  String hasmaliallowtransport;
  var deliverytime;
  var changetimeMarketerId;
  var changetimeRecoveryMarketerId;
  var clearingProblem;
  var newofinvoiceafterprintdelivery;
  var notRoundOtherinvoice;
  var lastchangestatus;
  String customsAssessmentTime;
  var unsettled;
  var isArchived;
  var archiveTime;
  var userArchiveId;
  var arianid;
  var buyInquiryHasProblem;
  var noneedClearancecost;
  var noneedTransportcost;
  var cancelTime;
  var userIdCanceled;
  String vatInvoicesTotal;
  var confirmOrderReturn;
  var tarkhisCode;
  var tarkhisCodeUpdatedAt;
  String tarkhisCodeUpdatedBy;
  var cancelAfterPickup;

  cardBoardPageModel(
      {this.tasklistId,
        this.taskAlarmAfterTime,
        this.taskUserIdChanged,
        this.taskUpdateTime,
        this.taskTimeEnter,
        this.taskComment,
        this.userIdOwnerTitle,
        this.personIdOwner,
        this.userIdCreatedTitle,
        this.expertUserIdTitle,
        this.taskUserIdChangedTitle,
        this.orderStatusTitle,
        this.servicesTitle,
        this.timeCreatedTitle,
        this.taskUpdateTimeTitle,
        this.timeUpdatedTitle,
        this.orderTn,
        this.inqueryTypeTitle,
        this.invoicetoPTitle,
        this.invoicetoCTitle,
        this.priceunitTitle,
        this.extraTitle,
        this.batchNo,
        this.fromWidTitle,
        this.toWidTitle,
        this.sentOutTitle,
        this.bankaccountTitle,
        this.paymentTypeTitle,
        this.relatedserviceTitle,
        this.paymentStatusTitle,
        this.dateTitle,
        this.clearingTypeTitle,
        this.changeFieldValueTitle,
        this.whTargetId,
        this.orderApprovalsStatus,
        this.id,
        this.pathId,
        this.tn,
        this.userIdOwner,
        this.timeCreated,
        this.ip,
        this.timeUpdated,
        this.receiverCity,
        this.receiverP,
        this.receiverC,
        this.senderCity,
        this.senderP,
        this.senderC,
        this.invoicetoP,
        this.invoicetoC,
        this.warereceipt,
        this.needClearanceInquery,
        this.step,
        this.transportType,
        this.totalweight,
        this.subbill,
        this.orderStatus,
        this.statusReason,
        this.statusText,
        this.services,
        this.userIdCreated,
        this.totalvweight,
        this.totalcweight,
        this.totalprice,
        this.priceunit,
        this.incoterms,
        this.transportTimeType,
        this.text,
        this.factorrasmiBuy,
        this.factorrasmiTransport,
        this.factorrasmiClearance,
        this.factorrasmi,
        this.marketerId,
        this.expertMarketerId,
        this.recoveryMarketerId,
        this.expertUserId,
        this.latestExpertUserId,
        this.internalCarriage,
        this.internalCarriageFile,
        this.needPart,
        this.partText,
        this.partCustom,
        this.clearanceBaseprice,
        this.clearanceBuylink,
        this.clearanceInquiryHasProblem,
        this.pickedup,
        this.placeIdOwner,
        this.allowBatching,
        this.cleared,
        this.approvalPickupTime,
        this.orderType,
        this.isChina,
        this.hasmaliallowtransport,
        this.deliverytime,
        this.changetimeMarketerId,
        this.changetimeRecoveryMarketerId,
        this.clearingProblem,
        this.newofinvoiceafterprintdelivery,
        this.notRoundOtherinvoice,
        this.lastchangestatus,
        this.customsAssessmentTime,
        this.unsettled,
        this.isArchived,
        this.archiveTime,
        this.userArchiveId,
        this.arianid,
        this.buyInquiryHasProblem,
        this.noneedClearancecost,
        this.noneedTransportcost,
        this.cancelTime,
        this.userIdCanceled,
        this.vatInvoicesTotal,
        this.confirmOrderReturn,
        this.tarkhisCode,
        this.tarkhisCodeUpdatedAt,
        this.tarkhisCodeUpdatedBy,
        this.cancelAfterPickup});

  cardBoardPageModel.fromJson(Map<String, dynamic> json) {
    tasklistId = json['tasklist_id'];
    taskAlarmAfterTime = json['task_alarm_after_time'];
    taskUserIdChanged = json['task_user_id_changed'];
    taskUpdateTime = json['task_update_time'];
    taskTimeEnter = json['task_time_enter'];
    taskComment = json['task_comment'];
    userIdOwnerTitle = json['user_id_owner_title'];
    personIdOwner = json['person_id_owner'];
    userIdCreatedTitle = json['user_id_created_title'];
    expertUserIdTitle = json['expert_user_id_title'];
    taskUserIdChangedTitle = json['task_user_id_changed_title'];
    orderStatusTitle = json['order_status_title'];
    servicesTitle = json['services_title'].cast<String>();
    timeCreatedTitle = json['time_created_title'];
    taskUpdateTimeTitle = json['task_update_time_title'];
    timeUpdatedTitle = json['time_updated_title'];
    orderTn = json['order_tn'];
    inqueryTypeTitle = json['inquery_type_title'];
    invoicetoPTitle = json['invoiceto_p_title'];
    invoicetoCTitle = json['invoiceto_c_title'];
    priceunitTitle = json['priceunit_title'];
    extraTitle = json['extra_title'];
    batchNo = json['batch_no'];
    fromWidTitle = json['from_wid_title'];
    toWidTitle = json['to_wid_title'];
    sentOutTitle = json['sent_out_title'];
    bankaccountTitle = json['bankaccount_title'];
    paymentTypeTitle = json['payment_type_title'];
    relatedserviceTitle = json['relatedservice_title'];
    paymentStatusTitle = json['payment_status_title'];
    dateTitle = json['date_title'];
    clearingTypeTitle = json['clearing_type_title'];
    changeFieldValueTitle = json['change_field_value_title'];
    whTargetId = json['wh_target_id'];
    orderApprovalsStatus = json['order_approvals_status'];
    id = json['id'];
    pathId = json['path_id'];
    tn = json['tn'];
    userIdOwner = json['user_id_owner'];
    timeCreated = json['time_created'];
    ip = json['ip'];
    timeUpdated = json['time_updated'];
    receiverCity = json['receiver_city'];
    receiverP = json['receiver_p'];
    receiverC = json['receiver_c'];
    senderCity = json['sender_city'];
    senderP = json['sender_p'];
    senderC = json['sender_c'];
    invoicetoP = json['invoiceto_p'];
    invoicetoC = json['invoiceto_c'];
    warereceipt = json['warereceipt'];
    needClearanceInquery = json['need_clearance_inquery'];
    step = json['step'];
    transportType = json['transport_type'];
    totalweight = json['totalweight'];
    subbill = json['subbill'];
    orderStatus = json['order_status'];
    statusReason = json['status_reason'];
    statusText = json['status_text'];
    services = json['services'];
    userIdCreated = json['user_id_created'];
    totalvweight = json['totalvweight'];
    totalcweight = json['totalcweight'];
    totalprice = json['totalprice'];
    priceunit = json['priceunit'];
    incoterms = json['incoterms'];
    transportTimeType = json['transport_time_type'];
    text = json['text'];
    factorrasmiBuy = json['factorrasmi_buy'];
    factorrasmiTransport = json['factorrasmi_transport'];
    factorrasmiClearance = json['factorrasmi_clearance'];
    factorrasmi = json['factorrasmi'];
    marketerId = json['marketer_id'];
    expertMarketerId = json['expert_marketer_id'];
    recoveryMarketerId = json['recovery_marketer_id'];
    expertUserId = json['expert_user_id'];
    latestExpertUserId = json['latest_expert_user_id'];
    internalCarriage = json['internal_carriage'];
    internalCarriageFile = json['internal_carriage_file'];
    needPart = json['need_part'];
    partText = json['part_text'];
    partCustom = json['part_custom'];
    clearanceBaseprice = json['clearance_baseprice'];
    clearanceBuylink = json['clearance_buylink'];
    clearanceInquiryHasProblem = json['clearance_inquiry_has_problem'];
    pickedup = json['pickedup'];
    placeIdOwner = json['place_id_owner'];
    allowBatching = json['allow_batching'];
    cleared = json['cleared'];
    approvalPickupTime = json['approval_pickup_time'];
    orderType = json['order_type'];
    isChina = json['is_china'];
    hasmaliallowtransport = json['hasmaliallowtransport'];
    deliverytime = json['deliverytime'];
    changetimeMarketerId = json['changetime_marketer_id'];
    changetimeRecoveryMarketerId = json['changetime_recovery_marketer_id'];
    clearingProblem = json['clearing_problem'];
    newofinvoiceafterprintdelivery = json['newofinvoiceafterprintdelivery'];
    notRoundOtherinvoice = json['not_round_otherinvoice'];
    lastchangestatus = json['lastchangestatus'];
    customsAssessmentTime = json['customs_assessment_time'];
    unsettled = json['unsettled'];
    isArchived = json['is_archived'];
    archiveTime = json['archive_time'];
    userArchiveId = json['user_archive_id'];
    arianid = json['arianid'];
    buyInquiryHasProblem = json['buy_inquiry_has_problem'];
    noneedClearancecost = json['noneed_clearancecost'];
    noneedTransportcost = json['noneed_transportcost'];
    cancelTime = json['cancel_time'];
    userIdCanceled = json['user_id_canceled'];
    vatInvoicesTotal = json['vat_invoices_total'];
    confirmOrderReturn = json['confirm_order_return'];
    tarkhisCode = json['tarkhis_code'];
    tarkhisCodeUpdatedAt = json['tarkhis_code_updated_at'];
    tarkhisCodeUpdatedBy = json['tarkhis_code_updated_by'];
    cancelAfterPickup = json['cancel_after_pickup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tasklist_id'] = this.tasklistId;
    data['task_alarm_after_time'] = this.taskAlarmAfterTime;
    data['task_user_id_changed'] = this.taskUserIdChanged;
    data['task_update_time'] = this.taskUpdateTime;
    data['task_time_enter'] = this.taskTimeEnter;
    data['task_comment'] = this.taskComment;
    data['user_id_owner_title'] = this.userIdOwnerTitle;
    data['person_id_owner'] = this.personIdOwner;
    data['user_id_created_title'] = this.userIdCreatedTitle;
    data['expert_user_id_title'] = this.expertUserIdTitle;
    data['task_user_id_changed_title'] = this.taskUserIdChangedTitle;
    data['order_status_title'] = this.orderStatusTitle;
    data['services_title'] = this.servicesTitle;
    data['time_created_title'] = this.timeCreatedTitle;
    data['task_update_time_title'] = this.taskUpdateTimeTitle;
    data['time_updated_title'] = this.timeUpdatedTitle;
    data['order_tn'] = this.orderTn;
    data['inquery_type_title'] = this.inqueryTypeTitle;
    data['invoiceto_p_title'] = this.invoicetoPTitle;
    data['invoiceto_c_title'] = this.invoicetoCTitle;
    data['priceunit_title'] = this.priceunitTitle;
    data['extra_title'] = this.extraTitle;
    data['batch_no'] = this.batchNo;
    data['from_wid_title'] = this.fromWidTitle;
    data['to_wid_title'] = this.toWidTitle;
    data['sent_out_title'] = this.sentOutTitle;
    data['bankaccount_title'] = this.bankaccountTitle;
    data['payment_type_title'] = this.paymentTypeTitle;
    data['relatedservice_title'] = this.relatedserviceTitle;
    data['payment_status_title'] = this.paymentStatusTitle;
    data['date_title'] = this.dateTitle;
    data['clearing_type_title'] = this.clearingTypeTitle;
    data['change_field_value_title'] = this.changeFieldValueTitle;
    data['wh_target_id'] = this.whTargetId;
    data['order_approvals_status'] = this.orderApprovalsStatus;
    data['id'] = this.id;
    data['path_id'] = this.pathId;
    data['tn'] = this.tn;
    data['user_id_owner'] = this.userIdOwner;
    data['time_created'] = this.timeCreated;
    data['ip'] = this.ip;
    data['time_updated'] = this.timeUpdated;
    data['receiver_city'] = this.receiverCity;
    data['receiver_p'] = this.receiverP;
    data['receiver_c'] = this.receiverC;
    data['sender_city'] = this.senderCity;
    data['sender_p'] = this.senderP;
    data['sender_c'] = this.senderC;
    data['invoiceto_p'] = this.invoicetoP;
    data['invoiceto_c'] = this.invoicetoC;
    data['warereceipt'] = this.warereceipt;
    data['need_clearance_inquery'] = this.needClearanceInquery;
    data['step'] = this.step;
    data['transport_type'] = this.transportType;
    data['totalweight'] = this.totalweight;
    data['subbill'] = this.subbill;
    data['order_status'] = this.orderStatus;
    data['status_reason'] = this.statusReason;
    data['status_text'] = this.statusText;
    data['services'] = this.services;
    data['user_id_created'] = this.userIdCreated;
    data['totalvweight'] = this.totalvweight;
    data['totalcweight'] = this.totalcweight;
    data['totalprice'] = this.totalprice;
    data['priceunit'] = this.priceunit;
    data['incoterms'] = this.incoterms;
    data['transport_time_type'] = this.transportTimeType;
    data['text'] = this.text;
    data['factorrasmi_buy'] = this.factorrasmiBuy;
    data['factorrasmi_transport'] = this.factorrasmiTransport;
    data['factorrasmi_clearance'] = this.factorrasmiClearance;
    data['factorrasmi'] = this.factorrasmi;
    data['marketer_id'] = this.marketerId;
    data['expert_marketer_id'] = this.expertMarketerId;
    data['recovery_marketer_id'] = this.recoveryMarketerId;
    data['expert_user_id'] = this.expertUserId;
    data['latest_expert_user_id'] = this.latestExpertUserId;
    data['internal_carriage'] = this.internalCarriage;
    data['internal_carriage_file'] = this.internalCarriageFile;
    data['need_part'] = this.needPart;
    data['part_text'] = this.partText;
    data['part_custom'] = this.partCustom;
    data['clearance_baseprice'] = this.clearanceBaseprice;
    data['clearance_buylink'] = this.clearanceBuylink;
    data['clearance_inquiry_has_problem'] = this.clearanceInquiryHasProblem;
    data['pickedup'] = this.pickedup;
    data['place_id_owner'] = this.placeIdOwner;
    data['allow_batching'] = this.allowBatching;
    data['cleared'] = this.cleared;
    data['approval_pickup_time'] = this.approvalPickupTime;
    data['order_type'] = this.orderType;
    data['is_china'] = this.isChina;
    data['hasmaliallowtransport'] = this.hasmaliallowtransport;
    data['deliverytime'] = this.deliverytime;
    data['changetime_marketer_id'] = this.changetimeMarketerId;
    data['changetime_recovery_marketer_id'] = this.changetimeRecoveryMarketerId;
    data['clearing_problem'] = this.clearingProblem;
    data['newofinvoiceafterprintdelivery'] =
        this.newofinvoiceafterprintdelivery;
    data['not_round_otherinvoice'] = this.notRoundOtherinvoice;
    data['lastchangestatus'] = this.lastchangestatus;
    data['customs_assessment_time'] = this.customsAssessmentTime;
    data['unsettled'] = this.unsettled;
    data['is_archived'] = this.isArchived;
    data['archive_time'] = this.archiveTime;
    data['user_archive_id'] = this.userArchiveId;
    data['arianid'] = this.arianid;
    data['buy_inquiry_has_problem'] = this.buyInquiryHasProblem;
    data['noneed_clearancecost'] = this.noneedClearancecost;
    data['noneed_transportcost'] = this.noneedTransportcost;
    data['cancel_time'] = this.cancelTime;
    data['user_id_canceled'] = this.userIdCanceled;
    data['vat_invoices_total'] = this.vatInvoicesTotal;
    data['confirm_order_return'] = this.confirmOrderReturn;
    data['tarkhis_code'] = this.tarkhisCode;
    data['tarkhis_code_updated_at'] = this.tarkhisCodeUpdatedAt;
    data['tarkhis_code_updated_by'] = this.tarkhisCodeUpdatedBy;
    data['cancel_after_pickup'] = this.cancelAfterPickup;
    return data;
  }
}