# Task Management API

A simple JSON API built with Ruby on Rails to manage tasks.

## Features

- Create a task (`POST /tasks`)
- List all tasks (`GET /tasks`)
- Mark a task as completed (`PATCH /tasks/:id/complete`)

## Technologies

- Ruby on Rails (API mode)
- SQLite (default) or PostgreSQL
- RSpec for testing
- JSON responses

## Setup

```bash
git clone https://github.com/rbowen006/task-api.git
cd task-api
bundle install
rails db:create db:migrate
