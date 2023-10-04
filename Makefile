crcon:
	docker run --name postgres16 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -p 5433:5432 -d postgres:16-alpine
rmcon:
	docker stop postgres16
	docker rm postgres16
createdb:
	docker exec -it postgres16 createdb --username=root --owner=root bank
dropdb:
	docker exec -it postgres16 dropdb bank
migrateup:
	migrate -path db/migration -database "postgres://root:secret@localhost:5433/bank?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgres://root:secret@localhost:5433/bank?sslmode=disable" -verbose down
sqlc:
	docker run --rm -v $(pwd):/src -w /src sqlc/sqlc generate
.PHONY: crcon rmcon postres createdb dropdb migrateup migratedown sqlc