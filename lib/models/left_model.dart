// Define Headings for left part of the table
class LeftHeadings {
  final String Volume;
  final String Ol_Chg;
  final String Ol;
  final String Chng;
  final double LTP;

  LeftHeadings({
    required this.Volume,
    required this.Ol_Chg,
    required this.Ol,
    required this.Chng,
    required this.LTP,
  });

  factory LeftHeadings.fromMap(Map<String, dynamic> map) {
    return LeftHeadings(
      Volume: map['Volume'] ?? '',
      Ol_Chg: map['Ol_Chg%'] ?? '',
      Ol: map['Ol']?.toStringAsFixed(2) ?? '',
      Chng: map['Chng Chng%'] ?? '',
      LTP: map['LTP']?.toDouble(3) ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Volume': Volume,
      'Ol_Chg%': Ol_Chg,
      'Ol': Ol,
      'Chng Chng%': Chng,
      'LTP': LTP,
    };
  }
}

// Generate data for left part of the table
List<LeftHeadings> leftTableData = List.generate(20, (index) {
  return LeftHeadings(
    Volume: '${index * 20}L',
    Ol_Chg: '-${index}%',
    Ol: '${index} K',
    Chng: '${index * 2}',
    LTP: (index * 0.2),
  );
});
