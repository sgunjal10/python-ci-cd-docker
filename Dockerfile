# ── Stage 1: builder ──────────────────────────────────────────────────────────
# Installs all dependencies (including test tools) in an isolated layer.
# Nothing from this stage leaks into the final image.
FROM python:3.10-slim AS builder

WORKDIR /app

# Copy and install dependencies first (maximises layer cache reuse)
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# ── Stage 2: final ────────────────────────────────────────────────────────────
# Lean production image — only the app code + pre-built packages.
FROM python:3.10-slim AS final

WORKDIR /app

# Pull installed packages from builder stage only
COPY --from=builder /install /usr/local

# Copy application source
COPY . .

# Default command: run the test suite
CMD ["pytest", "--tb=short"]