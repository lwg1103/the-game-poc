# Demo mieszkania FPP

Małe demo technologiczne 3D: swobodne zwiedzanie umeblowanego mieszkania z perspektywy pierwszej osoby.

## Ustalenia

- Silnik: Godot 4.7.2 stable (standard, bez .NET), przypięty w `.godot-version`.
- Język: GDScript z typowaniem.
- Platforma: Windows x64.
- Styl: uproszczony realizm.
- Renderer: wstępnie Forward+, do zweryfikowania na prototypie.
- Sprzęt docelowy: RTX 3060. Procesor i ilość RAM pozostają do ustalenia przed końcowym pomiarem.
- Proponowany cel wydajności: 144 FPS przy 1920×1080 w eksportowanym buildzie, bez ray tracingu. To cel do weryfikacji, nie potwierdzony wynik.

## Zakres v0.1

Jedno mieszkanie: salon z aneksem kuchennym, sypialnia, łazienka i korytarz. Układ jest propozycją do sprawdzenia na prototypie z brył.

Chodzenie WASD, rozglądanie myszą, kolizje, wyposażenie, oświetlenie i menu pauzy z regulacją czułości myszy. Bez widocznego ciała postaci, skakania i kucania w pierwszej wersji.

Drzwi otwierane klawiszem E i przełączanie światła są opcjonalnym kolejnym etapem.

Plan pracy: [docs/BACKLOG.md](docs/BACKLOG.md).

## Otwarcie projektu

Pobierz Godot 4.7.2 stable dla Windows x64 z [oficjalnego archiwum](https://godotengine.org/download/archive/4.7.2-stable/), rozpakuj i zaimportuj `project.godot` w menedżerze projektów. Plik `.godot-version` dokumentuje wymaganą wersję; edytor nie wymusza jej automatycznie.

Projekt używa Forward+. Scena startowa powstanie w T02, więc na etapie T01 projekt otwieramy w edytorze, bez uruchamiania gry.

Weryfikacja importu: `Godot_v4.7.2-stable_win64_console.exe --headless --editor --path . --import`.
