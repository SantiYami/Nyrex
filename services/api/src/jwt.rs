// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

use jsonwebtoken::{decode, encode, Algorithm, DecodingKey, EncodingKey, Header, Validation};
use nyrex_core::models::TokenClaims;

/// Encode a JWT access token from claims using EdDSA (Ed25519).
/// The private_key_der should be the raw 32-byte Ed25519 private key seed.
pub fn encode_token(
    claims: &TokenClaims,
    private_key_der: &[u8],
) -> Result<String, jsonwebtoken::errors::Error> {
    let mut header = Header::new(Algorithm::EdDSA);
    header.typ = Some("JWT".to_string());

    encode(
        &header,
        claims,
        &EncodingKey::from_ed_der(private_key_der),
    )
}

/// Decode and validate a JWT access token using EdDSA (Ed25519).
/// The public_key_der should be the raw 32-byte Ed25519 public key.
pub fn decode_token(
    token: &str,
    public_key_der: &[u8],
) -> Result<TokenClaims, jsonwebtoken::errors::Error> {
    decode::<TokenClaims>(
        token,
        &DecodingKey::from_ed_der(public_key_der),
        &Validation::new(Algorithm::EdDSA),
    )
    .map(|data| data.claims)
}

#[cfg(test)]
mod tests {
    use super::*;
    use chrono::{Duration, Utc};

    #[test]
    fn test_jwt_round_trip() {
        use base64::{engine::general_purpose, Engine as _};

        // Sample valid Ed25519 pair (PKCS8 for private, raw for public)
        let priv_b64 = "MFECAQEwBQYDK2VwBCIEIPOv+1x7QTK9++lp+K5/8+9U1KA5a9fehrseGcBFl21/gSEAUCLZNpuif7WM+F49mxwwnvP441mubTh+iIzuE6S8og0=";
        let pub_b64 = "UCLZNpuif7WM+F49mxwwnvP441mubTh+iIzuE6S8og0=";
        
        let priv_key = general_purpose::STANDARD.decode(priv_b64).unwrap();
        let pub_key = general_purpose::STANDARD.decode(pub_b64).unwrap();

        let claims = TokenClaims {
            sub: "user-123".to_string(),
            iat: Utc::now().timestamp() as usize,
            exp: (Utc::now() + Duration::hours(1)).timestamp() as usize,
        };

        let token = encode_token(&claims, &priv_key).expect("Failed to encode");
        assert!(!token.is_empty());

        let decoded = decode_token(&token, &pub_key).expect("Failed to decode");
        assert_eq!(decoded.sub, "user-123");
    }
}
