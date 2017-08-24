#!/bin/bash
for f in /app/ddl/*.sql /app/ddl/*/*.sql; do
    psql -d django_db -U postgres -f $f
done
