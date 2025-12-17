# Presentatiehandleiding — Flutter Workshop (30 minuten: 25m advanced + 5m demos)

Deze handleiding is een Nederlandstalige versie van de presentatie-inhoud. De opzet is: 25 minuten dieper naar geavanceerde Flutter-onderwerpen, gevolgd door 5 minuten korte demo's van vier voorbeelden in de repository.

Snelkoppelingen
- Starter project: [`Workshop/starter/pubspec.yaml`](Workshop/starter/pubspec.yaml:1)
- Oplossing entry: [`Workshop/solution/lib/main.dart`](Workshop/solution/lib/main.dart:1)
- Voorbeeldpagina's: [`Workshop/solution/lib/pages/`](Workshop/solution/lib/pages/:1)
- Lab & run-notities: [`Workshop/lab.md`](Workshop/lab.md:1), [`Workshop/RUN_ANDROID_STUDIO.md`](Workshop/RUN_ANDROID_STUDIO.md:1)

Hoog-niveau flow (30 minuten totaal)

1. Titel & korte intro — 15–30s
2. Kort: Waarom Flutter — 1–2 min
3. Advanced deep-dive — 25 min (zie details)
4. Korte tour van 4 voorbeelden — 5 min
5. Afsluiting & links — 30–60s

Opmerking over timing: houd overgangen kort. Als je tijd moet besparen, verkort één van de geavanceerde subonderwerpen (bijv. Animaties of Platform Channels).

Geavanceerde 25-minuten deep-dive — micro-schema

- Architectuur & app-structuur — 5m
  - Thema's: scheiding van UI, business logic en data; navigatie; map-structuur.
  - Keuzes: BLoC vs Provider vs Riverpod; folder-per-feature of laag-per-laag.
  - Referentie: [`Workshop/solution/lib/main.dart`](Workshop/solution/lib/main.dart:1)

- Performance & profiling — 5m
  - Thema's: onnodige rebuilds vermijden, const-constructors, RepaintBoundary, image caching.
  - Tools: Flutter DevTools (CPU, Timeline, Memory), `flutter run --profile`.

- State management patronen — 5m
  - Thema's: wanneer setState, InheritedWidget, Provider, Riverpod of BLoC gebruiken.
  - Demo/referentie: [`Workshop/solution/lib/pages/state_solution.dart`](Workshop/solution/lib/pages/state_solution.dart:1)

- Animaties & custom rendering — 4m
  - Thema's: impliciete vs expliciete animaties, AnimationController, AnimatedBuilder, CustomPainter.
  - Demo-idee: klein animatievoorbeeld dat je kunt hot-reloaden.

- Platform channels & native integratie — 4m
  - Thema's: MethodChannel, EventChannel, platform views, wanneer native code schrijven.

- Packages, testen & CI/CD — 2m
  - Thema's: dependency management met pubspec.yaml, semver, unit/widget/integratie tests, CI (GitHub Actions, Codemagic).

Sprekersnotities voor de advanced-block

- Gebruik één slide per subonderwerp, 3–5 korte bullets.
- Laat één korte code- of DevTools-screenshot zien voor performance/state slides.
- Voorkom grote live codewijzigingen; liever korte hot-reload demonstratie of vooraf opgenomen clip.

Snelle 5-minuten walkthrough — 4 voorbeelden

- Doel: laat snel zien wat er in de repo staat en wat deelnemers later kunnen uitproberen.
- Verdeling: 4 × 1 minuut (elk voorbeeld) + 1 minuut afronding = 5 minuten totaal

- Snake — 1m
  - Gameplay screenshot; leerpunten: game loop, timers, input handling.
  - Bestand: [`Workshop/solution/lib/pages/snake_solution.dart`](Workshop/solution/lib/pages/snake_solution.dart:1)

- Flappy — 1m
  - Screenshot; leerpunten: eenvoudige physics, spawns, collision detection.
  - Bestand: [`Workshop/solution/lib/pages/flappy_solution.dart`](Workshop/solution/lib/pages/flappy_solution.dart:1)

- Layout — 1m
  - Responsive layout-patronen: Flex / Row / Column / Stack.
  - Bestand: [`Workshop/solution/lib/pages/layout_solution.dart`](Workshop/solution/lib/pages/layout_solution.dart:1)

- State voorbeeld — 1m
  - Contrast tussen lokale setState en app-brede state patterns.
  - Bestand: [`Workshop/solution/lib/pages/state_solution.dart`](Workshop/solution/lib/pages/state_solution.dart:1)

Live-demo aanbevelingen (binnen 30 min)

- Kies één korte live-demo (30–90s) of gebruik een vooraf opgenomen clip voor complexere onderdelen.
- Voor de advanced-block: laat één DevTools-profile screenshot zien en een korte hot-reload wijziging (15–30s).
- Voor de 4-voorbeelden: gebruik 1 screenshot per voorbeeld of korte clips van ~10–15s elk.

