class Spending {
  int? s_id;
  String s_name;
  String s_date;
  String s_time;
  String s_mode;
  String s_amount;
  String s_type;

  Spending({
    required this.s_amount,
    required this.s_date,
    required this.s_name,
    required this.s_mode,
    required this.s_time,
    required this.s_type,
    this.s_id,
  });

  factory Spending.FROMSQLITE({required Map data}) {
    return Spending(
      s_amount: data['s_amount'],
      s_date: data['s_date'],
      s_name: data['s_name'],
      s_mode: data['s_mode'],
      s_time: data['s_time'],
      s_type: data['s_type'],
      s_id: data['s_id'],
    );
  }
}
