# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Opinionated bootstrap tool for quickly creating new Google ADK (Agent Development Kit) projects. The main deliverable is `bootstrap.sh` — a shell script that scaffolds a new ADK project.

## Requirements

- python3
- uv (Python package/project manager)

## Architecture

The bootstrap script (`bootstrap.sh`) should:
1. Prompt for a project name
2. Create a project directory
3. Set up a uv project with a virtual environment
4. Install the `google-adk` package
