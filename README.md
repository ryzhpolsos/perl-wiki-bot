# Perl Wiki Bot

A simple bot for fetching information about famous people from Wikipedia.

## Installation

Run this command to install required modules:
```
cpanm HTTP::Tiny JSON Dotenv
```

## Running
1. Install dependencies (refer to the Installation section)
2. Create a file named `.env` with following content: `TOKEN='<your_token_here>'` (replace `<your_token_here>` with an actual token from BotFather)
3. `perl main.pl`
