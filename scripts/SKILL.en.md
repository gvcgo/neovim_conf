---
name: my-workflow-guidelines
description: Global workflow and code convention customization rules for the current user. Applicable to all interactions, especially development conventions and API documentation maintenance for the inlight-board/backend/go project.
---

# My Workflow Guidelines

When assisting the current user with development, code review, or architectural planning, you must strictly adhere to the following customized rules. These rules have the highest priority and aim to maintain project consistency, streamline output, and respect the user's absolute control.

## 1. Core Interactions and Planning Behavior

- **Conversational Planning**: Never create any physical plan files (such as `plan.md`). All planning, task breakdown, and progress confirmation must be communicated and finalized directly through conversation within current session.
- **No Unauthorized Installations**: Never install any SKILLs or plugins without explicit permission from the user.
- **Mandatory Wait for Confirmation**: When encountering any uncertainties, multiple choices, or risks (such as large-scale refactoring or file deletion) in the workflow, you **must stop and wait for the user's explicit confirmation**. Proceed to the next step only after receiving permission.
- **Default Communication Language**: Always use **Chinese** for answers and communication unless explicitly requested otherwise.
- **Restraint and Convergence**: Unless explicitly requested otherwise, think and implement according to the existing coding traditions in the project. **Do not endlessly diverge**, over-engineer, or introduce unnecessary new patterns.

## 2. Code Generation and Modification Conventions

- **Unit Tests**: **Do not** write any unit test files unless explicitly requested.
- **Code Comments**: **Do not** write any comments unless explicitly requested. If the user explicitly requests comments, they **must be written in English**.

## 3. Specific Project Guidelines: `inlight-board/backend/go`

When handling tasks related to the `inlight-board/backend/go` project, you must strictly adhere to the following exclusive architectural, coding style, and commit process requirements:

- **Style Alignment**: Pay strict attention to Go code conventions and style. Always try to reference existing code implementations within the same directory or project.
- **Helper Function Layout**: All helper (utility) functions should be placed at the **end** of each code file whenever possible.
- **Handler Struct Layout**: If you need to define a separate struct (request/response struct) for a handler function, you **must place the struct directly above** its corresponding handler function.
- **Swagger Documentation Guidelines**:
  - The documentation directory is located at `inlight-board/backend/go/doc/`.
  - **Main Entry**: `inlight-board/backend/go/doc/api.yaml` is the entry file for the documentation.
  - **Module Mapping**: The naming of other `*.yaml` configuration files under `doc/` **must strictly correspond one-to-one** with the folders under `inlight-board/backend/go/src/vibe/api/`. When adding or modifying API endpoints, ensure the documentation is synchronously maintained in the correct YAML file.
- **Code Generation Sync**: Before committing code with git, if there are any newly added database Models, you must run the `inlight-board/backend/go/sync-generated` script to generate the related CLI tool code.
- **Code Formatting**: Before committing code with git, you must format the code uniformly using the `inlight-board/backend/go/format` script.
- **PR and Branch Management**: When the user requests to push code to a remote repository, and the corresponding remote branch does not exist, you must use the `gh` command-line tool to create the remote branch and simultaneously create a Pull Request (PR). When creating the PR, you must write the PR title and description in **English**.
