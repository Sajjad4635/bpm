class UserDetail {
  String user_token;
  String user_crypttoken;
  String user_id;
  String user_mobile;
  String user_active;
  String user_name;
  String user_level;
  String user_placeId;
  String user_loginFailedCount;
  var user_loginFailedTime;
  String user_password;
  String user_timeCreated;
  var user_gender;
  var user_userIdCreated;
  String user_timeUpdated;
  String user_userIdUpdated;
  var user_dollar;
  var user_yuan;
  var user_euro;
  var user_pound;
  var user_rial;
  var user_urial;
  var user_uaedirham;
  var user_negativeWallet;
  var user_chatExpertId;
  var user_registerType;

  UserDetail(
      {
        this.user_token,
        this.user_crypttoken,
        this.user_id,
        this.user_mobile,
        this.user_active,
        this.user_name,
        this.user_level,
        this.user_placeId,
        this.user_loginFailedCount,
        this.user_loginFailedTime,
        this.user_password,
        this.user_timeCreated,
        this.user_gender,
        this.user_userIdCreated,
        this.user_timeUpdated,
        this.user_userIdUpdated,
        this.user_dollar,
        this.user_yuan,
        this.user_euro,
        this.user_pound,
        this.user_rial,
        this.user_urial,
        this.user_uaedirham,
        this.user_negativeWallet,
        this.user_chatExpertId,
        this.user_registerType,
      });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
        user_token : json['token'],
        user_crypttoken : json['crypttoken'],
        user_id : json['id'],
        user_mobile : json['mobile'],
        user_active : json['active'],
        user_name : json['name'],
        user_level : json['level'],
        user_placeId : json['place_id'],
        user_loginFailedCount : json['login_failed_count'],
        user_loginFailedTime : json['login_failed_time'],
        user_password : json['password'],
        user_timeCreated : json['time_created'],
        user_gender : json['gender'],
        user_userIdCreated : json['user_id_created'],
        user_timeUpdated : json['time_updated'],
        user_userIdUpdated : json['user_id_updated'],
        user_dollar : json['dollar'],
        user_yuan : json['yuan'],
        user_euro : json['euro'],
        user_pound : json['pound'],
        user_rial : json['rial'],
        user_urial : json['urial'],
        user_uaedirham : json['uaedirham'],
        user_negativeWallet : json['negative_wallet'],
        user_chatExpertId : json['chat_expert_id'],
        user_registerType : json['register_type'],
    );
  }
}

class PersonDetail {
  String person_id;
  String person_firstname;
  String person_lastname;
  String person_firstnameEn;
  String person_lastnameEn;
  String person_nameEn;
  String person_name;
  String person_gender;
  String person_email;
  String person_language;
  String person_codemelli;
  String person_mobile1;
  String person_mobile2;
  var mobperson_ile2;
  String person_phone1;
  String person_phone2;
  String person_internalNumber;
  String person_postalcode;
  String person_address;
  String person_timeCreated;
  String person_userIdCreated;
  String person_userIdConnect;
  String person_expertUserId;
  String person_resetExpertUserId;
  var resperson_etExpertUserId;
  String person_marketerId;
  String person_preMarketerId;
  String person_expertMarketerId;
  String person_recoveryMarketerId;
  String person_howFindUs;
  String person_text;
  String person_lastDeterminationMarketer;
  String person_changetimeMarketerId;
  var person_expperson_ertMarketerId;
  var person_recperson_overyMarketerId;
  String person_person_howFindUs;
  String person_person_text;
  String person_person_lastDeterminationMarketer;
  String person_person_changetimeMarketerId;
  var person_changetimeRecoveryMarketerId;
  String person_changetimePreMarketerId;
  var person_endCooperation;
  var person_notify;
  String person_reportAccess;
  var person_attachment;
  var person_arianid;
  var person_arianidVerified;
  var person_arianidUserVerified;
  var person_arianidTimeVerified;
  var person_arianidUserUnverified;
  var person_arianidTimeUnverified;
  String person_dailyRecoveryTime;
  var person_appConfigs;
  var person_endCooperationTotal;
  var person_notifyMobile;

