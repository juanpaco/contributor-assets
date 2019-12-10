set -e

source ./projects/ruby-active-projects.sh
source ./projects/ruby-event-store-projects.sh

ruby_public_gem_projects=(
  "${ruby_active_projects[@]}"
  "${ruby_event_store_projects[@]}"
)
