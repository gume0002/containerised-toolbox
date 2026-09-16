# Containerised Toolbox

Gruppemedlemmer: Gustav, Mathilde, Magnus og Oliver.

## Beskrivelse
Projektet består af en nginx-webserver og et shellscript,
der kører i hver sin Docker-container.

Scriptet kalder http://web og registrerer tidspunkt,
HTTP-statuskode og svartid. Det venter fem sekunder mellem
kaldene og fortsætter ved forbindelsesfejl og timeout.

Et kald har en timeout på tre sekunder. Scriptet markerer
HTTP-fejl og svar, der tager mindst ét sekund.
Resultater vises i terminalen og gemmes i /app/checks.log.

## Start
Docker skal være installeret og startet. Port 8080 skal være ledig.

Hent projektet:

    git clone https://github.com/gume0002/containerised-toolbox.git
    cd containerised-toolbox

Start begge services:

    docker compose up --build

Webserveren kan åbnes på http://localhost:8080.
Et privat repository kræver adgang for at kunne klones.

## Filer og services
- checker.sh: Kontrollerer webserveren og logger resultater.
- Dockerfile: Installerer curl og pakker scriptet i en container.
- docker-compose.yaml: Definerer services app og web.
- README.md: Beskriver projektet og kørselsvejledningen.

App kører scriptet. Web kører nginx.
Containerne kommunikerer via servicenavnet web.

## Log og fejltest
Vis loggen fra en anden terminal i projektmappen:

    docker compose exec app cat /app/checks.log

Stop webserveren:

    docker compose stop web

Vent cirka ti sekunder. Nye loglinjer skal vise NEDE,
mens scriptet fortsætter.

Start webserveren igen:

    docker compose start web

Nye loglinjer skal vise OK, når serveren svarer normalt.
Logfilen går tabt, hvis app-containeren fjernes eller erstattes.

## Stop
Tryk Ctrl+C i terminalen, hvor projektet kører. Kør derefter:

    docker compose down

## Arbejdsproces
Projektet blev udviklet lokalt i VS Code og kørt med Docker.
Scriptet blev udvidet med gentagne tjek, logning og fejlhåndtering.
Projektfilerne blev derefter committet med Git og uploadet til GitHub.
