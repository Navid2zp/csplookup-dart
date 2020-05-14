import 'package:csplookup/src/exceptions.dart';

class LookupResponse {
  String status;
  String message;
  String errorCode;
  LookupResult result;
  String ip;

  LookupResponse(
      {this.status, this.message, this.errorCode, this.result, this.ip});

  LookupResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    errorCode = json['ErrorCode'];
    result = json['Result'] != null
        ? new LookupResult.fromJson(json['Result'])
        : null;
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    data['ErrorCode'] = this.errorCode;
    if (this.result != null) {
      data['Result'] = this.result.toJson();
    }
    data['ip'] = this.ip;
    return data;
  }

  void checkAPIError() {
    if (this.errorCode == "") {
      return;
    }

    switch (this.errorCode) {
      case "NO_API_KEY":
        throw NoAPIKeyException;
      case "SERVER_ERROR":
        throw ServerErrorException;
      case "ExpiredKey":
        throw ExpiredKeyException;
      case "DAILY_LIMIT_REACHED":
        throw DailyLimitReachedException;
      case "MONTHLY_LIMIT_REACHED":
        throw MonthlyLimitReachedException;
      case "MAX_LIMIT_REACHED":
        throw MaxLimitReachedException;
      case "NO_IP_PROVIDED":
        throw NoIpProvidedException;
		break;
      case "INVALID_IP":
        throw InvalidIpException;
      case "INVALID_KEY":
        throw InvalidKeyException;
      case "DEACTIVATED_KEY":
        throw InactiveKeyException;
      default:
        throw UnknownErrorException;
    }
  }

  LookupResult getResult() {
    return this.result;
  }

  String getCountryCode() {
    return this.result.country.isoCode;
  }

  String getCountryName() {
    if (this.result.country.names != null) {
      return this.result.country.names["en"];
    }
    return null;
  }

  String getCityName() {
    if (this.result.city.names != null) {
      return this.result.city.names["en"];
    }
    return null;
  }
}

class LookupResult {
  City city;
  Continent continent;
  Country country;
  Location location;
  Postal postal;
  Country registeredCountry;
  RepresentedCountry representedCountry;
  List<Subdivision> subdivisions;
  Traits traits;

  LookupResult(
      {this.city,
      this.continent,
      this.country,
      this.location,
      this.postal,
      this.registeredCountry,
      this.representedCountry,
      this.subdivisions,
      this.traits});

  LookupResult.fromJson(Map<String, dynamic> json) {
    city = json['City'] != null ? new City.fromJson(json['City']) : null;
    continent = json['Continent'] != null
        ? new Continent.fromJson(json['Continent'])
        : null;
    country =
        json['Country'] != null ? new Country.fromJson(json['Country']) : null;
    location = json['Location'] != null
        ? new Location.fromJson(json['Location'])
        : null;
    postal =
        json['Postal'] != null ? new Postal.fromJson(json['Postal']) : null;
    registeredCountry = json['RegisteredCountry'] != null
        ? new Country.fromJson(json['RegisteredCountry'])
        : null;
    representedCountry = json['RepresentedCountry'] != null
        ? new RepresentedCountry.fromJson(json['RepresentedCountry'])
        : null;

    subdivisions = json['Subdivisions'] != null ? json['Subdivisions']
        .map((subdivision) => Subdivision.fromJson(subdivision))
        .toList() : null;
    traits =
        json['Traits'] != null ? new Traits.fromJson(json['Traits']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.city != null) {
      data['City'] = this.city.toJson();
    }
    if (this.continent != null) {
      data['Continent'] = this.continent.toJson();
    }
    if (this.country != null) {
      data['Country'] = this.country.toJson();
    }
    if (this.location != null) {
      data['Location'] = this.location.toJson();
    }
    if (this.postal != null) {
      data['Postal'] = this.postal.toJson();
    }
    if (this.registeredCountry != null) {
      data['RegisteredCountry'] = this.registeredCountry.toJson();
    }
    if (this.representedCountry != null) {
      data['RepresentedCountry'] = this.representedCountry.toJson();
    }
    if (data['Subdivisions'] != null) {
		data['Subdivisions'] = this.subdivisions.map((subdivisions) => subdivisions.toJson()).toList();
	}
    if (this.traits != null) {
      data['Traits'] = this.traits.toJson();
    }
    return data;
  }
}

