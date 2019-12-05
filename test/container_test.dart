import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_statefulwidget_loginpage_luthfi/box_widget.dart';
Icon iconbaru = Icon(Icons.calendar_today);

class Mine extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:Box(status: 'test',jumlah: 10,icon: iconbaru,warna: Colors.black));
  }
  
}

void main() {
  testWidgets('test all widget', (WidgetTester tester) async {
    await tester.pumpWidget(Mine());

    final titleFinder = find.text('test');
    expect(titleFinder, findsOneWidget);
    expect(find.byIcon(Icons.calendar_today), findsOneWidget);
  });
}
