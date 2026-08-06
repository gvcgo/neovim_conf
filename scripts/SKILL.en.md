---
name: my-workflow-guidelines
description: Global workflow and code convention customized rules for the current user. Applicable to all interactions, especially development conventions and API documentation maintenance for the inlight-board/backend/go project.
---

# Exclusive Workflow & Development Guidelines (My Workflow Guidelines)

When assisting the current user with development, code reviews, or architectural planning, you must strictly adhere to the following customized rules. These rules have the highest priority and are designed to maintain project consistency, streamline output, and respect the user's absolute control.

## 1. Core Interaction & Planning Behavior

- **Conversational Planning**: Absolutely never create any physical plan files (e.g., `plan.md`). All plans, task breakdowns, and progress confirmations should be communicated and finalized directly via conversation in the current session.
- **No Unauthorized Installations**: Never install any SKILLs or plugins without the user's explicit permission.
- **Mandatory Wait for Confirmation**: When encountering any uncertainty, facing multiple choices, or taking risky actions (such as large-scale refactoring or deleting files) in the workflow, you **must stop and wait for the user's explicit confirmation**. Proceed to the next step only after receiving permission.
- **Default Communication Language**: Always use **Chinese** for replies and communication unless explicitly requested otherwise.
- **Restraint & Convergence**: Unless explicitly requested otherwise, think and implement according to the existing code traditions in the project. **Absolutely do not endlessly diverge**, over-engineer, or introduce unnecessary new patterns.

## 2. Code Generation & Modification Conventions

- **Readability First**: Always try to write code that is easy for humans to read.
- **Regarding Unit Tests**: **Do not** write any unit test files unless explicitly requested.
- **Regarding Code Comments**: **Do not** write any comments unless explicitly requested. If the user explicitly asks for comments, they **must be written in English**.

## 3. Specific Project Guidelines: `inlight-board/backend/go`

When handling tasks related to the `inlight-board/backend/go` project, you must strictly adhere to the following exclusive architectural, coding style, and submission process requirements:

- **Style Alignment**: You must pay attention to Go code conventions and style, trying to reference existing code implementations within the same directory or project.
- **Helper Function Layout**: All helper (utility) functions should ideally be placed at the **end** of each code file.
- **Handler Struct Layout**: If a separate struct (request/response struct) needs to be defined for a handler function, **this struct must be placed immediately above the corresponding handler function**.
- **Swagger Documentation Conventions**:
  - The document directory is located under `inlight-board/backend/go/doc/`.
  - **Main Entry Point**: `inlight-board/backend/go/doc/api.yaml` is the entry file for the documentation.
  - **Module Mapping**: The naming of the remaining `*.yaml` configuration files under `doc/` must strictly correspond **one-to-one** with the folders under `inlight-board/backend/go/src/vibe/api/`. When adding or modifying API endpoints, ensure the documentation is synchronously maintained in the correct YAML file.
- **Code Generation Sync**: Before committing code using git, if there are newly added database Models, you must run the `inlight-board/backend/go/sync-generated` script to generate the related CLI tool code.
- **Code Formatting**: Before committing code using git, you must use the `inlight-board/backend/go/format` script to uniformly format the code.
- **PR and Branch Management**: When the user requests pushing code to a remote repository and the corresponding remote branch does not exist, you must use the `gh` command-line tool to create the remote branch and simultaneously create a Pull Request (PR). When creating the PR, you must write the PR title and description in **English**.
- **Code Review Processing**: If requested to modify code based on review information, you must use the `gh` command to fetch the review information from the remote before making the code modifications accordingly.
- **Reading PRD Documents**: In the `inlight-board/backend/go` project, if you need to read PRD documents in Notion, you can use the `ntn` command.
- **DynamoDB Data Querying**: If you need to query data in DynamoDB within the `inlight-board/backend/go` project, you can use the `repo-cli` command. The subcommands in `repo-cli` correspond to the various query methods in `inlight-board/backend/go`.
