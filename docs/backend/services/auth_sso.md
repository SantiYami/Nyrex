# Nyrex — Backend: Authentication & SSO (Stage 6)

> OAuth 2.0 + OIDC for Google/Microsoft. JWT session tokens. Vault master password is separate.

## Auth Flow

```
1. User taps "Sign in with Google/Microsoft"
2. Flutter opens OAuth consent screen (google_sign_in / MSAL)
3. ID token sent to POST /auth/oauth/{provider}
4. Backend verifies token with provider's JWKS endpoint
5. Backend upserts user record (email + sso_sub)
6. Backend issues signed JWT (RS256, 24h expiry)
7. Flutter stores JWT in flutter_secure_storage
8. All API calls: Authorization: Bearer <token>
```

## Axum Middleware

```rust
pub async fn require_auth(mut req: Request, next: Next) -> Result<impl IntoResponse, StatusCode> {
    let token = extract_bearer_token(&req).ok_or(StatusCode::UNAUTHORIZED)?;
    let claims = decode::<Claims>(&token, &DECODING_KEY, &Validation::default())
        .map_err(|_| StatusCode::UNAUTHORIZED)?;
    req.extensions_mut().insert(claims.sub);
    Ok(next.run(req).await)
}
```

## Key Rule

SSO authenticates the user to the Nyrex API. The vault master password is completely separate — it derives the encryption key locally and never touches any OAuth provider. If the master password is lost, the vault cannot be recovered.

## Email + Password (Phase 1)

Before SSO, basic email + password auth:
- `POST /auth/register` — email, hashed password (argon2id server-side)
- `POST /auth/login` — verify credentials, issue JWT
- `POST /auth/refresh` — refresh token rotation

*Last updated: May 2026*