Pre-demo checklist (belangrijk)

- Draai `flutter doctor` en los issues op: `flutter doctor`
- Haal dependencies op: `cd Workshop/solution && flutter pub get`
- Start emulators of koppel apparaten vroegtijdig; pre-build indien nodig.
- Zet systeemmeldingen uit en sluit zware achtergrondprocessen.

Cheat-sheet (zet op één slide)

- flutter --version
- flutter doctor
- flutter devices
- cd Workshop/solution && flutter pub get
- flutter run -d <device-id>
- flutter run --profile

Slides en ontwerp-tips

- Eén concept per slide, 3–5 bullets, groot lettertype en hoog contrast.
- Gebruik DevTools-screenshots en kleine geannoteerde codefragmenten in plaats van volledige bronnen.
- Zet lange commando's of troubleshooting details in de Notes-sectie, niet op de hoofdslide.

Backup-plan

- Vooraf opgenomen demo-video (30–90s) met link in de notes.
- Screenshots van belangrijke stappen (app start, gameplay, DevTools).
- Lokale builds beschikbaar houden voor noodgevallen.

Bronnen

- Officiële docs: https://flutter.dev en https://dart.dev
- Pub packages: https://pub.dev
- Repo README: [`README.md`](README.md:1)
- Lab: [`Workshop/lab.md`](Workshop/lab.md:1)

Presentator checklist (voordat je op het podium gaat)

- Emulators / apparaten opgestart en getest
- `flutter doctor` geeft geen kritieke fouten
- Project geopend en dependencies geïnstalleerd (`flutter pub get`)
- Backup video/screenshots klaar op USB of cloud

Kort voorbeeld slide-tekst (kopiëren naar PPT + Notes)

- Slide titel: Architectuur & State
- Bullets:
  - Laagopbouw app: scheiding UI en logica
  - Gebruik Provider/Riverpod voor kleine apps; BLoC voor grotere apps
- Note: laat klein codefragment zien dat top-level state inbindt (zie [`Workshop/solution/lib/main.dart`](Workshop/solution/lib/main.dart:1))

Als je wilt kan ik ook een 30-slide PowerPoint-outline genereren of de volledige sprekerstekst per slide klaarmaken.

-- Einde van de handleiding in het Engels; hieronder vind je kant-en-klare slide-teksten en korte sprekersteksten in het Nederlands --

## Klaar-voor-gebruik slide-teksten (kopieer naar slides)

Titel slide
- Flutter Advanced Workshop — 25m diepgaande sessie + 5m korte demo's
- Presentator: Jouw Naam | Datum

Agenda
- Waarom Flutter (1–2m)
- Advanced deep-dive (25m): Architectuur, Performance, State, Animatie, Native integratie, Testing/CI
- Korte repo-voorbeelden (5m): Snake, Flappy, Layout, State
- Vragen (Q&A)

Waarom Flutter
- Één codebase: mobiel, web & desktop
- Snelle iteratie met Hot Reload
- Rijke composeerbare UI (widgets)

Architectuur & App-structuur
- Scheid UI, business logic en data
- Gebruik Provider/Riverpod voor kleine apps; BLoC voor grotere apps
- Houd widgets klein en testbaar
- Zie app entry: [`Workshop/solution/lib/main.dart`](Workshop/solution/lib/main.dart:1)

Performance & Profiling
- Minimaliseer rebuilds: const-constructors, extract widgets
- Gebruik DevTools: CPU, Timeline, Memory
- Optimaliseer afbeeldingen en gebruik RepaintBoundary

State Management
- setState voor lokale UI-wijzigingen
- Provider/Riverpod voor app-brede state
- BLoC/Cubit voor voorspelbare complexe flows
- Voorbeeld: [`Workshop/solution/lib/pages/state_solution.dart`](Workshop/solution/lib/pages/state_solution.dart:1)

Animaties & Custom Rendering
- Impliciete animaties voor snelle polish (AnimatedContainer)
- AnimationController + AnimatedBuilder voor nauwkeurige controle
- CustomPainter voor maatwerk graphics

Platform Channels & Native Integratie
- MethodChannel voor aanroepen; EventChannel voor streams
- Gebruik eerst pub.dev packages; schrijf native code alleen als het nodig is

Packages, Testing & CI
- Beheer dependencies met pubspec.yaml; respecteer semver
- Tests: unit, widget en integratietests
- CI: GitHub Actions of Codemagic

Quick Repo-voorbeelden (4 × 1 min)
- Snake — game loop & timers; input handling
  - [`Workshop/solution/lib/pages/snake_solution.dart`](Workshop/solution/lib/pages/snake_solution.dart:1)
