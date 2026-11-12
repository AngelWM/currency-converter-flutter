import 'package:flutter/material.dart';

void main() {
  runApp(const CurrencyConverterApp());
}

// The app starts with a MaterialApp
class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4338CA),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
        useMaterial3: true,
      ),
      home: const CurrencyConverterPage(),
    );
  }
}

// Stateful widget for one small interactive screen.
class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  // Illustrative FIXED rates: number of currency units for 1 US dollar.
  // These are example figures
  // Using one base currency to calculate every pair consistently
  static const Map<String, double> _unitsPerUsd = {
    'USD': 1.00,
    'GBP': 0.79,
    'EUR': 0.92,
    'JPY': 150.00,
    'NGN': 1450.00,
  };

  static const List<String> _currencyCodes = [
    'USD',
    'GBP',
    'EUR',
    'JPY',
    'NGN',
  ];

  // The values that can change while the user interacts.
  String _amountText = '';
  String _fromCurrency = 'USD';
  String _toCurrency = 'GBP';

  // Example: USD -> GBP = 0.79 / 1.00 = 0.79.
  double _exchangeRate() {
    return _unitsPerUsd[_toCurrency]! / _unitsPerUsd[_fromCurrency]!;
  }

  // Chose to keep the calculation separate from the widget layout for easy testing.
  double _convertAmount(double amount, double rate) {
    return amount * rate;
  }

  // Show small rates 
  String _formatRate(double rate) {
    if (rate >= 0.1) {
      return rate.toStringAsFixed(2);
    }
    if (rate >= 0.01) {
      return rate.toStringAsFixed(4);
    }
    return rate.toStringAsFixed(6);
  }

  // Both currency selectors share the same basic dropdown layout.
  Widget _currencySelector({
    required String label,
    required String selected,
    required ValueChanged<String?> onChanged,
  }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selected,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: _currencyCodes.map((String currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // Reading the numeric amount safely so that invalid text never crashes the app
    final trimmedAmount = _amountText.trim();
    final isEmpty = trimmedAmount.isEmpty;
    final parsedAmount = double.tryParse(trimmedAmount);
    final isValidAmount = parsedAmount != null &&
        parsedAmount.isFinite &&
        parsedAmount >= 0;

    final rate = _exchangeRate();
    final double? result = isValidAmount
        ? _convertAmount(parsedAmount!, rate)
        : null;
    final hasFiniteResult = result != null && result.isFinite;

    // The answer and rate are derived from state, not stored separately.
    final resultText = hasFiniteResult
        ? '${result!.toStringAsFixed(2)} $_toCurrency'
        : '—';
    final rateText = '1 $_fromCurrency = ${_formatRate(rate)} $_toCurrency';

    String? errorText;
    if (!isEmpty && !isValidAmount) {
      errorText = 'Enter a valid, non-negative amount.';
    } else if (result != null && !result.isFinite) {
      errorText = 'Amount is too large to convert.';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        centerTitle: false,
        backgroundColor: const Color(0xFFF7F8FC),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Displays result first
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'CONVERTED AMOUNT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        resultText,
                        key: const Key('convertedResult'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        rateText,
                        key: const Key('exchangeRate'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // input and currency controls use the same basic
                // Container / Column / Row pattern 
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        key: const Key('amountInput'),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                          signed: true,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Amount to convert',
                          hintText: 'e.g. 100',
                          border: const OutlineInputBorder(),
                          helperText: 'Use a dot for decimals, e.g. 10.50',
                          errorText: errorText,
                        ),
                        // runs each time the user edits the amount.
                        onChanged: (String value) {
                          setState(() {
                            _amountText = value;
                          });
                        },
                      ),
                      const SizedBox(height: 22),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: _currencySelector(
                              label: 'From',
                              selected: _fromCurrency,
                              onChanged: (String? newValue) {
                                if (newValue == null) return;
                                setState(() {
                                  _fromCurrency = newValue;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: IconButton(
                              key: const Key('swapCurrencies'),
                              tooltip: 'Swap currencies',
                              color: colors.primary,
                              icon: const Icon(Icons.swap_horiz, size: 28),
                              onPressed: () {
                                // Swap both values in one state update.
                                setState(() {
                                  final oldFrom = _fromCurrency;
                                  _fromCurrency = _toCurrency;
                                  _toCurrency = oldFrom;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: _currencySelector(
                              label: 'To',
                              selected: _toCurrency,
                              onChanged: (String? newValue) {
                                if (newValue == null) return;
                                setState(() {
                                  _toCurrency = newValue;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                if (isEmpty)
                  Text(
                    'Enter an amount to see its converted value.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                const SizedBox(height: 10),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, size: 18),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Illustrative fixed exchange rates for learning. '
                        'Rates are not live or suitable for real transactions.',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

