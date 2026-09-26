import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models.dart';

// Extrait d'Atelier de Poche.
// Prévenir le client sur WhatsApp quand son téléphone est prêt.
// Pas d'API WhatsApp Business (payante, et on risque le blocage du numéro) :
// on ouvre juste WhatsApp avec le message déjà écrit, le technicien appuie sur Envoyer.

// Met un numéro togolais au format attendu par WhatsApp : 228 + 8 chiffres,
// sans "+", sans espaces (ex. "90 12 34 56" -> "22890123456").
String numeroWhatsApp(String brut) {
  var chiffres = brut.replaceAll(RegExp(r'[^0-9]'), '');
  if (chiffres.startsWith('00')) chiffres = chiffres.substring(2);
  if (chiffres.startsWith('228')) return chiffres;
  if (chiffres.length == 8) return '228$chiffres';
  return chiffres;
}

// Le message pré-écrit envoyé au client quand son téléphone est prêt.
String messageClientPret(Reparation r) {
  final appareil = '${r.appareilMarque} ${r.appareilModele}'.trim();
  final debut =
      'Bonjour ${r.clientNom}, votre $appareil (ticket ${r.ticket}) est réparé et prêt.';
  if (r.prixFinal != null && r.prixFinal! > 0) {
    return '$debut Montant à régler : ${r.prixFinal!.toStringAsFixed(0)} FCFA.';
  }
  return '$debut Vous pouvez venir le récupérer.';
}

// Ouvre WhatsApp avec le message pré-rempli pour ce client.
Future<void> prevenirClientWhatsApp(BuildContext context, Reparation r) async {
  if (r.clientTelephone.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Ce client n'a pas de numéro de téléphone enregistré."),
      ),
    );
    return;
  }

  await ouvrirWhatsApp(context,
      numero: r.clientTelephone, message: messageClientPret(r));
}

// Ouvre WhatsApp avec un message pré-rempli vers n'importe quel numéro.
Future<void> ouvrirWhatsApp(
  BuildContext context, {
  required String numero,
  required String message,
}) async {
  final uri = Uri.parse(
      'https://wa.me/${numeroWhatsApp(numero)}?text=${Uri.encodeComponent(message)}');

  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Impossible d'ouvrir WhatsApp.")),
      );
    }
  }
}

// Lance un appel téléphonique direct vers ce numéro.
Future<void> appelerNumero(BuildContext context, String numero) async {
  final uri =
      Uri(scheme: 'tel', path: numero.replaceAll(RegExp(r'[^0-9+]'), ''));
  if (!await launchUrl(uri)) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Impossible d'appeler $numero.")),
      );
    }
  }
}
