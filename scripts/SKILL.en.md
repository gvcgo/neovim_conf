---
name: my-workflow-guidelines
description: Global workflow and coding standard customization rules for the current user. Applicable to all interactions, especially development specifications and API documentation maintenance for the inlight-board/backend/go project.
---

# Exclusive Workflow & Development Guidelines (My Workflow Guidelines)

When assisting the current user with development, code review, or architectural planning, you must strictly adhere to the following customized rules. These rules have the highest priority and aim to maintain project consistency, streamline output, and respect the user's absolute control.

## 1. Core Interaction & Planning Behaviors

- **Conversational Planning**: Absolutely do not create any physical plan files (e.g., `plan.md`). All planning, task breakdown, and progress confirmation should be communicated and determined directly through conversation in the current session.
- **No Unauthorized Installations**: Never install any SKILLs or plugins without explicit permission from the user.
- **Mandatory Wait for Confirmation**: When encountering any uncertainty, facing multiple choices, or identifying risks (such as large-scale refactoring or deleting files) in the workflow, you **must stop and wait for explicit confirmation from the user** before proceeding to the next step.
- **Default Communication Language**: Unless explicitly requested otherwise, always use **Chinese** for answers and communication.
- **Restraint and Convergence**: Unless explicitly requested otherwise, think and implement according to the traditions of the existing code in the project. **Do not endlessly expand**, over-engineer, or introduce unnecessary new patterns.

## 2. Code Generation & Modification Conventions

- **Readability First**: Always strive to write code that is easily readable by humans.
- **Regarding Unit Tests**: Unless explicitly requested, **do not** write any unit test files.
- **Regarding Code Comments**: Unless explicitly requested, **do not** write any comments. If the user explicitly asks for comments, the comments **must be written in English**.

## 3. Specific Project Specifications: `inlight-board/backend/go`

When handling tasks related to the `inlight-board/backend/go` project, you must strictly adhere to the following exclusive architecture, code style, and submission process requirements:

- **Style Alignment**: You must pay attention to Go code conventions and style, trying to reference existing code implementations in the same directory or project.
- **Helper Function Layout**: All helper (utility) functions should ideally be placed at the **end** of each code file.
- **Handler Struct Layout**: If a separate struct (request/response struct) needs to be defined for a handler function, **this struct must be placed directly above the corresponding handler function**.
- **Swagger Documentation Specifications**:
  - The documentation directory is located under `inlight-board/backend/go/doc/`.
  - **Main Entry**: `inlight-board/backend/go/doc/api.yaml` is the entry file for the documentation.
  - **Module Mapping**: The names of the remaining `*.yaml` configuration files under `doc/` must **correspond one-to-one** with the folders under `inlight-board/backend/go/src/vibe/api/`. When adding or modifying API interfaces, ensure the documentation is synchronously maintained in the correct YAML file.
- **Code Generation Sync**: Before committing code with git, if there are newly added database Models, you must run the `inlight-board/backend/go/sync-generated` script to generate the related CLI tool code.
- **Code Formatting**: Before committing code with git, you must use the `inlight-board/backend/go/format` script to uniformly format the code.
- **PR and Branch Management**: When the user requests to push code to a remote repository and the corresponding remote branch does not exist, you must use the `gh` command-line tool to create the remote branch and simultaneously create a Pull Request (PR). When creating a PR, you must write the PR title and description in **English**.
- **Code Review Handling**: If requested to modify code based on review information, you must use the `gh` command to fetch the review information from the remote repository before modifying the code accordingly.
