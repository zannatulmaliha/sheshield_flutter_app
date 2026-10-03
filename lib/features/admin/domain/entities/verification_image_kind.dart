/// Which uploaded photo of a helper verification to load.
enum VerificationImageKind {
  nidFront('front', 'NID front'),
  nidBack('back', 'NID back'),
  selfie('selfie', 'Selfie');

  const VerificationImageKind(this.pathSegment, this.label);

  final String pathSegment;
  final String label;
}
