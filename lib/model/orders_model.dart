class Order {
  final int? id;
  final String? empName;
  final String? date;
  final String? jbNo;
  final String? customerName;
  final String? customerPhone;
  final String? deliveryDate;
  final DateTime? unitDeliveryDate;
  final String? type;
  final String? invoiceNumber;
  final String? branchId;
  final int? status;
  final DateTime? recDate;
  final String? recName;
  final String? recPhone;
  final int? recEmp;
  final DateTime? createdOn;

  Order({
    this.id,
    this.empName,
    this.date,
    this.jbNo,
    this.customerName,
    this.customerPhone,
    this.deliveryDate,
    this.unitDeliveryDate,
    this.type,
    this.invoiceNumber,
    this.branchId,
    this.status,
    this.recDate,
    this.recName,
    this.recPhone,
    this.recEmp,
    this.createdOn,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      empName: json['Emp_name'],
      date: json['date'],
      jbNo: json['jb_no'],
      customerName: json['customer_name'],
      customerPhone: json['customer_phone'],
      deliveryDate: json['delivery_date'],
      unitDeliveryDate: json['unit_delivery_date'] != null
          ? DateTime.tryParse(json['unit_delivery_date'])
          : null,
      type: json['type'],
      invoiceNumber: json['invoice_number'],
      branchId: json['branch_id'],
      status: json['status'] != null
          ? int.tryParse(json['status'].toString())
          : null,
      recDate: json['rec_date'] != null
          ? DateTime.tryParse(json['rec_date'])
          : null,
      recName: json['rec_name'],
      recPhone: json['rec_phone'],
      recEmp: json['rec_emp'] != null
          ? int.tryParse(json['rec_emp'].toString())
          : null,
      createdOn: json['created_on'] != null
          ? DateTime.tryParse(json['created_on'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Emp_name': empName,
      'date': date,
      'jb_no': jbNo,
      'customer_name': customerName,
      'customer_phone': customerPhone,
      'delivery_date': deliveryDate,
      'unit_delivery_date': unitDeliveryDate?.toIso8601String(),
      'type': type,
      'invoice_number': invoiceNumber,
      'branch_id': branchId,
      'status': status,
      'rec_date': recDate?.toIso8601String(),
      'rec_name': recName,
      'rec_phone': recPhone,
      'rec_emp': recEmp,
      'created_on': createdOn?.toIso8601String(),
    };
  }

  // ✅ Helper getters
  bool get isDelivered => recDate != null;
  bool get isCompleted => status == 1;
}
