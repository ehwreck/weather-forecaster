# 🌤️ Weather Forecast App

A Ruby on Rails application that fetches and displays weather data based on user-provided addresses, using the Google Maps APIs.

## 🧰 System Requirements

- Ruby: 3.4.1
- Rails: 8.0.2

## ⚙️ Local Setup

1. Clone the repository:

```bash
git clone https://github.com/ehwreck/weather-forecaster.git
cd weather-forecaster
```

2. Install dependencies & set up the app:

```bash
bin/setup
```

3. Set up your environment variables:

```bash
cp .env.sample .env
# Then add your Google Maps API key in the .env file
```

## 🗃️ Database

1. Run Migrations

```bash
bin/rails db:migrate
```

2. Seed the Database (Optional)

```bash
bin/rails db:seed
```

## 🧪 Running Tests

```bash
bin/rspec
```

## 🚀 Start the Application Locally

```bash
bin/dev
```

Visit http://localhost:3000 in your browser.

## 🌐 Google Maps API

This app uses the Google Maps Geocoding and Weather APIs. (https://console.cloud.google.com/)

### Steps to enable:

1. Go to the Google Cloud Console.
2. Create a project and enable the following APIs:

- Geocoding API
- Weather API

3. Generate an API key.
4. Add the key to your .env file as:

```env
GOOGLE_MAPS_API_KEY=<placeholder>
```

## ✅ Features

- Address geocoding with Google Maps API
- Weather data fetching with caching on zip code for 30 minutes
- Error handling for invalid addresses
- Clean, Turbo-powered frontend

## 🧠 Notes

- The zip code is extracted from the address to cache weather data.
- Weather responses are cached for 30 minutes using Rails.cache.
- Turbo Streams is used for smooth UI updates.
