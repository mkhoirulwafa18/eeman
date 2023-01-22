class PrayerTime {
  PrayerTime({this.code, this.status, this.data});

  PrayerTime.fromJson(Map<String, dynamic> json) {
    code = json['code'] as int?;
    status = json['status'] as String?;
    if (json['data'] != null) {
      data = <Data>[];
      // ignore: inference_failure_on_untyped_parameter, avoid_dynamic_calls
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  int? code;
  String? status;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  Data({this.timings, this.date, this.meta});

  Data.fromJson(Map<String, dynamic> json) {
    timings = json['timings'] != null
        ? Timings.fromJson(json['timings'] as Map<String, dynamic>)
        : null;
    date = json['date'] != null
        ? Date.fromJson(json['date'] as Map<String, dynamic>)
        : null;
    meta = json['meta'] != null
        ? Meta.fromJson(json['meta'] as Map<String, dynamic>)
        : null;
  }
  Timings? timings;
  Date? date;
  Meta? meta;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (timings != null) {
      data['timings'] = timings!.toJson();
    }
    if (date != null) {
      data['date'] = date!.toJson();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Timings {
  Timings({
    this.fajr,
    this.sunrise,
    this.dhuhr,
    this.asr,
    this.sunset,
    this.maghrib,
    this.isha,
    this.imsak,
    this.midnight,
    this.firstthird,
    this.lastthird,
  });

  Timings.fromJson(Map<String, dynamic> json) {
    fajr = json['Fajr'] as String?;
    sunrise = json['Sunrise'] as String?;
    dhuhr = json['Dhuhr'] as String?;
    asr = json['Asr'] as String?;
    sunset = json['Sunset'] as String?;
    maghrib = json['Maghrib'] as String?;
    isha = json['Isha'] as String?;
    imsak = json['Imsak'] as String?;
    midnight = json['Midnight'] as String?;
    firstthird = json['Firstthird'] as String?;
    lastthird = json['Lastthird'] as String?;
  }
  String? fajr;
  String? sunrise;
  String? dhuhr;
  String? asr;
  String? sunset;
  String? maghrib;
  String? isha;
  String? imsak;
  String? midnight;
  String? firstthird;
  String? lastthird;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Fajr'] = fajr;
    data['Sunrise'] = sunrise;
    data['Dhuhr'] = dhuhr;
    data['Asr'] = asr;
    data['Sunset'] = sunset;
    data['Maghrib'] = maghrib;
    data['Isha'] = isha;
    data['Imsak'] = imsak;
    data['Midnight'] = midnight;
    data['Firstthird'] = firstthird;
    data['Lastthird'] = lastthird;
    return data;
  }
}

class Date {
  Date({this.readable, this.timestamp, this.gregorian, this.hijri});

  Date.fromJson(Map<String, dynamic> json) {
    readable = json['readable'] as String?;
    timestamp = json['timestamp'] as String?;
    gregorian = json['gregorian'] != null
        ? Gregorian.fromJson(json['gregorian'] as Map<String, dynamic>)
        : null;
    hijri = json['hijri'] != null
        ? Hijri.fromJson(json['hijri'] as Map<String, dynamic>)
        : null;
  }
  String? readable;
  String? timestamp;
  Gregorian? gregorian;
  Hijri? hijri;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['readable'] = readable;
    data['timestamp'] = timestamp;
    if (gregorian != null) {
      data['gregorian'] = gregorian!.toJson();
    }
    if (hijri != null) {
      data['hijri'] = hijri!.toJson();
    }
    return data;
  }
}

class Gregorian {
  Gregorian({
    this.date,
    this.format,
    this.day,
    this.weekday,
    this.month,
    this.year,
    this.designation,
  });

  Gregorian.fromJson(Map<String, dynamic> json) {
    date = json['date'] as String?;
    format = json['format'] as String?;
    day = json['day'] as String?;
    weekday = json['weekday'] != null
        ? Weekday.fromJson(json['weekday'] as Map<String, dynamic>)
        : null;
    month = json['month'] != null
        ? Month.fromJson(json['month'] as Map<String, dynamic>)
        : null;
    year = json['year'] as String?;
    designation = json['designation'] != null
        ? Designation.fromJson(json['designation'] as Map<String, dynamic>)
        : null;
  }
  String? date;
  String? format;
  String? day;
  Weekday? weekday;
  Month? month;
  String? year;
  Designation? designation;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date'] = date;
    data['format'] = format;
    data['day'] = day;
    if (weekday != null) {
      data['weekday'] = weekday!.toJson();
    }
    if (month != null) {
      data['month'] = month!.toJson();
    }
    data['year'] = year;
    if (designation != null) {
      data['designation'] = designation!.toJson();
    }
    return data;
  }
}

class Designation {
  Designation({this.abbreviated, this.expanded});

  Designation.fromJson(Map<String, dynamic> json) {
    abbreviated = json['abbreviated'] as String?;
    expanded = json['expanded'] as String?;
  }
  String? abbreviated;
  String? expanded;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abbreviated'] = abbreviated;
    data['expanded'] = expanded;
    return data;
  }
}

class Hijri {
  Hijri({
    this.date,
    this.format,
    this.day,
    this.weekday,
    this.month,
    this.year,
    this.designation,
    this.holidays,
  });

