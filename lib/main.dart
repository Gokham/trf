import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const TrafficAssistantApp());
}

class TrafficAssistantApp extends StatelessWidget {
  const TrafficAssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TRF Asistan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF003A70)),
        useMaterial3: true,
      ),
      home: const AssistantPage(),
    );
  }
}

class AssistantPage extends StatefulWidget {
  const AssistantPage({super.key});

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage> {
  final TextEditingController _controller = TextEditingController();
  List<TrafficRule> _rules = [];
  String _answer = 'Soru yazın veya mikrofona basın.';
  bool _listening = false;

  @override
  void initState() {
    super.initState();
    _loadRules();
  }

  Future<void> _loadRules() async {
    final raw = await rootBundle.loadString('assets/data/traffic_rules.json');
    final data = jsonDecode(raw) as Map<String, dynamic>;
    final rules = (data['laws'] as List<dynamic>)
        .map((e) => TrafficRule.fromJson(e as Map<String, dynamic>))
        .toList();
    setState(() {
      _rules = rules;
    });
  }

  void _onSearch() {
    final query = _controller.text.trim().toLowerCase();
    if (query.isEmpty) {
      setState(() => _answer = 'Lütfen bir ihlal veya madde numarası girin.');
      return;
    }

    final match = _rules.where((r) {
      return r.code.toLowerCase().contains(query) ||
          r.title.toLowerCase().contains(query) ||
          r.details.toLowerCase().contains(query);
    }).toList();

    if (match.isEmpty) {
      setState(() {
        _answer =
            'Eşleşme bulunamadı. Örnek sorgu: "47/1-b", "kırmızı ışık", "plakasız".';
      });
      return;
    }

    final rule = match.first;
    final tutanak = _generateTutanak(rule);
    setState(() {
      _answer =
          'Madde ${rule.code} - ${rule.title}\nCeza: ${rule.fine} (İndirimli: ${rule.discountedFine})\nCeza Puanı: ${rule.points}\n\nAçıklama: ${rule.details}\n\nÖrnek Resmi Tutanak Metni:\n$tutanak';
    });
  }

  String _generateTutanak(TrafficRule rule) {
    return '".../.../20.. tarihinde yapılan trafik denetiminde, sürücünün ${rule.title.toLowerCase()} '
        'fiilini işlediği tespit edilmiştir. 2918 sayılı Karayolları Trafik Kanunu ${rule.code} '
        'maddesi kapsamında trafik idari para cezası karar tutanağı düzenlenmiştir. '
        'İlgiliye yasal hakları tebliğ edilmiştir."';
  }

  void _mockVoiceSearch() {
    setState(() {
      _listening = !_listening;
      if (_listening) {
        _controller.text = 'kırmızı ışık';
        _answer = 'Sesli arama simülasyonu: "kırmızı ışık" algılandı.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TRF Asistan'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Spacer(),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Madde no veya ihlal ara (örn. 47/1-b)',
                  filled: true,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: _mockVoiceSearch,
                    icon: Icon(
                      _listening ? Icons.mic : Icons.mic_none,
                      color: _listening ? Colors.red : null,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onSubmitted: (_) => _onSearch(),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: _onSearch,
                icon: const Icon(Icons.auto_awesome),
                label: const Text('Yapay Zeka Yanıtı Üret'),
              ),
              const Spacer(),
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      _answer,
                      style: const TextStyle(height: 1.45),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrafficRule {
  const TrafficRule({
    required this.code,
    required this.title,
    required this.fine,
    required this.discountedFine,
    required this.points,
    required this.details,
  });

  final String code;
  final String title;
  final String fine;
  final String discountedFine;
  final int points;
  final String details;

  factory TrafficRule.fromJson(Map<String, dynamic> json) {
    return TrafficRule(
      code: json['code'] as String,
      title: json['title'] as String,
      fine: json['fine'] as String,
      discountedFine: json['discountedFine'] as String,
      points: json['points'] as int,
      details: json['details'] as String,
    );
  }
}
