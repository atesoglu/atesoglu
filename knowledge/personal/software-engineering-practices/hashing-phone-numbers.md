# Hashing Phone Numbers: Design Rationale, Pitfalls and Best Practices

## Context

We hash phone numbers to:

* Avoid storing them in plaintext
* Enable deterministic lookups (e.g., equality filtering)
* Reduce exposure if the database is compromised

The current implementation uses `HMACSHA256` with a configurable value referred to as a "salt." This protects the value from a database-only compromise only if the HMAC key is stored separately and remains secret.

HMAC output is deterministic, so it provides pseudonymization and equality lookup, not anonymization. Anyone who can use the key can reproduce the lookup values, and anyone with database access can still observe whether two stored values are equal.

---

## Important Terminology Clarification

What we are using is **not a salt**, but a **secret key**.

* **Salt**
* Usually public
* Typically unique per record
* Stored alongside the hash


* **HMAC key**
* Must remain secret
* Can be global
* Provides protection against offline brute-force attacks



For clarity and correctness, use a name such as `hashingKey` or `hmacKey` instead of `salt`.

Normalize phone numbers before computing the HMAC. Define a canonical format, such as E.164, and apply it consistently for storage and lookup. Otherwise, formatting differences can produce different values for the same number.

---

## Why Naive Key (Salt) Rotation Breaks Lookups

HMAC hashing is deterministic:

If the key changes:

* The same phone number produces a different hash
* Existing database records become unqueryable
* Lookups silently fail

> **Warning:** Rotating the hashing key without a migration or versioning strategy breaks all existing lookups. Key rotation is not "free" for lookup hashes.

---

## Why Using the Phone Number as the Key Is Incorrect

Ideas such as reversing the phone number, deriving the key only from the phone number, or mixing digits are **cryptographically unsound**.

### Reason

HMAC security depends on the key being **secret and independent of the message**. If the key is fully derivable from the phone number and the phone number space is small/guessable, the construction provides **no protection** against offline brute-force attacks.

**Rule of thumb**:

> If an attacker can guess or derive the key, it is not a key.

---

## Correct and Secure Approaches

### Option 1: Single Stable HMAC Key (Recommended Default)

```text
hash = HMAC(masterSecretKey, phoneNumber)

```

**Properties:**

* **Deterministic:** Searchable and consistent.
* **Secure against database-only guessing:** Protects against offline guessing when the key is not stored with the database.
* **Simple:** Easy to reason about and implement.

**Requirements:**

* The key must be stored securely (Env vars, Key Vault, etc.).
* The key must remain stable; rotation requires rehashing or versioning.

---

### Option 2: Keyed Derivation for Key Separation

Derive separate keys for separate purposes only when the system needs cryptographic domain separation. A second HMAC over the same phone number does not materially improve this lookup design; a single stable HMAC key is simpler and easier to migrate.

---

## Key Rotation: When and How It Works

Key rotation is possible, but only with explicit design.

* **Safe patterns:**
* **Key versioning:** Store a version ID alongside the hash.
* **Dual-hash:** Check both old and new keys during migration windows.
* **Background rehashing:** Update existing records to the new key over time.


* **Unsafe pattern:**
* Changing the key in configuration without migrating existing hashes.



---

## Best Practices Summary

* **Use HMAC** with a secret key, not a plain hash.
* **Do not derive keys** solely from the phone number.
* **Treat the key** as a long-lived secret, not a casual config.
* **Rename variables** to reflect reality (`hashingKey`, not `salt`).
* **Rotate keys** only with a clear migration strategy.
* **Document assumptions** explicitly for future maintainers.

### Bottom Line

Determinism alone is not security. A "key" derived from the data it protects adds no entropy. At least one secret external to the database is required for true protection.