- Flappy — eenvoudige physics & collisions
  - [`Workshop/solution/lib/pages/flappy_solution.dart`](Workshop/solution/lib/pages/flappy_solution.dart:1)
- Layout — responsive layouts met Row/Column/Stack
  - [`Workshop/solution/lib/pages/layout_solution.dart`](Workshop/solution/lib/pages/layout_solution.dart:1)
- State — lokaal versus app-brede state
  - [`Workshop/solution/lib/pages/state_solution.dart`](Workshop/solution/lib/pages/state_solution.dart:1)

Cheat-sheet (één slide)
- flutter --version
- flutter doctor
- flutter devices
- cd Workshop/solution && flutter pub get
- flutter run -d [device-id]

Pre-demo Checklist
- Draai `flutter doctor` en los issues op
- Voer `flutter pub get` uit in de solution-map
- Start emulators / koppel apparaten tevoren
- Schakel notificaties uit

Backup Plan
- Vooraf opgenomen demo-video (30–90s)
- Screenshots per voorbeeld
- Lokale builds beschikbaar

Bronnen & Links
- Docs: https://flutter.dev, https://dart.dev
- Repo: [`README.md`](README.md:1)
- Lab: [`Workshop/lab.md`](Workshop/lab.md:1)
- Starter: [`Workshop/starter/pubspec.yaml`](Workshop/starter/pubspec.yaml:1)

Contact
- Presentator: Jouw Naam — e-mail / GitHub

## Sprekersscript — wat je kunt zeggen per slide (kopieer naar Notes)

Titel slide
- "Hallo, ik ben [Jouw Naam]. Vandaag geef ik een 25 minuten durende geavanceerde deep-dive in Flutter, gevolgd door 5 minuten met korte demo's van voorbeelden in deze repository."

Agenda
- "Korte rondleiding: waarom Flutter, daarna diepe onderwerpen (architectuur, performance, state, animatie, native integratie, testing/CI) en tot slot 4 korte voorbeelden."

Waarom Flutter
- "Flutter geeft één codebase voor mobiel, web en desktop met near-native performance via de Skia-engine. Hot reload versnelt iteratie en het widget-model maakt UI's samenstelbaar en testbaar."

Architectuur & App-structuur
- "Een heldere architectuur vermindert bugs en verhoogt productiviteit. Scheid UI, business logic en data; houd widgets klein en testbaar."
- "Voor kleine apps is Provider/Riverpod vaak voldoende; voor grotere apps met complexe flows kies je BLoC."
- "Zie entrypoint: [`Workshop/solution/lib/main.dart`](Workshop/solution/lib/main.dart:1)."

Performance & Profiling
- "Performance gaat over het vermijden van onnodig werk. Gebruik const-constructors, splits widgets en minimaliseer layout passes."
- "Open DevTools om CPU, Timeline en geheugen te onderzoeken; gebruik `flutter run --profile` voor realistische data."

State Management
- "Gebruik setState bij lokale, beperkte updates. Voor gedeelde state is Provider of Riverpod eenvoudig te gebruiken; BLoC past bij grotere, event-gedreven architecturen."
- "Voorbeeldcode: [`Workshop/solution/lib/pages/state_solution.dart`](Workshop/solution/lib/pages/state_solution.dart:1)."

Animaties & Custom Rendering
- "Impliciete animaties (zoals AnimatedContainer) zijn snel voor polish. Voor complexe motion gebruik je AnimationController en AnimatedBuilder."
- "Gebruik CustomPainter als je maatwerk tekenen nodig hebt en performance kritisch is."

Platform Channels & Native Integratie
- "Kijk eerst of er een package op pub.dev is. Als je native code nodig hebt: MethodChannel voor aanroepen, EventChannel voor data streams, en platform views voor native UI."

Packages, Testing & CI
- "Beheer dependencies in pubspec.yaml en automatiseer tests in CI met GitHub Actions of Codemagic."

Live demo (wat ik zal doen)
- "Ik open de solution-map, voer `flutter pub get` uit, start een emulator en run `flutter run -d [device-id]`. Daarna wijzig ik een kleine waarde en doe hot reload."

Quick example — Snake
- "Snake toont een eenvoudige game-loop en timer-gebaseerde state. Goed om input en update loops te leren." [`Workshop/solution/lib/pages/snake_solution.dart`](Workshop/solution/lib/pages/snake_solution.dart:1)

Quick example — Flappy
- "Flappy illustreert eenvoudige physics en botsingdetectie — handig om beweging en collisions te modelleren." [`Workshop/solution/lib/pages/flappy_solution.dart`](Workshop/solution/lib/pages/flappy_solution.dart:1)

