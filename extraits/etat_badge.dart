import 'package:flutter/material.dart';
import '../etats.dart';

// Extrait d'Atelier de Poche.
// La petite pastille de couleur qu'on voit sur chaque réparation dans la liste
// (En diagnostic, Réparé, En attente de pièce...). Couleurs différentes en mode clair / sombre.
class EtatBadge extends StatelessWidget {
  const EtatBadge(this.etat, {super.key, this.court = true, this.dense = false});

  final String etat;

  /// Utilise le libelle abrege (pour les listes).
  final bool court;

  /// Version compacte (padding reduit).
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final info = infoEtat(etat);
    final c = couleursEtat(etat, Theme.of(context).colorScheme);

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: dense ? 8 : 10, vertical: dense ? 3 : 5),
      decoration: BoxDecoration(
        color: c.fond,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(info.icone, size: dense ? 12 : 14, color: c.texte),
          const SizedBox(width: 5),
          Text(
            court ? info.court : info.etat,
            style: TextStyle(
              color: c.texte,
              fontSize: dense ? 11 : 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
