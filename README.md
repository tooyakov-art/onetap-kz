# OneTap.kz

> **PRIVATE AND PROPRIETARY.** This repository contains confidential source
> code. No permission to copy, distribute, disclose, sublicense, publish, or
> use it is granted by access to the repository.

Flutter beta for bars and restaurants to place one combined order with several
suppliers. The client app keeps quantities while switching between suppliers,
splits the shared cart by company, and shows delivery statuses. The supplier
mode contains incoming requests and warehouse-oriented order details.

## Current beta

- native mobile-first Flutter interface for iOS and Android;
- Kazakhstan W&S, Coca-Cola, and PepsiCo catalogs in one visual system;
- exact KWS Bushmills volumes and prices from the supplied price list;
- quantity controls, shared cart, delivery date, comments, and one-tap submit;
- no in-app payment; invoices are handled separately or through WhatsApp;
- app identifier: `kz.onetap.app`;
- version: `0.1.0+1`.

## Verification

```bash
flutter pub get
dart format --output=none --set-exit-if-changed lib test
flutter analyze --fatal-infos
flutter test
flutter build web --release
```

TestFlight setup is documented in [TESTFLIGHT.md](TESTFLIGHT.md).

## Ownership and permitted use

Copyright © 2026 Туяков Диас Мухтарович. All rights reserved.

The project is not open source. Use is permitted only under a separate written
agreement signed by the copyright owner. Repository access, a clone, a build,
or a test invitation does not transfer source-code ownership or exclusive
rights. See [LICENSE](LICENSE), [COPYRIGHT.md](COPYRIGHT.md), and
[THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
