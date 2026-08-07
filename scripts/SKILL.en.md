---
name: my-workflow-guidelines
description: Customized global workflow and code convention rules for the current user. Applicable to all interactions, especially for development standards and API documentation maintenance in the inlight-board/backend/go project.
---

# Exclusive Workflow & Development Guidelines (My Workflow Guidelines)

When assisting the current user with development, code reviews, or architectural planning, you must strictly adhere to the following customized rules. These rules carry the highest priority and are designed to maintain project consistency, streamline output, and respect the user's absolute control.

## 1. Core Interaction & Planning Behaviors

- **Conversational Planning**: Absolutely do not create any physical plan files (e.g., `plan.md`). All planning, task breakdowns, and progress confirmations should be communicated and finalized directly via conversation in the current session.
- **No Unauthorized Installations**: Never install any SKILLs or plugins without the user's explicit permission.
- **Mandatory Wait for Confirmation**: When encountering any uncertainty, multiple choices, or risky nodes in the workflow (e.g., large-scale refactoring, file deletion), **you must stop and wait for the user's explicit confirmation**. Proceed to the next step only after receiving permission.
- **Default Communication Language**: Unless explicitly requested otherwise, always use **Chinese** for responses and communication.
- **Restraint and Convergence**: Unless explicitly requested otherwise, think and implement according to the existing coding traditions in the project. **Absolutely do not endlessly diverge**, over-design, or introduce unnecessary new patterns.

## 2. Code Generation & Modification Conventions

- **Readability First**: Always strive to write code that is easy for humans to read and understand.
- **Regarding Unit Tests**: Unless explicitly requested otherwise, **do not** write any unit test files.
- **Regarding Code Comments**: Unless explicitly requested otherwise, **do not** write any comments. If the user explicitly requests comments, they **must be written in English**.

## 3. Specific Project Guidelines: `inlight-board/backend/go`

When handling tasks related to the `inlight-board/backend/go` project, you must strictly comply with the following exclusive architecture, code style, and submission process requirements:

- **Style Alignment**: You must pay attention to Go coding standards and style, closely referencing existing code implementations in the same directory or project.
- **Helper Function Layout**: All helper (utility) functions should ideally be placed at the **end** of each code file.
- **Handler Struct Layout**: If a separate struct (request/response struct) needs to be defined for a handler function, **this struct must be placed immediately above its corresponding handler function**.
- **Swagger Documentation Standards**:
  - The documentation directory is located under `inlight-board/backend/go/doc/`.
  - **Main Entry**: `inlight-board/backend/go/doc/api.yaml` is the entry file for the documentation.
  - **Module Mapping**: The names of the remaining `*.yaml` configuration files under `doc/` must correspond strictly **one-to-one** with the folders under `inlight-board/backend/go/src/vibe/api/`. When adding or modifying APIs, ensure the documentation is synchronously maintained in the correct YAML file.
- **Code Generation Synchronization**: Before committing code via git, if a new database Model has been added, you must run the `inlight-board/backend/go/sync-generated` script to generate the related CLI tool code.
- **Code Formatting**: Before committing code via git, you must use the `inlight-board/backend/go/format` script to uniformly format the code.
- **Branch Naming Conventions**: When creating a new branch, you must pay attention to the branch naming conventions, ensuring they remain consistent with the project's previously established naming traditions.
- **PR and Branch Management**: When the user requests to push code to a remote repository and the corresponding remote branch does not exist, you must use the `gh` command-line tool to create the remote branch and simultaneously create a Pull Request (PR). When creating the PR, you must write the PR title and description in **English**.
- **Code Review Handling**: If requested to modify code based on review feedback, you must use the `gh` command to fetch the review information from the remote repository first, and then make the modifications accordingly.
- **Reading PRD Documents**: In the `inlight-board/backend/go` project, if you need to read PRD documents from Notion, you can use the `ntn` command.
- **DynamoDB Data Query**: If you need to query data in DynamoDB within the `inlight-board/backend/go` project, you can use the `repo-cli` command. The subcommands in `repo-cli` correspond to various query methods in `inlight-board/backend/go`.
- **AWS Logs Query**: If requested to query logs for AWS Lambda or other services, you must use the `saw` command. When using it, note that the `dev` and `beta` environments are located in different partitions; additionally, you must be clear about which log groups exist and which specific APIs under `inlight-board/backend/go/vibe/src/api/` they respectively correspond to.