Quick example — Layout
- "Layout-demo laat praktische patronen zien met Row, Column en Stack en tips voor responsiviteit." [`Workshop/solution/lib/pages/layout_solution.dart`](Workshop/solution/lib/pages/layout_solution.dart:1)

Quick example — State
- "State-voorbeeld toont lokaal setState versus hogere-level patronen en hoe top-level state wordt aangesloten." [`Workshop/solution/lib/pages/state_solution.dart`](Workshop/solution/lib/pages/state_solution.dart:1)

Cheat-sheet slide (zeg dit bij de commando's)
- "Korte commando's: `flutter --version`, `flutter doctor`, `flutter devices`, `cd Workshop/solution && flutter pub get`, `flutter run -d [device-id]`."

Pre-demo checklist (zeg voordat je demo start)
- "Ik heb `flutter doctor` uitgevoerd, dependencies opgehaald, emulator gestart en notificaties uitgeschakeld."

Backup-plan (zeg indien nodig)
- "Als de live demo faalt, speel ik de vooraf opgenomen clip af en laat screenshots zien. Ik heb ook lokale builds klaarliggen."

Afsluiting / Contact
- "Bedankt voor jullie aandacht. Materialen en de starter vind je in de repo: [`README.md`](README.md:1) en [`Workshop/lab.md`](Workshop/lab.md:1). Ik beantwoord graag vragen na de sessie."

Timing & signalen (in Notes voor presenter)
- "Houd ongeveer 20 minuten verstreken voordat je begint af te ronden zodat de 5 minuten voor voorbeelden beschikbaar blijven."
- "Als tijd tekort komt, sla de diepere code walkthrough over en toon screenshots of de video."

Call to action
- "Moedig deelnemers aan de starter lokaal uit te proberen en de lab-instructies te volgen. Bied eventueel een korte support-sessie aan na de presentatie."

Eind van het Nederlandstalige deel.

(Optioneel) Als je wilt, kan ik van dit document direct een PowerPoint-outline maken met één slide per sectie en de Notes ingevuld.

## Kort overzicht — Alleen bullets (kopiëer/plak op slides)

Titel
- Flutter Advanced Workshop — 25m + 5m
- Presentator: Jouw Naam | Datum

Agenda
- Waarom Flutter
- Advanced: Architectuur, Performance, State, Animaties, Native, Testing/CI
- 4 korte voorbeelden
- Vragen

Waarom Flutter
- Eén codebase: mobiel, web, desktop
- Hot Reload: snelle iteratie
- Widgets: consistente, composeerbare UI

Architectuur
- Scheid UI / logica / data
- Provider/Riverpod (klein) — BLoC (groot)

Performance
- Gebruik const & extract widgets
- Profiler met DevTools (CPU/Timeline/Memory)

State management
- setState = lokaal
- Provider / Riverpod = app-breed
- BLoC/Cubit = complexe flows

Animaties
- Impliciet (AnimatedContainer) voor snelle polish
- AnimationController voor nauwkeurige controle

Platform channels
- Gebruik eerst pub.dev packages
- MethodChannel / EventChannel voor native integratie

Testing & CI
- Unit / widget / integratie tests
- CI: GitHub Actions of Codemagic

Live demo (kort)
- cd Workshop/solution && flutter pub get
- flutter run -d <device-id> (laat hot reload zien)
- Referentie entry: [`Workshop/solution/lib/main.dart`](Workshop/solution/lib/main.dart:1)

Voorbeelden (4 × 1 min)
- Snake — game loop, timers — [`Workshop/solution/lib/pages/snake_solution.dart`](Workshop/solution/lib/pages/snake_solution.dart:1)
- Flappy — physics & collisions — [`Workshop/solution/lib/pages/flappy_solution.dart`](Workshop/solution/lib/pages/flappy_solution.dart:1)
- Layout — Row/Column/Stack, responsiviteit — [`Workshop/solution/lib/pages/layout_solution.dart`](Workshop/solution/lib/pages/layout_solution.dart:1)
- State — lokaal vs app-breed — [`Workshop/solution/lib/pages/state_solution.dart`](Workshop/solution/lib/pages/state_solution.dart:1)

Cheat-sheet commands (één slide)
- flutter --version
- flutter doctor
- flutter devices
- cd Workshop/solution && flutter pub get
- flutter run -d <device-id>

Pre-demo checklist
- Emulators/apparaten gestart
- Dependencies opgehaald (`flutter pub get`)
- Notificaties uit en achtergrondapps gesloten

Backup plan
- Vooraf opgenomen demo-video (30–90s)
- Screenshots per voorbeeld
- Lokale builds beschikbaar

Afsluiting / contact
- Repo & lab: [`README.md`](README.md:1), [`Workshop/lab.md`](Workshop/lab.md:1)
- Presentator: Jouw Naam — e-mail / GitHub
