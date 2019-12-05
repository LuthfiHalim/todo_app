
import 'package:flutter/material.dart';
import 'package:flutter_statefulwidget_loginpage_luthfi/dashboard.dart';
import 'package:flutter_test/flutter_test.dart';
Icon iconbaru = Icon(Icons.calendar_today);

class Mine extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:Dashboard());
  }
  
}

void main() {
  testWidgets('test satu dua tiga', (WidgetTester tester) async {
    await tester.pumpWidget(Mine());


    final titleFinder = find.text('List Kerjaan');

    
    expect(titleFinder, findsOneWidget);
    //expect(find.byIcon(Icons.calendar_today), findsOneWidget);
  });
}

