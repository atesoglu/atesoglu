Review the PR with the following details:

**Branch/PR:** {{BRANCH_NAME_OR_PR_NUMBER}}
**Target Branch:** {{TARGET_BRANCH (e.g., master/main)}}
**Commits:** {{COMMA_SEPARATED_SHAS}}

**Description:**
{{PASTE_PR_DESCRIPTION_HERE}}

---

### Please verify:

#### 1. Code Correctness
- [ ] New APIs used correctly (check: {{SPECIFIC_API_MIGRATION_E.G._Azure.Messaging.ServiceBus}})
- [ ] Async/await patterns correct — no `.Result`, `.Wait()`, sync-over-async
- [ ] Cancellation tokens propagated through async call chains
- [ ] Resource disposal: clients/senders implement `IAsyncDisposable` or wrapped in `using`/`await using`

#### 2. Error Handling & Resilience
- [ ] Retry policies configured appropriately
- [ ] Exception types updated for new SDK
- [ ] Dead-letter / poison message handling preserved
- [ ] Logging/diagnostics maintained or improved

#### 3. No Regressions
- [ ] Preserved functionality: {{LIST_PRESERVED_COMPONENTS_E.G._Queue.V2,_mail_workflow}}
- [ ] Config updated: connection strings, auth, serialization settings
- [ ] No breaking changes to public contracts unless intentional

#### 4. Quality Gates (run commands)
- [ ] `dotnet build` — zero warnings/errors
- [ ] `dotnet test` — all pass, coverage acceptable
- [ ] `dotnet format` / linter — clean
- [ ] Any integration/contract tests pass

#### 5. Security & Ops
- [ ] No secrets in code/config
- [ ] Managed identity / Azure AD auth used where possible
- [ ] Telemetry/metrics updated for new client

---

### Output format:
**Summary:** 2-3 sentences overall assessment
**Blocking Issues:** (must fix before merge)
**Non-blocking:** (suggestions, nits, follow-ups)
**Commands Run:** (list what you executed and results)
