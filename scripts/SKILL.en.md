---
name: my-workflow-guidelines
description: Global workflow and custom code convention rules for the current user. Applicable to all interactions, especially development conventions and API documentation maintenance for the inlight-board/backend/go project.
---

# Exclusive Workflow and Development Guidelines (My Workflow Guidelines)

When assisting the current user with development, code review, or architecture planning, you must strictly adhere to the following custom rules. These rules have the highest priority, aiming to maintain project consistency, streamline output, and respect the user's absolute control.

## 1. Core Interaction and Planning Behaviors

- **Conversational Planning**: Absolutely do not create any physical plan files (e.g., `plan.md`). All plans, task breakdowns, and progress confirmations should be communicated and determined directly via conversation in the current session.
- **No Unauthorized Installations**: Do not install any SKILLs or plugins without the user's explicit permission.
- **Mandatory Wait for Confirmation**: When encountering any uncertainties, multiple choices, or risky operations (such as large-scale refactoring or deleting files) in the workflow, you **must stop and wait for the user's explicit confirmation**. Proceed to the next step only after receiving permission.
- **Default Communication Language**: Always use **Chinese** to reply and communicate unless explicitly requested otherwise.
- **Restraint and Convergence**: Unless explicitly requested otherwise, think and implement according to the existing coding traditions in the project. **Do not endlessly diverge**, over-design, or introduce unnecessary new patterns.

## 2. Code Generation and Modification Conventions

- **Readability First**: Always strive to write code that is easily readable by humans.
- **Regarding Unit Tests**: **Do not** write any unit test files unless explicitly requested.
- **Regarding Code Comments**: **Do not** write any comments unless explicitly requested. If the user explicitly requests comments, they **must be written in English**.

## 3. Specific Project Conventions: `inlight-board/backend/go`

When handling tasks related to the `inlight-board/backend/go` project, you must strictly adhere to the following exclusive architecture, code style, and submission process requirements:

- **Style Alignment**: You must pay attention to Go code conventions and styles, referring as much as possible to existing code implementations in the same directory or project.
- **Helper Function Layout**: All helper (utility) functions should ideally be placed at the **end** of each code file.
- **Handler Struct Layout**: If a separate struct (request/response struct) needs to be defined for a handler function, **this struct must be placed immediately above the corresponding handler function**.
- **Swagger Documentation Conventions**:
  - The documentation directory is located under `inlight-board/backend/go/doc/`.
  - **Main Entry**: `inlight-board/backend/go/doc/api.yaml` is the entry file for the documentation.
  - **Module Mapping**: The naming of other `*.yaml` configuration files under `doc/` must **correspond one-to-one** with the folders under `inlight-board/backend/go/src/vibe/api/`. When adding or modifying API endpoints, ensure the documentation is synchronously maintained in the correct YAML file.
- **Code Generation Synchronization**: Before committing code with git, if there are newly added database Models, you must run the `inlight-board/backend/go/sync-generated` script to generate the relevant CLI tool code.
- **Code Formatting**: Before committing code with git, you must use the `inlight-board/backend/go/format` script to format the code uniformly.
- **PR and Branch Management**: When the user requests to push code to a remote repository and the corresponding remote branch does not exist, you must use the `gh` CLI tool to create the remote branch and simultaneously create a Pull Request (PR). When creating a PR, you must write the PR title and description in **English**.
- **Code Review Handling**: If requested to modify code based on review information, you must use the `gh` command to fetch the review information from the remote first, and then modify the code accordingly.
- **Reading PRD Documents**: In the `inlight-board/backend/go` project, if you need to read PRD documents from Notion, you can use the `ntn` command.
