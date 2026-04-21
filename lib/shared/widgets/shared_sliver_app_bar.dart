import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../layout/main_scaffold.dart';

class SharedSliverAppBar extends StatelessWidget {
  const SharedSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      backgroundColor: Colors.white, // Solid white background to match Everbyte
      elevation: 0,
      toolbarHeight: 72, 
      flexibleSpace: Container(
        color: Colors.white, // Ensures the safe area is also filled with white
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          bottom: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // LOGO
              GestureDetector(
                onTap: () => context.go('/'),
                child: Transform.translate(
                  offset: const Offset(0, 0), // Reset offset since it's now in a solid block
                  child: Image.asset(
                    'assets/images/studio/blackmoon_logo.png',
                    height: 36, // Scaled down slightly for a cleaner, corporate header look
                    fit: BoxFit.contain,
                    // Changed to black so it contrasts against the new white header
                    color: Colors.black, 
                    
                    // Fallback just in case the image asset isn't rendering yet
                    errorBuilder: (context, error, stackTrace) => const Text(
                      "BLACKMOON",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                        letterSpacing: -1.0,
                      ),
                    ),
                  ),
                ),
              ),

              // HAMBURGER MENU
              IconButton(
                icon: const Icon(
                  Icons.menu,
                  // The cyan/teal color from the Everbyte screenshot. 
                  // If you want to keep strictly to the BlackMoon palette, swap this to Color(0xFFFF4D79)
                  color: Color(0xFF00B4D8), 
                  size: 32, 
                ),
                onPressed: () {
                  MainScaffold.of(context)?.toggleMenu();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
