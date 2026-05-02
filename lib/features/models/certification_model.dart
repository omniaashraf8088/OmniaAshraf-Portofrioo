class CertificateModel {
  final int id;
  final String title;
  final String titleAr;
  final String issuer;
  final String issuerAr;
  final DateTime date;
  final String? credentialUrl;

  CertificateModel({
    required this.id,
    required this.title,
    required this.titleAr,
    required this.issuer,
    required this.issuerAr,
    required this.date,
    this.credentialUrl,
  });
}
