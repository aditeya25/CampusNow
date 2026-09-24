# CampusNow
A modern campus utility that helps students quickly check lab availability, printout queues, and campus timings.

## Run locally

Open the project through a local HTTP server to enable the PWA manifest, service worker, and offline cache. For example:

```bash
python3 -m http.server 8000
```

Then visit `http://localhost:8000/`. The CampusNow interface remains usable as a frontend demo when offline; cached information is labelled accordingly.

## Optional Supabase sharing

CampusNow can share community updates, lab reports, confirmations, and printout reports between browsers through Supabase while retaining the local/demo fallback.

1. Copy `supabase-config.example.js` to `supabase-config.js`.
2. Set `url` to the public project URL, such as `https://your-project-ref.supabase.co`.
3. Set `anonKey` to the Supabase publishable key (or legacy anon key) from the project API settings.
4. Review and run `supabase-schema.sql` in the Supabase SQL Editor. The application never runs this migration automatically.

Only the project URL and publishable/anon key belong in the browser. Never put a service-role key, database password, or other private credential in `supabase-config.js`, `index.html`, GitHub, or Vercel client-side code. The local config file is ignored by Git. Without it, or while offline, CampusNow continues using its existing local/demo behavior.
