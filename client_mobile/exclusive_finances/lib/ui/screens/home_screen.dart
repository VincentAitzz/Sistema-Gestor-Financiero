import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Header
              _buildHeader(context),
              const SizedBox(height: 30),
              // Main Balance Card
              _buildBalanceCard(context, colors),
              const SizedBox(height: 30),
              // Quick Actions
              const SizedBox(height: 30),
              _buildQuickActions(colors),
              const SizedBox(height: 30),
              Text(
                "Actividad reciente",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                  color: colors.onSurface,
                ),
              ),
              const SizedBox(height: 15),
              _buildTransactionList(context),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Buenas tardes,",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const Text(
              "Vincent",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        CircleAvatar(
          backgroundColor: Theme.of(
            context,
          ).colorScheme.primary.withValues(alpha: 0.2),
          child: const Icon(Icons.person, color: Colors.purple),
        ),
      ],
    );
  }

  Widget _buildBalanceCard(BuildContext context, ColorScheme colors) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.primary, colors.primary.withValues(alpha: 0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Balance total",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            "\$4,500.00",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.arrow_upward, color: Colors.greenAccent, size: 20),
              Text(" +12% este mes", style: TextStyle(color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }

  // Métodos _buildQuickActions y _buildTransactionList irían aquí...
  Widget _buildQuickActions(ColorScheme colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _actionButton(colors, Icons.add_rounded, "Ingreso"),
        _actionButton(colors, Icons.remove_rounded, "Gasto"),
        _actionButton(colors, Icons.swap_horiz_rounded, "Mover"),
        _actionButton(colors, Icons.pie_chart_rounded, "Plan"),
      ],
    );
  }

  Widget _actionButton(ColorScheme colors, IconData icon, String label) {
    return Column(
      children: [
        GlassCard(
          padding: const EdgeInsets.all(16),
          child: Icon(icon, color: colors.primary, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: colors.onSurface.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionList(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // Datos simulados para ver la representación visual
    final transactions = [
      {
        'title': 'Apple Music',
        'category': 'Suscripción',
        'amount': '-9.99',
        'icon': Icons.music_note,
      },
      {
        'title': 'Depósito Nómina',
        'category': 'Ingreso',
        'amount': '+2,500.00',
        'icon': Icons.work,
      },
      {
        'title': 'Starbucks',
        'category': 'Comida',
        'amount': '-4.50',
        'icon': Icons.coffee,
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // El scroll lo maneja el SingleChildScrollView del Home
      itemCount: transactions.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = transactions[index];
        final isPositive = item['amount'].toString().contains('+');

        return GlassCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: colors.primary.withValues(alpha: 0.1),
                child: Icon(
                  item['icon'] as IconData,
                  color: colors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      item['category'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                item['amount'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isPositive ? Colors.greenAccent : colors.onSurface,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
