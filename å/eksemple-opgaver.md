Ja – der er rigtig mange oplagte næste skridt, og dit nuværende scope er faktisk et perfekt fundament. Nedenfor har jeg struktureret det langsigtet, men stadig realistisk for Azure / Entra ID og IT-support, så det er nemt at forklare til både IT og ledelse.

Dit nuværende scope (helt rigtigt valgt)

Det du allerede har valgt, er low-risk, high-value:

Tilføj / fjern brugere i grupper

Liste gruppemedlemmer

Simpel IT-administration via scripts

👉 Det er ideelt som proof-of-concept for AI-agenter i IT.

Naturlige udvidelser (uden ekstra licenser)

Disse kan stadig køre i en gratis Entra ID-tenant og er meget realistiske næste skridt:

1. Brugerhåndtering

Opret / deaktiver brugere

Nulstil passwords (hvis tilladt)

Opdatér basis-attributter (titel, afdeling, manager)

Eksempel:

“Onboard Anna som konsulent i Marketing”

2. Applikationsadgang (SSO)

Tilføj / fjern brugere i Enterprise Applications

Liste hvem der har adgang til en given app

Validere om adgang allerede findes

Eksempel:

“Giv Lars adgang til Jira og Confluence”

3. Rettigheds- og adgangsoverblik

Hvem har adgang til hvad?

Hvilke grupper giver adgang til en app?

Find forældede eller overflødige gruppemedlemskaber

Eksempel:

“Hvem har adgang til økonomisystemet?”

4. Standardiserede IT-support flows

Automatisér kendte runbooks:

“Ny medarbejder”

“Afdeling skifter”

“Offboarding”

Med AI som:

Oversætter tekst → handling

Tjekker preconditions

Foreslår ændringer (PR-review som I allerede har)

Udvidelser der kræver lidt mere (men er meget værdifulde)

Disse er meget interessante langsigtet, men kræver enten mere modenhed eller licenser.

5. Conditional Access & sikkerhed (Entra P1)

Opret/ændr Conditional Access policies

Analysér hvorfor adgang blev blokeret

Foreslå sikrere politikker

Eksempel:

“Hvorfor kan Peter ikke logge ind fra sin private laptop?”

6. Privileged Identity Management (Entra P2)

AI foreslår midlertidige admin-rettigheder

Starter PIM-requests

Dokumenterer hvorfor adgang blev givet

Eksempel:

“Giv midlertidig admin-adgang i 2 timer til fejlsøgning”

Azure (uden for Entra – hvis I vil)

Hvis I senere tilknytter en Azure subscription:

7. Azure RBAC

Tildel Azure roller (Reader, Contributor, etc.)

Fjern forældede rettigheder

Validér least-privilege

8. Compliance & governance

Find users uden MFA

Rapportér risici

Forbered access reviews

Hvor AI-agenten virkelig skinner

Det vigtige er ikke bare hvad den gør, men hvordan:

Oversætter ustruktureret tekst → sikre handlinger

Finder eksisterende grupper/apps i stedet for at gætte

Stopper selv ved tvivl og beder om menneskelig review

Dokumenterer alt automatisk

Dit GitHub PR-flow er helt perfekt til dette.

Overblik: Fra nu → fremtid
Fase	Funktioner
Nu (PoC)	Groups, members, listing
Næste	Users, apps, onboarding
Avanceret	Security, CA, PIM
Modent	Azure RBAC, compliance
Kort statement du kan bruge overfor IT

Projektet starter med simple og sikre Entra ID-opgaver, men kan på sigt udvides til brugerhåndtering, applikationsadgang, onboarding/offboarding og sikkerhedsrelaterede workflows i Azure.

Hvis du vil, kan jeg næste gang:

Lave en “roadmap slide” (1-side) til IT/ledelse

Mappe konkrete Graph API-permissions til hver fase

Hjælpe med at definere hårde stop-regler for AI-agenten (hvornår den ikke må handle)

Sig bare til 👍