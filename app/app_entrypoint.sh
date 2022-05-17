#!/usr/bin/env bash

echo "Start flask dev server"
exec gunicorn --bind 0.0.0.0:8800 wsgi:app
