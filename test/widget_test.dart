import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_flutter/data/portfolio_data.dart';

void main() {
  test('Portfolio data sanity test', () {
    expect(PortfolioData.name, isNotEmpty);
    expect(PortfolioData.projects, isNotEmpty);
    expect(PortfolioData.skills, isNotEmpty);
  });
}
