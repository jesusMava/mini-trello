up:
	docker compose up --build

down:
	docker compose down

logs:
	docker compose logs -f

backend:
	docker compose exec backend bash

frontend:
	docker compose exec frontend sh

db:
	docker compose exec backend rails db:create db:migrate

migrate:
	docker compose exec backend rails db:migrate

seed:
	docker compose exec backend rails db:seed

test:
	docker compose exec backend bundle exec rspec

sidekiq:
	docker compose logs -f sidekiq

console:
	docker compose exec backend rails console