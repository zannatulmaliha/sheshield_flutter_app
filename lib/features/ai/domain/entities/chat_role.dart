/// Who wrote one turn of the conversation. Wire values match the Go
/// backend's chat history shape.
enum ChatRole {
  user('user'),
  assistant('assistant');

  const ChatRole(this.wireValue);

  final String wireValue;

  static ChatRole fromWireValue(String? value) => ChatRole.values.firstWhere(
        (role) => role.wireValue == value,
        orElse: () => assistant,
      );
}
