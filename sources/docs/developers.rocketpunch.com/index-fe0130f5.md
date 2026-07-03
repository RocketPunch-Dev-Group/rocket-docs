# Source: https://developers.rocketpunch.com/?lang=en

Invited Builder Beta

# For builders 
Rocketpunch Open API

Connect recruiting, event, and company data with ease. One App Key lets you build next-generation builder products on Rocketpunch data.

[Get an App Key](https://developers.rocketpunch.com/apps/new) [View API Docs ↗](https://developers.rocketpunch.com/docs/index.html?lang=en 'Opens in a new tab')

**11** Supported languages

**170K+** Company profiles indexed

**99.95%** Availability SLA

example.js

// Search AI jobs with your App Key
const res = await fetch(
 "https://openapi.rocketpunch.com/api/v1/jobs?keyword=AI",
 { headers: { "X-RP-API-Key": "rp\_app\_\*\*\*\*\*\*\*\*" } },
);

const { items } = await res.json();

Why Rocketpunch Open API

## An interface builders love

Builder-friendly by design. Issue, call, and monitor in one console.

⚡

### Issued in a minute

Pick an app name and purpose and get credentials instantly. No separate approval.

🔑

### OAuth 2.0 compatible

Register a redirect URI for user-consent data access in one step.

🌐

### Multilingual support

Profile and job data in 11 languages including Korean, in a consistent schema.

How it works

## Get started in 3 steps

The fastest onboarding for the fastest builders.

1

### Register an app

Enter app name, description, and callback URI to get a key pair instantly.

2

### Check the API docs

Build auth headers with your key and try calls with sample code right away.

3

### Ship your product

Share your builder product with the Rocketpunch community with live usage monitoring.

[Get your App Key now →](https://developers.rocketpunch.com/apps/new)