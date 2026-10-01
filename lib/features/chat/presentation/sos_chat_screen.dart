import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/features/chat/data/sos_chat_api.dart';

/// Full-screen in-app chat for one SOS, used by both the helper (from the
/// response screen) and the requester. Nobody ever sees a phone number or
/// name here; messages are labelled only "You" / "Helper" / "Person in need".
class SosChatScreen extends StatefulWidget {
  const SosChatScreen({super.key, required this.sosId, required this.iAmHelper});
  final String sosId;
  final bool iAmHelper;

  @override
  State<SosChatScreen> createState() => _SosChatScreenState();
}

class _SosChatScreenState extends State<SosChatScreen> {
  final _api = getIt<SosChatApi>();
  final _controller = TextEditingController();
  final _scroll = ScrollController();
  final List<SosChatMessage> _messages = [];
  Timer? _poll;
  bool _sending = false;
  bool _closed = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _refresh();
    _poll = Timer.periodic(const Duration(seconds: 3), (_) => _refresh());
  }

  @override
  void dispose() {
    _poll?.cancel();
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  int get _cursor => _messages.isEmpty ? 0 : _messages.last.seq;

  Future<void> _refresh() async {
    if (_closed) return;
    try {
      final fresh = await _api.list(widget.sosId, after: _cursor);
      if (!mounted) return;
      if (fresh.isNotEmpty) {
        setState(() {
          final known = _messages.map((m) => m.seq).toSet();
          _messages.addAll(fresh.where((m) => !known.contains(m.seq)));
          _error = null;
        });
        _jumpToEnd();
      }
    } on SosChatException catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.message;
        _closed = e.closed;
      });
    }
  }

  void _jumpToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) _scroll.jumpTo(_scroll.position.maxScrollExtent);
    });
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _sending || _closed) return;
    setState(() => _sending = true);
    try {
      final m = await _api.send(widget.sosId, text);
      if (!mounted) return;
      _controller.clear();
      setState(() {
        if (!_messages.any((x) => x.seq == m.seq)) _messages.add(m);
        _error = null;
      });
      _jumpToEnd();
    } on SosChatException catch (e) {
      if (mounted) setState(() {
        _error = e.message;
        _closed = e.closed;
      });
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final other = widget.iAmHelper ? 'Person in need' : 'Helper';
    return Scaffold(
      appBar: AppBar(title: Text('Chat with ${widget.iAmHelper ? 'person in need' : 'your helper'}')),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.amber.shade100,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: const Text(
                'Keep it in the app: phone numbers and social handles are not needed and are flagged for safety review.',
                style: TextStyle(fontSize: 11.5, color: Colors.black87),
              ),
            ),
            Expanded(
              child: _messages.isEmpty
                  ? const Center(child: Text('No messages yet. Say hello.', style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                      controller: _scroll,
                      padding: const EdgeInsets.all(14),
                      itemCount: _messages.length,
                      itemBuilder: (_, i) {
                        final m = _messages[i];
                        return Align(
                          alignment: m.mine ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
                            decoration: BoxDecoration(
                              color: m.mine ? const Color(0xFF7C3AED) : const Color(0xFFE5E7EB),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (!m.mine)
                                  Text(other, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: Colors.black54)),
                                Text(m.body, style: TextStyle(color: m.mine ? Colors.white : Colors.black87, fontSize: 14.5)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                child: Text(_closed ? 'This emergency has ended, so the chat is closed.' : _error!,
                    style: const TextStyle(color: Colors.redAccent, fontSize: 12)),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      enabled: !_closed,
                      maxLength: 500,
                      minLines: 1,
                      maxLines: 3,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _send(),
                      decoration: const InputDecoration(counterText: '', hintText: 'Type a message', border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: (_sending || _closed) ? null : _send,
                    icon: _sending
                        ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Icon(Icons.send_rounded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
