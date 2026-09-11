# Historical Event Time Machine

A Dart command-line application that allows users to search for historical events based on a specific date.

## Features

- Search for historical events by month and day
- Simple command-line interface
- `help` command for available commands
- `query` command for searching historical events
- `exit` command to close the application
- API connection for retrieving historical event data
- Terminal colors for better command-line output
- Logging and error handling

## Technologies Used

- Dart
- Dart HTTP package
- Command-line interface (CLI)
- REST API
- Logging

## Project Structure

```text
historical_event_workspace/
│
├── historical_event_api/
│   ├── lib/
│   └── test/
│
├── historical_event_cli/
│   ├── bin/
│   ├── lib/
│   └── test/
│
├── terminal_colors/
│   ├── lib/
│   └── test/
│
├── .gitignore
├── pubspec.yaml
├── pubspec.lock
└── README.md