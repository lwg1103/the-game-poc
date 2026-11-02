# Backlog dema FPP

T01 wykonane; pozostałe zadania do wykonania. Wybór silnika został zatwierdzony: Godot.

## M1 — Grywalny prototyp

### US-01 — Uruchomienie
Jako gracz chcę uruchomić demo i znaleźć się w mieszkaniu.

- [x] T01: Przypiąć stabilną wersję Godot 4 i utworzyć projekt oraz reguły ignorowania plików generowanych.
- [ ] T02: Utworzyć katalogi scen, skryptów, zasobów i UI oraz scenę startową.
- [ ] T03: Skonfigurować akcje wejścia i eksport Windows x64.

Odbiór: build uruchamia się bez edytora i pokazuje scenę startową.

### US-02 — Poruszanie FPP
Jako gracz chcę swobodnie chodzić i rozglądać się.

- [ ] T04: Zbudować kontroler CharacterBody3D z kapsułą, grawitacją i kamerą na wysokości oczu.
- [ ] T05: Dodać WASD, normalizację ruchu po przekątnej, rozglądanie myszą i ograniczenie kąta pionowego.
- [ ] T06: Obsłużyć przechwytywanie kursora i utratę fokusu okna.

Odbiór: prędkość ruchu nie zależy od kierunku ani liczby klatek; kamera nie obraca się do góry nogami; powrót do okna nie powoduje nagłego obrotu.

### US-03 — Dostępne pomieszczenia
Jako gracz chcę przejść przez całe mieszkanie bez blokowania się.

- [ ] T07: Zbudować prototyp z brył w spójnej skali: salon z aneksem, sypialnia, łazienka, korytarz.
- [ ] T08: Dodać kolizje ścian i podłóg, sprawdzić szerokość przejść i miejsce startowe.
- [ ] T09: Przetestować pełną trasę, narożniki i kontakt kapsuły ze ścianami.

Odbiór: wszystkie pomieszczenia są dostępne; brak przenikania przez ściany i wypadania poza mieszkanie.

## M2 — Wygląd i oświetlenie

### US-04 — Umeblowane wnętrze
Jako gracz chcę oglądać spójne, umeblowane mieszkanie.

- [ ] T10: Ustalić paletę materiałów i przygotować modele o uproszczonym realizmie.
- [ ] T11: Dodać wyposażenie i uproszczone kolizje; zachować drożne przejścia.
- [ ] T12: Zapisać źródła i licencje użytych zewnętrznych zasobów oraz wymagane informacje o licencji silnika.

Odbiór: pomieszczenia mają rozpoznawalne funkcje i spójny wygląd, wyposażenie nie blokuje zwiedzania.

### US-05 — Czytelne światło
Jako gracz chcę widzieć wnętrze w przyjemnym, spójnym oświetleniu.

- [ ] T13: Przygotować światło dzienne, lampy i ekspozycję.
- [ ] T14: Sprawdzić LightmapGI dla statycznego wnętrza, przygotować UV2 i oświetlenie obiektów ruchomych, jeśli będą potrzebne.
- [ ] T15: Zmierzyć koszt renderowania pierwszego umeblowanego pokoju; ograniczyć kosztowne cienie i światła.

Odbiór: brak rażących przecieków światła i nieczytelnych pomieszczeń; wynik pomiaru wydajności zapisany wraz z konfiguracją sprzętu.

## M3 — Obsługa i wydanie

### US-06 — Pauza i ustawienia
Jako gracz chcę zatrzymać grę i dostosować sterowanie.

- [ ] T16: Dodać menu Escape: wznowienie, czułość myszy i wyjście.
- [ ] T17: Zapisywać ustawienia lokalnie i poprawnie przywracać kursor oraz sterowanie.

Odbiór: pauza zatrzymuje rozgrywkę; menu pozostaje aktywne; czułość jest zachowana po ponownym uruchomieniu.

### US-07 — Płynne demo
Jako odbiorca chcę uruchomić stabilną paczkę dema na Windows.

- [ ] T18: Ustalić pełną konfigurację testową, w tym CPU, RAM i wariant RTX 3060.
- [ ] T19: Profilować eksportowany build przy 1080p na powtarzalnej trasie; zapisać średni FPS, 1% low i wykres czasu klatek.
- [ ] T20: Usunąć wykryte wąskie gardła; proponowany cel to 144 FPS, budżet około 6,94 ms na klatkę.
- [ ] T21: Sprawdzić uruchomienie, całą trasę, pauzę, utratę fokusu i zapis ustawień; przygotować paczkę Windows i instrukcję.

Odbiór: build działa bez edytora; brak blokujących błędów; raport potwierdza osiągniętą wydajność na wskazanym sprzęcie. Płynność oceniana także po skokach czasu klatek, nie wyłącznie średniej FPS.

## M4 — Opcjonalne interakcje

### US-08 — Drzwi i światło
Jako gracz chcę otwierać drzwi i przełączać lampy.

- [ ] T22: Dodać raycast interakcji o ograniczonym zasięgu i podpowiedź klawisza E.
- [ ] T23: Dodać animowane drzwi z kolizją i sprawdzić kontakt z graczem.
- [ ] T24: Dodać przełączane lampy; dla ich wkładu użyć oświetlenia dynamicznego, aby wyłączenie nie pozostawiało wypalonego światła.

Odbiór: interakcje działają tylko w zasięgu i bez przeszkód; zamknięte drzwi blokują przejście; przełączanie lamp daje spójny efekt wizualny.

## Kolejność i zależności

M1 → M2 → M3. M4 po podstawowym demie. Pierwszy eksport w M1, pierwszy pomiar wydajności w M2. Układ i skala mieszkania powinny być sprawdzone przed pracą nad szczegółowymi modelami.
