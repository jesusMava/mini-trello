# ProjectFlow
A production-ready project management platform built with Ruby on Rails 8, GraphQL and React. [WIP]

Inspired by Linear, Jira and Notion.

Designed using Modular Monolith Architecture, Vertical Slice and Lightweight DDD.

Release 0.0.1 (Only basic API with GraphQL, Sidekiq, Redis, Event Bus)
## Architecture

Monolito modula
111111111111111111r
Vertical Slice
DDD ligero
Repository Pattern
Use Cases
DTOs
Domain Services
GraphQL
Sidekiq
Redis

### Diagrama de Carpetas
Tasks

Application
    DTO
    UseCases
    Events

Domain
    Services
    Repositories

Infrastructure
    Subscribers

## Tech Stack

| Backend | Frontend   | Infra          |
| ------- | ---------- | -------------- |
| Rails 8 | React      | Docker         |
| GraphQL | TypeScript | PostgreSQL     |
| JWT     | Vite       | Redis          |
| Sidekiq |            | GitHub Actions |

# Sequence Diagram
```mermaid
Mutation --> UseCase

UseCase --> Repository

Repository --> PostgreSQL

UseCase --> Event

Event --> Subscriber

Subscriber --> Sidekiq

Sidekiq --> Redis
```
# How task move works
Mutation
↓
MoveTaskUseCase
↓
PositionManager
↓
Repository
↓
Optimistic Lock
↓
Transaction
↓
TaskMoved Event
↓
Subscriber
↓
Sidekiq
↓
Redis

# Folder Structure

Getting Started

Running Tests

GraphQL API

Authentication

Architecture Decisions

Sequence Diagrams

Future Improvements