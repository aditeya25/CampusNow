# CampusNow
A modern campus utility that helps students quickly check lab availability, printout queues, and campus timings.

## Run locally

Open the project through a local HTTP server to enable the PWA manifest, service worker, and offline cache. For example:

```bash
python3 -m http.server 8000
```

Then visit `http://localhost:8000/`. The CampusNow interface remains usable as a frontend demo when offline; cached information is labelled accordingly.