class City {
  int geoNameID;
  Map<String, String> names;

  City({this.geoNameID, this.names});

  City.fromJson(Map<String, dynamic> json) {
    geoNameID = json['GeoNameID'];
    names = json['Names'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GeoNameID'] = this.geoNameID;
    data['Names'] = this.names;
    return data;
  }
}

class Continent {
  String code;
  int geoNameID;
  Map<String, String> names;

  Continent({this.code, this.geoNameID, this.names});

  Continent.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    geoNameID = json['GeoNameID'];
    names = json['Names'] != null ? Map<String,String>.from(json['Names']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Code'] = this.code;
    data['GeoNameID'] = this.geoNameID;
    data["Names"] = this.names;
    return data;
  }
}

class Country {
  int geoNameID;
  bool isInEuropeanUnion;
  String isoCode;
  Map<String, String> names;

  Country({this.geoNameID, this.isInEuropeanUnion, this.isoCode, this.names});

  Country.fromJson(Map<String, dynamic> json) {
    geoNameID = json['GeoNameID'];
    isInEuropeanUnion = json['IsInEuropeanUnion'];
    isoCode = json['IsoCode'];
    names = json['Names'] != null ? Map<String,String>.from(json['Names']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GeoNameID'] = this.geoNameID;
    data['IsInEuropeanUnion'] = this.isInEuropeanUnion;
    data['IsoCode'] = this.isoCode;
    data["Names"] = this.names;
    return data;
  }
}

class Location {
  int accuracyRadius;
  double latitude;
  double longitude;
  int metroCode;
  String timeZone;

  Location(
      {this.accuracyRadius,
      this.latitude,
      this.longitude,
      this.metroCode,
      this.timeZone});

  Location.fromJson(Map<String, dynamic> json) {
    accuracyRadius = json['AccuracyRadius'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    metroCode = json['MetroCode'];
    timeZone = json['TimeZone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AccuracyRadius'] = this.accuracyRadius;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['MetroCode'] = this.metroCode;
    data['TimeZone'] = this.timeZone;
    return data;
  }
}

class Postal {
  String code;

  Postal({this.code});

  Postal.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Code'] = this.code;
    return data;
  }
}

class RepresentedCountry {
  int geoNameID;
  bool isInEuropeanUnion;
  String isoCode;
  Map<String, String> names;
  String type;

  RepresentedCountry(
      {this.geoNameID,
      this.isInEuropeanUnion,
      this.isoCode,
      this.names,
      this.type});

  RepresentedCountry.fromJson(Map<String, dynamic> json) {
    geoNameID = json['GeoNameID'];
    isInEuropeanUnion = json['IsInEuropeanUnion'];
    isoCode = json['IsoCode'];
    names = json['Names'] != null ? Map<String,String>.from(json['Names']) : null;
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GeoNameID'] = this.geoNameID;
    data['IsInEuropeanUnion'] = this.isInEuropeanUnion;
    data['IsoCode'] = this.isoCode;
    data['Names'] = this.names;
    data['Type'] = this.type;
    return data;
  }
}

class Traits {
  bool isAnonymousProxy;
  bool isSatelliteProvider;

  Traits({this.isAnonymousProxy, this.isSatelliteProvider});

  Traits.fromJson(Map<String, dynamic> json) {
    isAnonymousProxy = json['IsAnonymousProxy'];
    isSatelliteProvider = json['IsSatelliteProvider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsAnonymousProxy'] = this.isAnonymousProxy;
    data['IsSatelliteProvider'] = this.isSatelliteProvider;
    return data;
  }
}

class Subdivision {
  int geoNameID;
  String isoCode;
  Map<String, String> names;

  Subdivision({this.geoNameID, this.isoCode, this.names});

  Subdivision.fromJson(Map<String, dynamic> json) {
    geoNameID = json['GeoNameID'];
    isoCode = json['IsoCode'];
    names = json['Names'] != null ? Map<String,String>.from(json['Names']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GeoNameID'] = this.geoNameID;
    data['IsoCode'] = this.isoCode;
    data['Names'] = this.names;
    return data;
  }
}
