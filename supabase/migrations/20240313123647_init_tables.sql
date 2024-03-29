create type "public"."musician_event_attendance" as enum ('Sí', 'No', 'Pendiente', 'No convocado');

create table "public"."event" (
    "id" bigint generated by default as identity not null,
    "display_name" text not null,
    "date" date not null
);


alter table "public"."event" enable row level security;

create table "public"."instrument" (
    "id" text not null default ''::text,
    "display_name" text not null,
    "order" numeric
);


alter table "public"."instrument" enable row level security;

create table "public"."musician" (
    "id" text not null,
    "display_name" text not null,
    "email" text,
    "phone_number" text,
    "points" smallint,
    "birth_date" date,
    "instrument" text,
    "auth_id" uuid
);


alter table "public"."musician" enable row level security;

create table "public"."musician_event" (
    "musician_id" text not null,
    "event_id" bigint not null,
    "attendance" musician_event_attendance not null
);


alter table "public"."musician_event" enable row level security;

create table "public"."musician_selection" (
    "musician_id" text not null,
    "selection_id" bigint not null,
    "selected" boolean,
    "instrument" text not null
);


alter table "public"."musician_selection" enable row level security;

create table "public"."selection" (
    "id" bigint generated by default as identity not null,
    "display_name" text not null,
    "date" date not null,
    "time" time without time zone not null,
    "total_price" numeric not null,
    "num_musicians" bigint not null,
    "other_expenses" numeric,
    "repertoire" text,
    "dress_code" text,
    "comments" text,
    "price_per_musician" numeric generated always as (((total_price - other_expenses) / (num_musicians)::numeric)) stored
);


alter table "public"."selection" enable row level security;

CREATE UNIQUE INDEX event_pkey ON public.event USING btree (id);

CREATE UNIQUE INDEX musician_event_pkey ON public.musician_event USING btree (musician_id, event_id);

CREATE UNIQUE INDEX musician_pkey ON public.instrument USING btree (id);

CREATE UNIQUE INDEX musician_pkey1 ON public.musician USING btree (id);

CREATE UNIQUE INDEX musician_selection_pkey ON public.musician_selection USING btree (musician_id, selection_id);

CREATE UNIQUE INDEX selection_pkey ON public.selection USING btree (id);

alter table "public"."event" add constraint "event_pkey" PRIMARY KEY using index "event_pkey";

alter table "public"."instrument" add constraint "musician_pkey" PRIMARY KEY using index "musician_pkey";

alter table "public"."musician" add constraint "musician_pkey1" PRIMARY KEY using index "musician_pkey1";

alter table "public"."musician_event" add constraint "musician_event_pkey" PRIMARY KEY using index "musician_event_pkey";

alter table "public"."musician_selection" add constraint "musician_selection_pkey" PRIMARY KEY using index "musician_selection_pkey";

alter table "public"."selection" add constraint "selection_pkey" PRIMARY KEY using index "selection_pkey";

alter table "public"."musician" add constraint "musician_points_check" CHECK ((points = ANY (ARRAY[1, 2, 3, 4]))) not valid;

alter table "public"."musician" validate constraint "musician_points_check";

alter table "public"."musician" add constraint "public_musician_auth-id_fkey" FOREIGN KEY (auth_id) REFERENCES auth.users(id) not valid;

alter table "public"."musician" validate constraint "public_musician_auth-id_fkey";

alter table "public"."musician" add constraint "public_musician_instrument_fkey" FOREIGN KEY (instrument) REFERENCES instrument(id) not valid;

alter table "public"."musician" validate constraint "public_musician_instrument_fkey";

alter table "public"."musician_event" add constraint "public_musician-event_event-id_fkey" FOREIGN KEY (event_id) REFERENCES event(id) not valid;

alter table "public"."musician_event" validate constraint "public_musician-event_event-id_fkey";

alter table "public"."musician_event" add constraint "public_musician-event_musician-id_fkey" FOREIGN KEY (musician_id) REFERENCES musician(id) not valid;

alter table "public"."musician_event" validate constraint "public_musician-event_musician-id_fkey";

alter table "public"."musician_selection" add constraint "public_musician-selection_instrument_fkey" FOREIGN KEY (instrument) REFERENCES instrument(id) not valid;

alter table "public"."musician_selection" validate constraint "public_musician-selection_instrument_fkey";

alter table "public"."musician_selection" add constraint "public_musician-selection_musician-id_fkey" FOREIGN KEY (musician_id) REFERENCES musician(id) not valid;

alter table "public"."musician_selection" validate constraint "public_musician-selection_musician-id_fkey";

alter table "public"."musician_selection" add constraint "public_musician-selection_selection-id_fkey" FOREIGN KEY (selection_id) REFERENCES selection(id) not valid;

alter table "public"."musician_selection" validate constraint "public_musician-selection_selection-id_fkey";

grant delete on table "public"."event" to "anon";

grant insert on table "public"."event" to "anon";

grant references on table "public"."event" to "anon";

grant select on table "public"."event" to "anon";

grant trigger on table "public"."event" to "anon";

grant truncate on table "public"."event" to "anon";

grant update on table "public"."event" to "anon";

grant delete on table "public"."event" to "authenticated";

grant insert on table "public"."event" to "authenticated";

grant references on table "public"."event" to "authenticated";

grant select on table "public"."event" to "authenticated";

grant trigger on table "public"."event" to "authenticated";

grant truncate on table "public"."event" to "authenticated";

grant update on table "public"."event" to "authenticated";

grant delete on table "public"."event" to "service_role";

grant insert on table "public"."event" to "service_role";

grant references on table "public"."event" to "service_role";

grant select on table "public"."event" to "service_role";

