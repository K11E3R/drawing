# Use the official Rust image as a base
FROM rust:latest AS builder

# Create a new directory for the application
WORKDIR /usr/src/app

# Copy the Cargo.toml file
COPY Cargo.toml ./

# This will create a dummy main.rs, to create the Cargo.lock
RUN cargo build --release

# Copy the source code
COPY ./src ./src

# Build the application
RUN cargo install --path .

# Use a base image with a newer version of glibc
FROM ubuntu:24.04

# Copy the built binary from the builder stage
COPY --from=builder /usr/local/cargo/bin/drawing /usr/local/bin/drawing

# Set the entrypoint for the container
ENTRYPOINT ["drawing"]
