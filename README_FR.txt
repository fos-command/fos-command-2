# COMMAND — nouvelle version collaborative

Cette copie reprend l'interface noisy-mountain V3.1 (8 modules, FR/EN, planning, checklists, AOW, EE, AD, membres, NAP, classements et guerres). Elle ajoute une connexion, une base D1 partagée et 9 accès R4/R5 remplaçables.

## Important
- Le Worker `noisy-mountain-0545` et les deux anciennes versions ne sont pas modifiés.
- Cette nouvelle version ne doit pas être partagée à l'équipe avant les tests.
- Les 9 comptes R4/R5 ont les mêmes droits de modification. Le compte administrateur séparé sert uniquement à créer, désactiver ou remplacer les 9 accès.
- Une modification de compte coupe les anciennes sessions de cet emplacement.
- Le nom et la signature de l'alliance se modifient dans Gestion des accès, sans redéploiement.
- Les données de l'ancien domaine ne sont pas automatiquement transférées : le stockage local du navigateur est isolé par domaine. Il faudra organiser une migration si l'ancien espace contient des données à conserver.

## Installation Cloudflare (à faire sur un nouveau Worker)
1. Créer une nouvelle base D1, par exemple `command-collectif-db`.
2. Ouvrir sa console SQL et exécuter tout le contenu de `schema.sql`.
3. Créer un nouveau Worker, par exemple `command-collectif` (ne pas modifier noisy-mountain ni fos-command).
4. Déployer `worker.js` sur le nouveau Worker. Le fichier `wrangler.toml` indique son nom et son point d'entrée si tu utilises une connexion GitHub.
5. Dans les paramètres du nouveau Worker, ajouter une liaison D1 : variable **DB**, base **command-collectif-db**.
6. Ajouter un secret Worker nommé **COMMAND_SETUP_KEY** avec une valeur longue et unique (au moins 32 caractères). Ne jamais envoyer cette clé dans le chat ni la communiquer aux joueurs.
7. Redéployer le Worker après ajout de la liaison et du secret.
8. Ouvrir le nouveau domaine. La première page permet de créer le compte administrateur avec la clé `COMMAND_SETUP_KEY`.
9. Depuis le compte administrateur, ouvrir **Gestion des accès** et créer les accès 1 à 9. Pour remplacer un joueur, modifier l'identifiant/nom et définir un nouveau mot de passe dans son emplacement.

## Vérifications avant partage
- Connexion administrateur et création des 9 comptes.
- Connexion simultanée de deux comptes R4/R5 sur deux appareils/navigateurs.
- Modifier une checklist, un membre, un NAP et un événement sur le premier appareil ; vérifier l'apparition sur le second (actualisation automatique toutes les 7 secondes).
- Remplacer un accès et vérifier que l'ancien mot de passe ne fonctionne plus.
- Tester français/anglais et l'affichage sur téléphone.
- Faire une sauvegarde D1 avant d'envisager de supprimer les anciennes versions.

## Limites connues de cette première base
Les enregistrements sont partagés par catégorie de données. Si deux personnes modifient exactement la même liste au même moment, la dernière sauvegarde peut remplacer l'autre modification dans cette liste. Pour l'usage normal et les tests initiaux, éviter les modifications simultanées de la même liste. Une évolution pourra ensuite stocker chaque élément séparément.