  Hijri.fromJson(Map<String, dynamic> json) {
    date = json['date'] as String?;
    format = json['format'] as String?;
    day = json['day'] as String?;
    weekday = json['weekday'] != null
        ? Weekday.fromJson(json['weekday'] as Map<String, dynamic>)
        : null;
    month = json['month'] != null
        ? Month.fromJson(json['month'] as Map<String, dynamic>)
        : null;
    year = json['year'] as String?;
    designation = json['designation'] != null
        ? Designation.fromJson(json['designation'] as Map<String, dynamic>)
        : null;
    if (json['holidays'] != null) {
      holidays = json['holidays'] == null
          ? <dynamic>[]
          : List<dynamic>.from(
              // ignore: avoid_dynamic_calls
              json['holidays']!.map((dynamic x) => x) as Iterable<dynamic>,
            );
    }
  }
  String? date;
  String? format;
  String? day;
  Weekday? weekday;
  Month? month;
  String? year;
  Designation? designation;
  List<dynamic>? holidays;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date'] = date;
    data['format'] = format;
    data['day'] = day;
    if (weekday != null) {
      data['weekday'] = weekday!.toJson();
    }
    if (month != null) {
      data['month'] = month!.toJson();
    }
    data['year'] = year;
    if (designation != null) {
      data['designation'] = designation!.toJson();
    }
    if (holidays != null) {
      data['holidays'] = holidays == null
          ? <dynamic>[]
          : List<dynamic>.from(holidays!.map((x) => x));
    }
    return data;
  }
}

class Weekday {
  Weekday({this.en, this.ar});

  Weekday.fromJson(Map<String, dynamic> json) {
    en = json['en'] as String?;
    ar = json['ar'] as String?;
  }
  String? en;
  String? ar;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['en'] = en;
    data['ar'] = ar;
    return data;
  }
}

class Month {
  Month({this.number, this.en, this.ar});

  Month.fromJson(Map<String, dynamic> json) {
    number = json['number'] as int?;
    en = json['en'] as String?;
    ar = json['ar'] as String?;
  }
  int? number;
  String? en;
  String? ar;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['number'] = number;
    data['en'] = en;
    data['ar'] = ar;
    return data;
  }
}

class Meta {
  Meta({
    this.latitude,
    this.longitude,
    this.timezone,
    this.method,
    this.latitudeAdjustmentMethod,
    this.midnightMode,
    this.school,
    this.offset,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'] as double?;
    longitude = json['longitude'] as double?;
    timezone = json['timezone'] as String?;
    method = json['method'] != null
        ? Method.fromJson(json['method'] as Map<String, dynamic>)
        : null;
    latitudeAdjustmentMethod = json['latitudeAdjustmentMethod'] as String?;
    midnightMode = json['midnightMode'] as String?;
    school = json['school'] as String?;
    offset = json['offset'] != null
        ? Offset.fromJson(json['offset'] as Map<String, dynamic>)
        : null;
  }
  double? latitude;
  double? longitude;
  String? timezone;
  Method? method;
  String? latitudeAdjustmentMethod;
  String? midnightMode;
  String? school;
  Offset? offset;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['timezone'] = timezone;
    if (method != null) {
      data['method'] = method!.toJson();
    }
    data['latitudeAdjustmentMethod'] = latitudeAdjustmentMethod;
    data['midnightMode'] = midnightMode;
    data['school'] = school;
    if (offset != null) {
      data['offset'] = offset!.toJson();
    }
    return data;
  }
}

class Method {
  Method({this.id, this.name, this.params, this.location});

  Method.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    params = json['params'] != null
        ? Params.fromJson(json['params'] as Map<String, dynamic>)
        : null;
    location = json['location'] != null
        ? Location.fromJson(json['location'] as Map<String, dynamic>)
        : null;
  }
  int? id;
  String? name;
  Params? params;
  Location? location;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (params != null) {
      data['params'] = params!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}

class Params {
  Params({this.fajr, this.isha});

  Params.fromJson(Map<String, dynamic> json) {
    fajr = json['Fajr'] as int?;
    isha = json['Isha'] as int?;
  }
  int? fajr;
  int? isha;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Fajr'] = fajr;
    data['Isha'] = isha;
    return data;
  }
}

class Location {
  Location({this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'] as double?;
    longitude = json['longitude'] as double?;
  }
  double? latitude;
  double? longitude;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class Offset {
  Offset({
    this.imsak,
    this.fajr,
    this.sunrise,
    this.dhuhr,
    this.asr,
    this.maghrib,
    this.sunset,
    this.isha,
    this.midnight,
  });

  Offset.fromJson(Map<String, dynamic> json) {
    imsak = json['Imsak'] as int?;
    fajr = json['Fajr'] as int?;
    sunrise = json['Sunrise'] as int?;
    dhuhr = json['Dhuhr'] as int?;
    asr = json['Asr'] as int?;
    maghrib = json['Maghrib'] as int?;
    sunset = json['Sunset'] as int?;
    isha = json['Isha'] as int?;
    midnight = json['Midnight'] as int?;
  }
  int? imsak;
  int? fajr;
  int? sunrise;
  int? dhuhr;
  int? asr;
  int? maghrib;
  int? sunset;
  int? isha;
  int? midnight;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Imsak'] = imsak;
    data['Fajr'] = fajr;
    data['Sunrise'] = sunrise;
    data['Dhuhr'] = dhuhr;
    data['Asr'] = asr;
    data['Maghrib'] = maghrib;
    data['Sunset'] = sunset;
    data['Isha'] = isha;
    data['Midnight'] = midnight;
    return data;
  }
}
