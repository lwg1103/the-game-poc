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

Projekt używa Forward+. Uruchom F5 dla projektu: zobaczysz prototyp mieszkania z salonem i aneksem, sypialnią, łazienką oraz korytarzem. Układ i wymiary opisuje [docs/APARTMENT.md](docs/APARTMENT.md). Podłoga, ściany, nadproża i sufit mają kolizje. Bryły mebli pozostają wizualnymi placeholderami do T11. Postać ma kapsułę wysokości 1,8 m (promień 0,3 m), grawitację i kamerę na wysokości 1,65 m. Podłoga zatrzymuje opadanie. Kliknij w okno, aby włączyć sterowanie: WASD porusza postacią, mysz obraca kamerę, Escape uwalnia kursor. Prędkość wynosi 3,5 m/s, a pionowy obrót jest ograniczony do ±85°. Po spadnięciu z platformy postać wraca na start. Alt+Tab uwalnia kursor i zatrzymuje ruch poziomy. Po powrocie kliknij, aby wznowić sterowanie; pierwszy ruch myszy po przechwyceniu jest pomijany, aby uniknąć skoku kamery.

Scena `scenes/player.tscn` jest wielokrotnego użytku; jej początek układu współrzędnych znajduje się przy stopach. Test fizyki: `Godot_v4.7.2-stable_win64_console.exe --headless --path . --script tests/player_test.gd`.

Struktura: `scenes/` — sceny 3D, `scripts/` — logika gry, `assets/` — zasoby, `ui/` — interfejs, `tests/` — testy uruchamiane przez silnik.

Test startu: `Godot_v4.7.2-stable_win64_console.exe --headless --path . --script tests/startup_test.gd`.

## Wejście i eksport Windows

Input Map definiuje fizyczne klawisze WASD jako `move_forward`, `move_backward`, `move_left`, `move_right` oraz Escape jako `pause`. Ruch i mysz działają po kliknięciu w okno. Escape zwalnia sterowanie; pełne menu pauzy powstanie w T16.

Zainstaluj szablony eksportu **4.7.2 stable** w Godot (Editor → Manage Export Templates). W katalogu projektu utwórz `builds/windows`, a następnie wykonaj:

```powershell
Godot_v4.7.2-stable_win64_console.exe --headless --path . --export-release "Windows Desktop"
```

Wynik: `builds/windows/ApartmentFPP.exe`, Windows x64 z zasobami osadzonymi w EXE, bez podpisu cyfrowego. Działa bez edytora. Katalog `builds/` jest ignorowany przez Git.

Test konfiguracji: `Godot_v4.7.2-stable_win64_console.exe --headless --path . --script tests/input_export_test.gd`.

Weryfikacja importu: `Godot_v4.7.2-stable_win64_console.exe --headless --editor --path . --import`.