  PersonDetail(
      {
        this.person_id,
        this.person_firstname,
        this.person_lastname,
        this.person_firstnameEn,
        this.person_lastnameEn,
        this.person_nameEn,
        this.person_name,
        this.person_gender,
        this.person_email,
        this.person_language,
        this.person_codemelli,
        this.person_mobile1,
        this.person_mobile2,
        this.person_phone1,
        this.person_phone2,
        this.person_internalNumber,
        this.person_postalcode,
        this.person_address,
        this.person_timeCreated,
        this.person_userIdCreated,
        this.person_userIdConnect,
        this.person_expertUserId,
        this.person_resetExpertUserId,
        this.person_marketerId,
        this.person_preMarketerId,
        this.person_expertMarketerId,
        this.person_recoveryMarketerId,
        this.person_howFindUs,
        this.person_text,
        this.person_lastDeterminationMarketer,
        this.person_changetimeMarketerId,
        this.person_changetimeRecoveryMarketerId,
        this.person_changetimePreMarketerId,
        this.person_endCooperation,
        this.person_notify,
        this.person_reportAccess,
        this.person_attachment,
        this.person_arianid,
        this.person_arianidVerified,
        this.person_arianidUserVerified,
        this.person_arianidTimeVerified,
        this.person_arianidUserUnverified,
        this.person_arianidTimeUnverified,
        this.person_dailyRecoveryTime,
        this.person_appConfigs,
        this.person_endCooperationTotal,
        this.person_notifyMobile
      });

  factory PersonDetail.fromJson(Map<String, dynamic> json) {
    return PersonDetail(
      person_id : json['person']['id'],
      person_firstname : json['person']['firstname'],
      person_lastname : json['person']['lastname'],
      person_firstnameEn : json['person']['firstname_en'],
      person_lastnameEn : json['person']['lastname_en'],
      person_nameEn : json['person']['name_en'],
      person_name : json['person']['name'],
      person_gender : json['person']['gender'],
      person_email : json['person']['email'],
      person_language : json['person']['language'],
      person_codemelli : json['person']['codemelli'],
      person_mobile1 : json['person']['mobile1'],
      person_mobile2 : json['person']['mobile2'],
      person_phone1 : json['person']['phone1'],
      person_phone2 : json['person']['phone2'],
      person_internalNumber : json['person']['internal_number'],
      person_postalcode : json['person']['postalcode'],
      person_address : json['person']['address'],
      person_timeCreated : json['person']['time_created'],
      person_userIdCreated : json['person']['user_id_created'],
      person_userIdConnect : json['person']['user_id_connect'],
      person_expertUserId : json['person']['expert_user_id'],
      person_resetExpertUserId : json['person']['reset_expert_user_id'],
      person_marketerId : json['person']['marketer_id'],
      person_preMarketerId : json['person']['pre_marketer_id'],
      person_expertMarketerId : json['person']['expert_marketer_id'],
      person_recoveryMarketerId : json['person']['recovery_marketer_id'],
      person_howFindUs : json['person']['how_find_us'],
      person_text : json['person']['text'],
      person_lastDeterminationMarketer : json['person']['last_determination_marketer'],
      person_changetimeMarketerId : json['person']['changetime_marketer_id'],
      person_changetimeRecoveryMarketerId : json['person']['changetime_recovery_marketer_id'],
      person_changetimePreMarketerId : json['person']['changetime_pre_marketer_id'],
      person_endCooperation : json['person']['end_cooperation'],
      person_notify : json['person']['notify'],
      person_reportAccess : json['person']['report_access'],
      person_attachment : json['person']['attachment'],
      person_arianid : json['person']['arianid'],
      person_arianidVerified : json['person']['arianid_verified'],
      person_arianidUserVerified : json['person']['arianid_user_verified'],
      person_arianidTimeVerified : json['person']['arianid_time_verified'],
      person_arianidUserUnverified : json['person']['arianid_user_unverified'],
      person_arianidTimeUnverified : json['person']['arianid_time_unverified'],
      person_dailyRecoveryTime : json['person']['daily_recovery_time'],
      person_appConfigs : json['person']['app_configs'],
      person_endCooperationTotal : json['person']['end_cooperation_total'],
      person_notifyMobile : json['person']['notify_mobile'],
    );
  }
}