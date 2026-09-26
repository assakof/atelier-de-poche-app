// Extrait d'Atelier de Poche.
// Affichage des montants en FCFA : "25000 FCFA" devient "25 000 FCFA".
// Tout bete mais le patron et le client lisent beaucoup mieux.
library;

/// Espace insecable (U+00A0) : le montant ne se coupe pas en fin de ligne.
const String espaceMille = ' ';

/// `25000` -> `"25 000 FCFA"` a l'affichage. `null` -> `"—"`.
String montantFcfa(num? valeur) {
  if (valeur == null) return '—';
  return '${entierGroupe(valeur)}${espaceMille}FCFA';
}

/// Depuis combien de temps : "aujourd'hui", "hier", "il y a 4 j", "il y a 3 sem".
String ilYA(DateTime date, {DateTime? maintenant}) {
  final ref = maintenant ?? DateTime.now();
  final jours = DateTime(ref.year, ref.month, ref.day)
      .difference(DateTime(date.year, date.month, date.day))
      .inDays;
  if (jours <= 0) return "aujourd'hui";
  if (jours == 1) return 'hier';
  if (jours < 7) return 'il y a $jours j';
  if (jours < 30) return 'il y a ${(jours / 7).floor()} sem';
  if (jours < 365) return 'il y a ${(jours / 30).floor()} mois';
  return 'il y a ${(jours / 365).floor()} an${jours >= 730 ? 's' : ''}';
}

/// `1234567` -> `"1 234 567"` (sans la devise), espaces insecables.
String entierGroupe(num valeur) {
  final bool negatif = valeur < 0;
  // Les montants FCFA n'ont pas de centimes : on arrondit a l'entier.
  final String chiffres = valeur.abs().round().toString();

  final StringBuffer buffer = StringBuffer();
  for (var i = 0; i < chiffres.length; i++) {
    if (i > 0 && (chiffres.length - i) % 3 == 0) {
      buffer.write(espaceMille);
    }
    buffer.write(chiffres[i]);
  }
  return negatif ? '-$buffer' : buffer.toString();
}
