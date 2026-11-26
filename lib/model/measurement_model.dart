class Measurement {
  final int? id;
  final String? customerName;
  final String? customerCode;
  final String? sno;
  final String? jbNo;
  final String? measurementName;
  final String? otherworksJbno;
  final DateTime? deliveryDate;
  final String? remarks;
  final String? generalRemarks;
  final String? image;
  final double? blouseWaist;
  final double? frontLength;
  final double? backLength;
  final double? sleeveLength;
  final double? sleeveLoose;
  final double? chest;
  final double? upperChest;
  final double? hip;
  final double? frontNeck;
  final double? backNeck;
  final double? armHole;
  final double? innerSize;
  final String? innerModel;
  final double? shoulderToApex;
  final double? dotToDot;
  final double? sareeWaist;
  final double? seat;
  final double? waistFloorFront;
  final double? waistFloorBack;
  final double? shoulderToWaist;
  final double? pleatsLength;
  final double? pleatsBreadth;
  final double? waist2;
  final double? seat2;
  final double? waistFloor2;
  final double? thigh;
  final String? designImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? date;
  final String? status;
  final String? type;
  final DateTime? unitDeliveryDate;
  final double? lowerHip;

  Measurement({
    this.id,
    this.customerName,
    this.customerCode,
    this.sno,
    this.jbNo,
    this.measurementName,
    this.otherworksJbno,
    this.deliveryDate,
    this.remarks,
    this.generalRemarks,
    this.image,
    this.blouseWaist,
    this.frontLength,
    this.backLength,
    this.sleeveLength,
    this.sleeveLoose,
    this.chest,
    this.upperChest,
    this.hip,
    this.frontNeck,
    this.backNeck,
    this.armHole,
    this.innerSize,
    this.innerModel,
    this.shoulderToApex,
    this.dotToDot,
    this.sareeWaist,
    this.seat,
    this.waistFloorFront,
    this.waistFloorBack,
    this.shoulderToWaist,
    this.pleatsLength,
    this.pleatsBreadth,
    this.waist2,
    this.seat2,
    this.waistFloor2,
    this.thigh,
    this.designImage,
    this.createdAt,
    this.updatedAt,
    this.date,
    this.status,
    this.type,
    this.unitDeliveryDate,
    this.lowerHip,
  });

  factory Measurement.fromJson(Map<String, dynamic> json) {
    return Measurement(
      id: int.parse(json['id'].toString()),
      customerName: json['customer_name'] ?? '',
      customerCode: json['customer_code'] ?? '',
      sno: json['sno'] ?? '',
      jbNo: json['jb_no'] ?? '',
      measurementName: json['measurement_name'] ?? '',
      otherworksJbno: json['otherworks_jbno'],
      deliveryDate: json['delivery_date'] != null
          ? DateTime.tryParse(json['delivery_date'])
          : null,
      remarks: json['remarks'] ?? null,
      generalRemarks: json['general_remarks'] ?? null,
      image: json['image'],
      blouseWaist: (json['blouse_waist'] != null)
          ? double.tryParse(json['blouse_waist'].toString())
          : null,
      frontLength: (json['front_length'] != null)
          ? double.tryParse(json['front_length'].toString())
          : null,
      backLength: (json['back_length'] != null)
          ? double.tryParse(json['back_length'].toString())
          : null,
      sleeveLength: (json['sleeve_length'] != null)
          ? double.tryParse(json['sleeve_length'].toString())
          : null,
      sleeveLoose: (json['sleeve_loose'] != null)
          ? double.tryParse(json['sleeve_loose'].toString())
          : null,
      chest: (json['chest'] != null)
          ? double.tryParse(json['chest'].toString())
          : null,
      upperChest: double.parse(json['upper_chest'].toString()),
      hip: (json['hip'] != null)
          ? double.tryParse(json['hip'].toString())
          : null,
      frontNeck: (json['front_neck'] != null)
          ? double.tryParse(json['front_neck'].toString())
          : null,
      backNeck: (json['back_neck'] != null)
          ? double.tryParse(json['back_neck'].toString())
          : null,
      armHole: (json['arm_hole'] != null)
          ? double.tryParse(json['arm_hole'].toString())
          : null,
      innerSize: (json['inner_size'] != null)
          ? double.tryParse(json['inner_size'].toString())
          : null,
      innerModel: json['inner_model'],
      shoulderToApex: (json['shoulder_to_apex'] != null)
          ? double.tryParse(json['shoulder_to_apex'].toString())
          : null,
      dotToDot: (json['dot_to_dot'] != null)
          ? double.tryParse(json['dot_to_dot'].toString())
          : null,
      sareeWaist: (json['saree_waist'] != null)
          ? double.tryParse(json['saree_waist'].toString())
          : null,
      seat: (json['seat'] != null)
          ? double.tryParse(json['seat'].toString())
          : null,
      waistFloorFront: (json['waist_floor_front'] != null)
          ? double.tryParse(json['waist_floor_front'].toString())
          : null,
      waistFloorBack: (json['waist_floor_back'] != null)
          ? double.tryParse(json['waist_floor_back'].toString())
          : null,
      shoulderToWaist: (json['shoulder_to_waist'] != null)
          ? double.tryParse(json['shoulder_to_waist'].toString())
          : null,
      pleatsLength: (json['pleats_length'] != null)
          ? double.tryParse(json['pleats_length'].toString())
          : null,
      pleatsBreadth: (json['pleats_breadth'] != null)
          ? double.tryParse(json['pleats_breadth'].toString())
          : null,
      waist2: (json['waist2'] != null)
          ? double.tryParse(json['waist2'].toString())
          : null,
      seat2: (json['seat2'] != null)
          ? double.tryParse(json['seat2'].toString())
          : null,
      waistFloor2: (json['waist_floor2'] != null)
          ? double.tryParse(json['waist_floor2'].toString())
          : null,
      thigh: (json['thigh'] != null)
          ? double.tryParse(json['thigh'].toString())
          : null,
      designImage: json['design_image'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      date: DateTime.parse(json['date']),
      status: json['status'].toString(),
      type: json['item'] ?? '',
      unitDeliveryDate: json['unit_delivery_date'] != null
          ? DateTime.tryParse(json['unit_delivery_date'])
          : null,
      lowerHip: (json['lower_hip'] != null)
          ? double.tryParse(json['lower_hip'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_name': customerName,
      'customer_code': customerCode,
      'sno': sno,
      'jb_no': jbNo,
      'measurement_name': measurementName,
      'otherworks_jbno': otherworksJbno,
      'delivery_date': deliveryDate?.toIso8601String(),
      'remarks': remarks,
      'general_remarks': generalRemarks,
      'image': image,
      'blouse_waist': blouseWaist,
      'front_length': frontLength,
      'back_length': backLength,
      'sleeve_length': sleeveLength,
      'sleeve_loose': sleeveLoose,
      'chest': chest,
      'upper_chest': upperChest,
      'hip': hip,
      'front_neck': frontNeck,
      'back_neck': backNeck,
      'arm_hole': armHole,
      'inner_size': innerSize,
      'inner_model': innerModel,
      'shoulder_to_apex': shoulderToApex,
      'dot_to_dot': dotToDot,
      'saree_waist': sareeWaist,
      'seat': seat,
      'waist_floor_front': waistFloorFront,
      'waist_floor_back': waistFloorBack,
      'shoulder_to_waist': shoulderToWaist,
      'pleats_length': pleatsLength,
      'pleats_breadth': pleatsBreadth,
      'waist2': waist2,
      'seat2': seat2,
      'waist_floor2': waistFloor2,
      'thigh': thigh,
      'design_image': designImage,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'date': date!.toIso8601String(),
      'status': status,
      'type': type,
      'unit_delivery_date': unitDeliveryDate?.toIso8601String(),
      'lower_hip': lowerHip,
    };
  }
}
