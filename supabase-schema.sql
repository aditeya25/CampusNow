-- CampusNow shared demo data schema.
-- Review and run this in Supabase SQL Editor; this file is not executed by the app.
-- These policies intentionally allow anonymous browser reads/inserts for the demo.
-- Do not use this policy model for sensitive or production data without abuse controls.

create table if not exists public.campus_updates (
    id text primary key,
    type text not null check (type in ('Holiday', 'Exam / Internal Assessment', 'Lab Closed', 'Maintenance', 'College Event', 'Timing Change', 'Other Campus Update')),
    date date not null,
    time_text text,
    title text not null,
    details text,
    reason text,
    note text,
    location text,
    lab_id text,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create table if not exists public.campus_update_reports (
    id text primary key,
    update_id text not null references public.campus_updates(id) on delete cascade,
    vote text not null check (vote in ('support', 'conflict')),
    created_at timestamptz not null default now()
);

create table if not exists public.lab_reports (
    id text primary key,
    lab_id text not null,
    status text not null check (status in ('Very Free', 'Free', 'Busy', 'Full', 'Exam in Progress', 'Closed')),
    free_count integer,
    note text,
    created_at timestamptz not null default now()
);

create table if not exists public.lab_confirmations (
    id text primary key,
    lab_id text not null,
    still_accurate boolean not null,
    created_at timestamptz not null default now()
);

create table if not exists public.printout_reports (
    id text primary key,
    status text not null check (status in ('Free', 'Short Queue', 'Long Queue')),
    people integer,
    lunch text check (lunch in ('unknown', 'available', 'unavailable')),
    note text,
    created_at timestamptz not null default now()
);

create table if not exists public.printout_confirmations (
    id text primary key,
    still_accurate boolean not null,
    created_at timestamptz not null default now()
);

alter table public.campus_updates enable row level security;
alter table public.campus_update_reports enable row level security;
alter table public.lab_reports enable row level security;
alter table public.lab_confirmations enable row level security;
alter table public.printout_reports enable row level security;
alter table public.printout_confirmations enable row level security;

create policy "CampusNow updates are publicly readable"
on public.campus_updates for select to anon, authenticated using (true);
create policy "CampusNow updates accept anonymous demo inserts"
on public.campus_updates for insert to anon, authenticated with check (true);

create policy "CampusNow update reports are publicly readable"
on public.campus_update_reports for select to anon, authenticated using (true);
create policy "CampusNow update reports accept anonymous demo inserts"
on public.campus_update_reports for insert to anon, authenticated with check (true);

create policy "CampusNow lab reports are publicly readable"
on public.lab_reports for select to anon, authenticated using (true);
create policy "CampusNow lab reports accept anonymous demo inserts"
on public.lab_reports for insert to anon, authenticated with check (true);

create policy "CampusNow lab confirmations are publicly readable"
on public.lab_confirmations for select to anon, authenticated using (true);
create policy "CampusNow lab confirmations accept anonymous demo inserts"
on public.lab_confirmations for insert to anon, authenticated with check (true);

create policy "CampusNow printout reports are publicly readable"
on public.printout_reports for select to anon, authenticated using (true);
create policy "CampusNow printout reports accept anonymous demo inserts"
on public.printout_reports for insert to anon, authenticated with check (true);

create policy "CampusNow printout confirmations are publicly readable"
on public.printout_confirmations for select to anon, authenticated using (true);
create policy "CampusNow printout confirmations accept anonymous demo inserts"
on public.printout_confirmations for insert to anon, authenticated with check (true);
