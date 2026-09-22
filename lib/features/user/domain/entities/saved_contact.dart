class SavedContact {
  final String id;
  final String name;
  final String phone;
  final String? relation;

  const SavedContact({
    required this.id,
    required this.name,
    required this.phone,
    this.relation,
  });
}