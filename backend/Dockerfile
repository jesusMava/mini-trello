ARG RUBY_VERSION=3.2.0
FROM docker.io/library/ruby:$RUBY_VERSION-slim

# Instalar dependencias del sistema necesarias para compilar gemas y usar Postgres
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    git \
    libpq-dev \
    libvips \
    libyaml-dev \
    pkg-config \
    curl && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Carpeta de la app dentro del contenedor
WORKDIR /rails

# Configurar variables para DESARROLLO (Instalar todas las gemas)
ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle"

# Copiar archivos de gemas e instalarlas
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Nota: No copiamos todo el código aquí porque tu docker-compose.yml 
# ya mapea tu carpeta local usando: - ./backend:/rails (Volumes)

EXPOSE 3000

# Comando por defecto para arrancar Rails en desarrollo
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
