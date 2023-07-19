class DonationItemPresentation {
  final String label;
  final String imgPath;

  DonationItemPresentation({
    required this.label,
    required this.imgPath,
  });

  /// Crea una instancia de [DonationItemPresentation]
  static DonationItemPresentation createOne(String label, imgPath) {
    return DonationItemPresentation(
      label: label,
      imgPath: imgPath,
    );
  }
}
