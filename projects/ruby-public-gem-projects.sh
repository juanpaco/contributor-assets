set -e

source ./projects/ruby-event-store-projects.sh

ruby_active_projects=(
  "async-invocation"
  "attribute"
  "casing"
  "clock"
  "collection"
  "command-line-component-generator"
  "component-host"
  "configure"
  "consumer"
  "consumer-postgres"
  "dependency"
  "diagnostics-sample"
  "entity-cache"
  "entity-projection"
  "entity-snapshot-postgres"
  "entity-store"
  "eventide-postgres"
  "identifier-uuid"
  "initializer"
  "invocation"
  "log"
  "message-db"
  "message-store"
  "message-store-postgres"
  "message-store-postgres-database"
  "messaging"
  "messaging-postgres"
  "mimic"
  "poll"
  "reflect"
  "retry"
  "schema"
  "set-attributes"
  "settings"
  "subst-attr"
  "telemetry"
  "transform"
  "try"
  "validate"
  "view-data-commands"
  "view-data-pg"
  "virtual"
)

ruby_public_gem_projects=(
  "${ruby_active_projects[@]}"
  "${ruby_event_store_projects[@]}"
)
