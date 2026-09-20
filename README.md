# TicketSeller iOS

TicketSeller is a native iOS portfolio project that explores a unified ticket-discovery experience for cinema, concerts, theatre, sports and other live events. It combines live public catalog data with a local cinema-purchase demo to demonstrate common ticketing flows without handling real payments or issuing real tickets.

## What it demonstrates

- Browse movie categories, movie details and cinema-oriented ticket flows.
- Browse live events by country through the Ticketmaster Discovery API.
- Explore live-event classifications.
- Select a movie showtime, ticket quantity and seats from a local seat map.
- Complete a simulated checkout with local payment-method and purchase data.
- Review a local purchase history and account experience.

## Data sources and scope

| Area | Source | Current scope |
| --- | --- | --- |
| Live events and classifications | Ticketmaster Discovery API | Live discovery data only. Direct Ticketmaster checkout is a future integration, not implemented today. |
| Movie catalogue and details | The Movie Database (TMDB) API | Live catalogue data used to enrich the cinema demo. |
| Cinema showtimes, seat map, payment methods, purchase receipt and account data | Bundled JSON resources | Local demo data only. No cinema backend, payment processor, card storage or real ticket issuance is involved. |

This boundary is intentional: the project can demonstrate client-side state, navigation, validation and user experience without representing a real payment or ticketing system.

## Technical overview

- **Language and UI:** Swift 5, SwiftUI and Apple Observation (`@Observable`).
- **Minimum platform:** iOS 18.
- **Architecture:** feature-oriented MVVM with provider protocols and constructor dependency injection for client-facing view models.
- **Networking:** `URLSession`, typed request models, DTO decoding, error mapping and actor-backed API clients.
- **Concurrency:** `async` / `await`, with existing Combine publishers bridged where appropriate.
- **Navigation:** `NavigationStack`, environment-based navigation objects and full-screen feature presentation.
- **Persistence and demo resources:** SwiftData app container plus bundled JSON fixtures for deterministic cinema flows.
- **Testing:** XCTest with a provider mock for movie-list behavior.

## Project structure

```text
TicketSeller-iOS/
├── App/                 # App entry point
├── Features/            # SwiftUI screens and view models by user flow
│   ├── Events/          # Ticketmaster event discovery
│   ├── MovieTickets/    # Cinema selection, seats and simulated checkout
│   ├── Account/         # Account and login/register demo
│   └── Purchases/       # Local purchase history
├── Networking/          # API clients, request layer, DTOs and entities
├── Navigation/          # Navigation state and paths
├── Persistence/         # Local repositories and models
├── Resources/           # Local cinema, account and payment fixtures
├── System/              # Localization, environment and assets
└── TicketSeller-iOSTests/
```

## Run locally

1. Open `TicketSeller-iOS/TicketSeller-iOS.xcodeproj` in a recent version of Xcode that supports iOS 18.
2. Select the `TicketSeller-iOS` scheme and an iOS simulator or device.
3. Build and run.

Live event and movie-catalog calls require valid Ticketmaster and TMDB credentials. The app reads development configuration through `System/Env/Env.plist`.

## Security note

Do not commit API keys, bearer tokens or production credentials. Before publishing or sharing the repository, move configuration to an ignored local file or another secure configuration mechanism, rotate any credentials that were previously committed, and provide only a redacted example configuration.

## Roadmap

- Add country and locale selection to event discovery.
- Add event detail and a safe handoff to the official ticket provider for a real purchase journey.
- Replace local cinema fixtures with a dedicated demo backend when a server-side contract is available.
- Expand XCTest coverage for event discovery, checkout validation and navigation state.
- Improve accessibility, loading and error states across ticketing flows.

## Disclaimer

TicketSeller is an independently created learning and portfolio project. Ticketmaster and TMDB are third-party services; their names and data remain the property of their respective owners. The application does not process real payments or issue tickets.

