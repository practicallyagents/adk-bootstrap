#!/usr/bin/env bash
set -euo pipefail

# Check that uv is installed
if ! command -v uv &> /dev/null; then
  echo "Error: 'uv' is not installed. Install it from https://docs.astral.sh/uv/" >&2
  exit 1
fi

# Prompt for project name
read -rp "Enter project name: " project_name

if [[ -z "$project_name" ]]; then
  echo "Error: project name cannot be empty." >&2
  exit 1
fi

# Scaffold the project
mkdir "$project_name"
cd "$project_name"

uv init
uv venv
uv add google-adk

read -rp "Enter agent name [agent]: " agent_name
agent_name="${agent_name:-agent}"

# Scaffold the agent package using ADK's built-in command
uv run adk create "$agent_name"

# Populate README with run instructions
cat > README.md <<EOF
# $project_name

Google ADK project bootstrapped with [adk-bootstrap](https://github.com/practicallyagents/adk-bootstrap).

## Prerequisites

- Python 3
- [uv](https://docs.astral.sh/uv/)

## Setup

Configure your API key in \`$agent_name/.env\`.

## Running

Run the agent interactively in the CLI:

\`\`\`sh
make run
\`\`\`

Launch the dev web UI on port 8000:

\`\`\`sh
make web
\`\`\`
EOF

# Generate Makefile with convenience targets
cat > Makefile <<EOF
.PHONY: run web

run:
	uv run adk run $agent_name

web:
	uv run adk web --port 8000
EOF

cd "$agent_name"
mkdir tools
mkdir agents

echo ""
echo "Project '$project_name' created successfully!"
echo ""
echo "Next steps:"
echo "  cd $project_name"
echo "  # Set your API key in $agent_name/.env"
echo "  make run   # interactive CLI"
echo "  make web   # web UI on port 8000"
