// Define Headings for right part of the table
class RightHeadings {
  final double LTP;
  final String Chng;
  final String Ol;
  final String Ol_Chg;
  final String Volume;

  RightHeadings({
    required this.LTP,
    required this.Chng,
    required this.Ol,
    required this.Ol_Chg,
    required this.Volume,
  });

  factory RightHeadings.fromMap(Map<String, dynamic> map) {
    return RightHeadings(
      LTP: map['LTP']?.toDouble(3) ?? 0.0,
      Chng: map['Chng Chng%'] ?? '',
      Ol: map['Ol'] ?? '',
      Ol_Chg: map['Ol_Chg%'] ?? '',
      Volume: map['Volume'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'LTP': LTP,
      'Chng Chng%': Chng,
      'Ol': Ol,
      'Ol_Chg%': Ol_Chg,
      'Volume': Volume,
    };
  }
}

// Generate data for right part of the table
List<RightHeadings> rightTableData = List.generate(20, (index) {
  return RightHeadings(
    LTP: ((index + 1) * 300),
    Chng: '${index * 1}',
    Ol: '${index} K',
    Ol_Chg: '-${index}%',
    Volume: '${index * 20}L',
  );
});
