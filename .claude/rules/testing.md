---
description: "Testing requirements: unit tests, integration tests, regression tests, verification sign-off"
globs:
  - "**/*.test.*"
  - "**/*.spec.*"
  - "**/tests/**"
  - "**/test/**"
  - "**/__tests__/**"
---

# Testing Rules

## Unit Tests Required
Every new function, method, and endpoint must have unit tests.
No ticket marked Complete without passing tests.

## Integration Tests for Cross-Module
Cross-module interactions require integration tests.
Verification Scholar signs off on test results before OverseerReport is filed.

## Hotfix Regression Test (MANDATORY)
Every bug fix includes a test case reproducing the original bug.
Test must fail before fix, pass after. Regression tests are permanent — never deleted.
Location: `Development/09_TestCase/_regression/`

## Test Documentation
`09_TestCase/` is mandatory in every project Development directory.
Stores test plans and documentation. Executable test code in source tree.
Verification Scholar owns and maintains the test index.

## Living Documentation
`Current TechStack.md` updated in the same session as code changes.
Verification Scholar checks currency as sign-off requirement.
Missing documentation entry = ticket not Complete.
