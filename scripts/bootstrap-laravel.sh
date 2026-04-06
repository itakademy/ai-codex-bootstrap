#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./lib/common.sh
source "${SCRIPT_DIR}/lib/common.sh"

TARGET_DIR="${1:-apps/api}"

require_missing_path "$TARGET_DIR"

for tool in composer php; do
  require_command "$tool"
done

info "Bootstrapping Laravel into $TARGET_DIR"

composer create-project laravel/laravel "$TARGET_DIR"

pushd "$TARGET_DIR" >/dev/null
composer require laravel/sail --dev
php artisan sail:install --with=mariadb,redis --no-interaction

mkdir -p tests/Feature

cat <<'EOF' > tests/Feature/HealthCheckTest.php
<?php

namespace Tests\Feature;

use Tests\TestCase;

class HealthCheckTest extends TestCase
{
    public function test_the_application_health_endpoint_is_available(): void
    {
        $response = $this->get('/up');

        $response->assertOk();
    }
}
EOF
popd >/dev/null

cat <<EOF

Laravel app created in $TARGET_DIR
Next steps:
  1. cd $TARGET_DIR
  2. ./vendor/bin/sail up -d
  3. ./vendor/bin/sail artisan migrate
  4. php artisan test
EOF
