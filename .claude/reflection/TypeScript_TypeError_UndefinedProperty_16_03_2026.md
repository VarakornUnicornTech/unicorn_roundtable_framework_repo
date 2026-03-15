---
language: TypeScript
error_type: TypeError
project: Example
severity: Medium
status: Resolved
ticket: MON-00
---

# TypeScript — TypeError: Cannot read properties of undefined

**Date Resolved:** 16-03-2026
**Project:** Example
**Ticket:** MON-00 (example entry)

---

## What Happened

```
TypeError: Cannot read properties of undefined (reading 'id')
    at UserService.getUser (src/services/user.service.ts:42:28)
    at async UserController.handleGetUser (src/controllers/user.controller.ts:18:20)
```

The application crashed when a user lookup was performed for an email address that did not exist in the database. The error surfaced as an unhandled exception in the controller, returning a 500 to the client instead of a 404.

---

## Root Cause

`findOne()` returns `undefined` when no record matches the query predicate. The calling code at `user.service.ts:42` assumed the return value would always be a valid User object and accessed `.id` directly without checking for `undefined` first.

```typescript
// The broken line
const user = await this.userRepo.findOne({ where: { email } });
return user.id;  // ← crashes when user is undefined
```

---

## Why Missed

The happy path (user exists) was always exercised in tests. No test case covered the "user not found" scenario. TypeScript strict null checks were not enabled in `tsconfig.json`, so the compiler did not flag the unsafe property access at build time.

---

## Fix Applied

Added an existence check before property access and replaced the silent failure with a typed exception:

```typescript
// Before (broken)
const user = await this.userRepo.findOne({ where: { email } });
return user.id;

// After (fixed)
const user = await this.userRepo.findOne({ where: { email } });
if (!user) {
  throw new NotFoundException(`User not found: ${email}`);
}
return user.id;
```

The controller's exception filter converts `NotFoundException` to a 404 response automatically.

---

## Prevention Checklist

- [ ] For every `findOne()` / `findById()` / `findOneBy()` call: check for `null` / `undefined` before accessing any property
- [ ] Add a "not found" test case for every service method that performs a single-record query
- [ ] Enable `"strictNullChecks": true` in `tsconfig.json` — this would have caught the unsafe access at compile time
- [ ] Do not chain property access on values returned from async repository calls without first asserting they exist
- [ ] Controllers that call services expecting a record should document which exception type they catch for not-found cases

---

## Lesson Learned

Database queries returning a single record should **always** be followed by an existence check. Enabling TypeScript's `strictNullChecks` catches this class of error at compile time — it should be the default on all new projects.

---

*This is an example entry demonstrating the reflection file format.*
*For real bug reflections, replace all example content with actual ticket data.*
