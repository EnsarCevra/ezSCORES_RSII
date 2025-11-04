# NaTanjir_RS2
Seminarski rad iz predmeta Razvoj softvera 2 na Fakultetu informacijskih tehnologija u Mostaru.

---

## 📌 Upute za pokretanje
### Backend (env)
1. Extractovati: `fit-build-2025-11-03 - env`
2. Postaviti `.env` fajl u: `ezSCORES_RSII\ezSCORES`
3. Otvoriti `ezSCORES_RSII\ezSCORES` u terminalu i pokrenuti komandu:
docker-compose up --build
### Desktop aplikacija
1. Extractovati: `fit-build-2025-11-04 - desktop`
2. Pokrenuti `ezSCORES.exe` koji se nalazi u folderu `Release`
3. Unijeti desktop kredencijale koji se mogu pronaći u ovom README-u

### Mobilna aplikacija
1. Prije pokretanja, provjeriti da aplikacija već ne postoji na Android emulatoru; ukoliko postoji, deinstalirati je 
2. Extractovati: `fit-build-2025-11-04 - mobile`
3. Na pokrenuti emulator prenijeti fajl `app-release.apk` iz foldera `flutter-apk` i sačekati instalaciju
4. Pokrenuti aplikaciju i unijeti mobilne kredencijale koji se mogu pronaći u ovom README-u

---

## 🔑 Kredencijali za prijavu

### Mobilna aplikacija

**Manager 1**
- Korisničko ime: `elminhadziosmanovic`
- Lozinka: `testtest`

**Manager 2**
- Korisničko ime: `nerminkaric`
- Lozinka: `testtest`

**Spectator**
- Korisničko ime: `selmamuratovic`
- Lozinka: `testtest`

### Desktop aplikacija

**Admin**
- Korisničko ime: `cevraensar`
- Lozinka: `testtest`

**Organizator 1**
- Korisničko ime: `mirzakovacevic`
- Lozinka: `testtest`

**Organizator 2**
- Korisničko ime: `ensarcevra`
- Lozinka: `testtest`

---

## 💳 PayPal Kredencijali
- Email: `sb-nd47ol46242435@personal.example.com`
- Lozinka: `PF+^xp18`

---

## 🐇 RabbitMQ
- RabbitMQ je korišten za slanje mailova menadžerima ukoliko admin/organizator promijeni prihvati/odbije njihovu prijavu na takmičenje (za testiranje kreirati novi manager nalog sa pravim emailom kako bi poruka stigla na ispravnu adresu)
