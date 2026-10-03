# Deployment

## Frontend

Vite builds to `frontend/dist`. `frontend/.openai/hosting.json` declares the static output. The hosted application supports samples, local TXT analysis, adapter inspection, simulation and export without the Python service. New hosted Sites start private.

Set `VITE_API_BASE_URL` before building for a shared backend, or configure it in the app's Settings. The latter is a device-local preference.

## Backend

`render.yaml` prepares a Python web service with root directory `backend`:

```text
Build: pip install -r requirements.txt
Start: uvicorn app.main:app --host 0.0.0.0 --port $PORT
Health: /health
Data: backend/data (ephemeral on the free service)
```

The blueprint uses free hosting for a disposable demonstration. SQLite accounts and document history reset when the service restarts or redeploys. Free hosting may sleep when idle; the first request can take longer. Durable accounts/history require a separately approved paid service with persistent storage.

Connect the hosting account, select the reviewed GitHub branch and configure `ALLOWED_ORIGINS` with the literal frontend origin. `FINSPARK_DEMO_MODE=true` enables the optional `/api/auth/demo-session` endpoint: it creates a separate identity and a two-hour token for each demo session, with a 1,000-session capacity bound. It defaults to disabled locally. The demo frontend is built with `VITE_DEMO_MODE=true` and `VITE_API_BASE_URL` set to the verified backend URL. Each session's history is isolated; use fictional documents. Configure SMTP secrets for normal account creation. `HF_TOKEN` is optional. Secrets belong in hosting settings, never Git.

After hosting succeeds, check `/health`, connect the frontend, create a fictional test account and verify document upload plus simulation. A frontend URL alone does not establish a live Python service.

## Release checks

Run the frontend build and backend tests, inspect desktop/mobile controls, publish the matching build, then verify the provider reports success. Backend storage persistence must be verified separately. Rollback uses a previous frontend version and matching backend revision while preserving the data disk.
