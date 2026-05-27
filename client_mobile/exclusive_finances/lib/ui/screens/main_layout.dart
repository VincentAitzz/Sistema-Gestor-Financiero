import 'dart:ui';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  // Aquí agregaremos las futuras pantallas. Por ahora, Home y 3 Placeholders.
  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(child: Text("Pantalla de Análisis (Gráficos)")),
    const Center(child: Text("Pantalla de Tarjetas/Billetera")),
    const Center(child: Text("Configuración (Cambio de Tema)")),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      // Usamos IndexedStack para que las pantallas no pierdan su estado (como el scroll) al cambiar
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      // Propiedad clave para que el contenido pase por "debajo" de la barra flotante
      extendBody: true, 
      bottomNavigationBar: _buildGlassNavigationBar(colors),
    );
  }

  Widget _buildGlassNavigationBar(ColorScheme colors) {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: colors.onSurface.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _navItem(Icons.home_rounded, 0, colors),
                _navItem(Icons.bar_chart_rounded, 1, colors),
                _navItem(Icons.account_balance_wallet_rounded, 2, colors),
                _navItem(Icons.settings_rounded, 3, colors),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, int index, ColorScheme colors) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? colors.primary.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          color: isSelected ? colors.primary : colors.onSurface.withValues(alpha: 0.5),
          size: 26,
        ),
      ),
    );
  }
}