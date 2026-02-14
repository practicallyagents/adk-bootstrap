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

read -rp "Enter agent name: " agent_name

# Scaffold the agent package using ADK's built-in command
uv run adk create "$agent_name"

echo ""
echo "Project '$project_name' created successfully!"
echo ""
echo "Next steps:"
echo "  cd $project_name"
echo "  source .venv/bin/activate"
echo "  # Set your API key in $project_name/.env"
echo "  adk run $project_name"
echo "  adk web"
