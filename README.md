# Atelier de Poche

L'application que j'utilise dans ma boutique de réparation de téléphones, et que je propose maintenant aux autres ateliers.

Avant on travaillait avec un cahier : le nom du client, le téléphone, la panne, le prix qu'on avait discuté. Sauf que le cahier se perd, on ne retrouve plus le téléphone rangé quelque part dans l'armoire, et en fin de journée personne ne sait exactement combien est rentré. Atelier de Poche remplace ce cahier.

## Télécharger

Android : prends le fichier `.apk` dans l'onglet [Releases](../../releases/latest).

1. Télécharge l'apk sur le téléphone
2. Ouvre-le. Si Android parle de « source inconnue », autorise (normal, l'appli n'est pas encore sur le Play Store)
3. Installe, c'est prêt

## Ce qu'elle fait

- **Fiche de réparation** : client, téléphone, panne, technicien, photos de l'appareil à l'arrivée
- **Le marchandage** : prix plancher (que seul le patron voit), prix proposé, prix final. Chez nous le prix se discute, l'appli fait avec
- **Étiquette QR** à coller sur le téléphone, avec l'emplacement de rangement (armoire, étagère). Le client revient, on scanne, on sait où est son appareil
- **Message WhatsApp** au client quand c'est réparé, avec le montant à payer
- **Stock** des pièces et accessoires, alerte quand ça baisse
- **Vente d'accessoires** (chargeurs, coques, écouteurs...)
- **Caisse du jour** : espèces, T-Money, Flooz, Mixx
- Marche **sans connexion**. Le réseau coupe souvent ici, l'appli continue et se resynchronise toute seule quand ça revient

Il y a une version Gratuite (tout sur le téléphone) et une version Pro : plusieurs appareils, plusieurs techniciens, chacun ne voit que ses réparations, le patron voit tout. Le Pro se paye en Mobile Money, pas besoin de carte bancaire.

## Technique

Flutter (Dart), Supabase pour la version Pro, SQLite en local pour la Gratuite, génération d'étiquettes PDF, scan QR avec la caméra. Testée en vrai dans la boutique, sur un Galaxy A15 tout ce qu'il y a de plus normal.

Le code n'est pas public, mais voici quelques bouts :

- [`extraits/whatsapp.dart`](extraits/whatsapp.dart) — prévenir le client sans API payante
- [`extraits/format.dart`](extraits/format.dart) — les montants en FCFA lisibles
- [`extraits/etat_badge.dart`](extraits/etat_badge.dart) — la pastille d'état d'une réparation

## Contact

Tu as un atelier et tu veux l'essayer ou passer en Pro ?

**KA Maintenance & Services** — WhatsApp : 90 69 65 37 / 92 47 78 39
