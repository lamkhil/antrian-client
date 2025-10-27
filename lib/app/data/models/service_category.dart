class ServiceCategory {
  int? id;
  String? name;
  String? description;
  String? icon;
  bool? isActive;
  int? zoneId;
  String? createdAt;
  String? updatedAt;
  String? iconUrl;
  List<Services>? services;

  ServiceCategory({
    this.id,
    this.name,
    this.description,
    this.icon,
    this.isActive,
    this.zoneId,
    this.createdAt,
    this.updatedAt,
    this.iconUrl,
    this.services,
  });

  ServiceCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    icon = json['icon'];
    isActive = json['is_active'];
    zoneId = json['zone_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iconUrl = json['icon_url'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['icon'] = icon;
    data['is_active'] = isActive;
    data['zone_id'] = zoneId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['icon_url'] = iconUrl;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int? id;
  String? code;
  String? name;
  bool? isActive;
  String? description;
  int? estimatedTimeMinutes;
  String? icon;
  int? serviceCategoryId;
  String? createdAt;
  String? updatedAt;
  String? iconUrl;

  Services({
    this.id,
    this.code,
    this.name,
    this.isActive,
    this.description,
    this.estimatedTimeMinutes,
    this.icon,
    this.serviceCategoryId,
    this.createdAt,
    this.updatedAt,
    this.iconUrl,
  });

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    isActive = json['is_active'];
    description = json['description'];
    estimatedTimeMinutes = json['estimated_time_minutes'];
    icon = json['icon'];
    serviceCategoryId = json['service_category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iconUrl = json['icon_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['is_active'] = isActive;
    data['description'] = description;
    data['estimated_time_minutes'] = estimatedTimeMinutes;
    data['icon'] = icon;
    data['service_category_id'] = serviceCategoryId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['icon_url'] = iconUrl;
    return data;
  }
}
