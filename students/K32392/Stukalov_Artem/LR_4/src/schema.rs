// @generated automatically by Diesel CLI.

diesel::table! {
    meetings (id) {
        id -> Int4,
        title -> Varchar,
        invite_text -> Varchar,
        start_at -> Timestamp,
        peer_id -> Int4,
    }
}