grant trigger on table "public"."event" to "service_role";

grant truncate on table "public"."event" to "service_role";

grant update on table "public"."event" to "service_role";

grant delete on table "public"."instrument" to "anon";

grant insert on table "public"."instrument" to "anon";

grant references on table "public"."instrument" to "anon";

grant select on table "public"."instrument" to "anon";

grant trigger on table "public"."instrument" to "anon";

grant truncate on table "public"."instrument" to "anon";

grant update on table "public"."instrument" to "anon";

grant delete on table "public"."instrument" to "authenticated";

grant insert on table "public"."instrument" to "authenticated";

grant references on table "public"."instrument" to "authenticated";

grant select on table "public"."instrument" to "authenticated";

grant trigger on table "public"."instrument" to "authenticated";

grant truncate on table "public"."instrument" to "authenticated";

grant update on table "public"."instrument" to "authenticated";

grant delete on table "public"."instrument" to "service_role";

grant insert on table "public"."instrument" to "service_role";

grant references on table "public"."instrument" to "service_role";

grant select on table "public"."instrument" to "service_role";

grant trigger on table "public"."instrument" to "service_role";

grant truncate on table "public"."instrument" to "service_role";

grant update on table "public"."instrument" to "service_role";

grant delete on table "public"."musician" to "anon";

grant insert on table "public"."musician" to "anon";

grant references on table "public"."musician" to "anon";

grant select on table "public"."musician" to "anon";

grant trigger on table "public"."musician" to "anon";

grant truncate on table "public"."musician" to "anon";

grant update on table "public"."musician" to "anon";

grant delete on table "public"."musician" to "authenticated";

grant insert on table "public"."musician" to "authenticated";

grant references on table "public"."musician" to "authenticated";

grant select on table "public"."musician" to "authenticated";

grant trigger on table "public"."musician" to "authenticated";

grant truncate on table "public"."musician" to "authenticated";

grant update on table "public"."musician" to "authenticated";

grant delete on table "public"."musician" to "service_role";

grant insert on table "public"."musician" to "service_role";

grant references on table "public"."musician" to "service_role";

grant select on table "public"."musician" to "service_role";

grant trigger on table "public"."musician" to "service_role";

grant truncate on table "public"."musician" to "service_role";

grant update on table "public"."musician" to "service_role";

grant delete on table "public"."musician_event" to "anon";

grant insert on table "public"."musician_event" to "anon";

grant references on table "public"."musician_event" to "anon";

grant select on table "public"."musician_event" to "anon";

grant trigger on table "public"."musician_event" to "anon";

grant truncate on table "public"."musician_event" to "anon";

grant update on table "public"."musician_event" to "anon";

grant delete on table "public"."musician_event" to "authenticated";

grant insert on table "public"."musician_event" to "authenticated";

grant references on table "public"."musician_event" to "authenticated";

grant select on table "public"."musician_event" to "authenticated";

grant trigger on table "public"."musician_event" to "authenticated";

grant truncate on table "public"."musician_event" to "authenticated";

grant update on table "public"."musician_event" to "authenticated";

grant delete on table "public"."musician_event" to "service_role";

grant insert on table "public"."musician_event" to "service_role";

grant references on table "public"."musician_event" to "service_role";

grant select on table "public"."musician_event" to "service_role";

grant trigger on table "public"."musician_event" to "service_role";

grant truncate on table "public"."musician_event" to "service_role";

grant update on table "public"."musician_event" to "service_role";

grant delete on table "public"."musician_selection" to "anon";

grant insert on table "public"."musician_selection" to "anon";

grant references on table "public"."musician_selection" to "anon";

grant select on table "public"."musician_selection" to "anon";

grant trigger on table "public"."musician_selection" to "anon";

grant truncate on table "public"."musician_selection" to "anon";

grant update on table "public"."musician_selection" to "anon";

grant delete on table "public"."musician_selection" to "authenticated";

grant insert on table "public"."musician_selection" to "authenticated";

grant references on table "public"."musician_selection" to "authenticated";

grant select on table "public"."musician_selection" to "authenticated";

grant trigger on table "public"."musician_selection" to "authenticated";

grant truncate on table "public"."musician_selection" to "authenticated";

grant update on table "public"."musician_selection" to "authenticated";

grant delete on table "public"."musician_selection" to "service_role";

grant insert on table "public"."musician_selection" to "service_role";

grant references on table "public"."musician_selection" to "service_role";

grant select on table "public"."musician_selection" to "service_role";

grant trigger on table "public"."musician_selection" to "service_role";

grant truncate on table "public"."musician_selection" to "service_role";

grant update on table "public"."musician_selection" to "service_role";

grant delete on table "public"."selection" to "anon";

grant insert on table "public"."selection" to "anon";

grant references on table "public"."selection" to "anon";

grant select on table "public"."selection" to "anon";

grant trigger on table "public"."selection" to "anon";

grant truncate on table "public"."selection" to "anon";

grant update on table "public"."selection" to "anon";

grant delete on table "public"."selection" to "authenticated";

grant insert on table "public"."selection" to "authenticated";

grant references on table "public"."selection" to "authenticated";

grant select on table "public"."selection" to "authenticated";

grant trigger on table "public"."selection" to "authenticated";

grant truncate on table "public"."selection" to "authenticated";

grant update on table "public"."selection" to "authenticated";

grant delete on table "public"."selection" to "service_role";

grant insert on table "public"."selection" to "service_role";

grant references on table "public"."selection" to "service_role";

grant select on table "public"."selection" to "service_role";

grant trigger on table "public"."selection" to "service_role";

grant truncate on table "public"."selection" to "service_role";

grant update on table "public"."selection" to "service_role";


