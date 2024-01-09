# Copains de route UI

Ce projet à été développé par KESRAOUI Nassima, PLANCKE Aurélien et PLÉ Lucas.

Copains de route UI est un projet flutter pour l'application [Copains de route](https://www.instagram.com/copainsderoute/). 

Ce projet fonctionne avec les api google maps, il vous faudra donc une clef API Google Maps Key si vous voulez le faire fonctionner chez vous. Dans le projet vous pouvez ensuite remplacer {GMP_KEY} par la clef obtenue précédemment.
Pour le faire fonctionner en local vous devez également avoir en local le projet [Copains de route back](https://github.com/Chagul/copains-de-route-back).

Le projet est compatible en Android à partir du SDK 20

## Pré-Requis
- [Flutter](https://docs.flutter.dev/get-started/install)

Si vous souhaitez lancer l'application localement, il vous faudra un émulateur Android notamment pour émuler la localisation de l'appareil. Vous pouvez suivre ce [tutoriel](https://developer.android.com/studio/run/managing-avds?hl=fr).
Vous aurez alors probablement besoin d'[Android Studio](https://developer.android.com/studio)

## Compiler le projet
Pour construire un APK du projet, il vous faut effectivement un clef d'API Google Maps. Vous pouvez rechercher dans le projet les tags {GMP_KEY} et les remplacer par votre clef d'API.
Vous devez également générer un keystore pour pouvoir signer l'application. Vous pouvez directement suivre la [documentation](https://docs.flutter.dev/deployment/android#sign-the-app) de Flutter pour cette étape.

Une fois ceci fait, exécuter à la racine du projet la commande suivante :
```bash
flutter build apk
```
