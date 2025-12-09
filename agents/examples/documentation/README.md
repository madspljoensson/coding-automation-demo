# Documentation Update Example

Example of automated documentation updates based on code changes.

## Scenario

**Work Item**: #12360 - "Update API documentation for new authentication endpoints"

## Context

New authentication endpoints were added to the API in a previous PR. Documentation needs to be updated to reflect these changes.

## Changes Required

### Files to Update

1. `docs/api/authentication.md` - Add new endpoints
2. `README.md` - Update quick start guide
3. `examples/auth-example.js` - Add code examples
4. `openapi.yaml` - Update OpenAPI specification

### New Endpoints to Document

```
POST /api/v1/auth/login
POST /api/v1/auth/refresh
POST /api/v1/auth/logout
GET  /api/v1/auth/validate
```

## Expected Documentation Updates

### API Documentation (`docs/api/authentication.md`)

```markdown
## Authentication Endpoints

### POST /api/v1/auth/login

Authenticates a user and returns access and refresh tokens.

**Request Body:**
\`\`\`json
{
  "username": "user@example.com",
  "password": "secure-password"
}
\`\`\`

**Response:**
\`\`\`json
{
  "accessToken": "eyJhbGc...",
  "refreshToken": "eyJhbGc...",
  "expiresIn": 3600
}
\`\`\`

**Status Codes:**
- 200: Success
- 401: Invalid credentials
- 429: Too many attempts

### POST /api/v1/auth/refresh

Refreshes an expired access token using a refresh token.

**Request Body:**
\`\`\`json
{
  "refreshToken": "eyJhbGc..."
}
\`\`\`

**Response:**
\`\`\`json
{
  "accessToken": "eyJhbGc...",
  "expiresIn": 3600
}
\`\`\`

...
```

### Code Example (`examples/auth-example.js`)

```javascript
// Authentication Example

const API_BASE = 'https://api.example.com/v1';

// Login
async function login(username, password) {
  const response = await fetch(`${API_BASE}/auth/login`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ username, password })
  });
  
  if (!response.ok) {
    throw new Error('Login failed');
  }
  
  const { accessToken, refreshToken } = await response.json();
  
  // Store tokens securely
  localStorage.setItem('accessToken', accessToken);
  localStorage.setItem('refreshToken', refreshToken);
  
  return accessToken;
}

// Refresh token
async function refreshToken() {
  const refreshToken = localStorage.getItem('refreshToken');
  
  const response = await fetch(`${API_BASE}/auth/refresh`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ refreshToken })
  });
  
  if (!response.ok) {
    // Refresh token expired, need to login again
    throw new Error('Token refresh failed');
  }
  
  const { accessToken } = await response.json();
  localStorage.setItem('accessToken', accessToken);
  
  return accessToken;
}

// Make authenticated request
async function authenticatedRequest(url, options = {}) {
  let token = localStorage.getItem('accessToken');
  
  const response = await fetch(url, {
    ...options,
    headers: {
      ...options.headers,
      'Authorization': `Bearer ${token}`
    }
  });
  
  // If token expired, refresh and retry
  if (response.status === 401) {
    token = await refreshToken();
    return fetch(url, {
      ...options,
      headers: {
        ...options.headers,
        'Authorization': `Bearer ${token}`
      }
    });
  }
  
  return response;
}

// Export functions
module.exports = { login, refreshToken, authenticatedRequest };
```

### OpenAPI Specification Update

```yaml
paths:
  /auth/login:
    post:
      summary: Authenticate user
      tags:
        - Authentication
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                username:
                  type: string
                  format: email
                password:
                  type: string
                  format: password
      responses:
        '200':
          description: Successful authentication
          content:
            application/json:
              schema:
                type: object
                properties:
                  accessToken:
                    type: string
                  refreshToken:
                    type: string
                  expiresIn:
                    type: integer
```

## Agent Actions

1. ✅ Analyze existing code to understand new endpoints
2. ✅ Review API implementation for correct details
3. ✅ Update markdown documentation with endpoint details
4. ✅ Create practical code examples
5. ✅ Update OpenAPI spec
6. ✅ Ensure consistency across all docs
7. ✅ Create PR

## Quality Checks

- [ ] All endpoints documented
- [ ] Code examples are runnable
- [ ] Request/response schemas match implementation
- [ ] Status codes documented
- [ ] Security considerations mentioned
- [ ] Links between documents work

## Time Comparison

- **Manual documentation**: 2-3 hours
- **Agent documentation**: 10-15 minutes
- **Speedup**: ~10-15x

## Benefits

1. **Consistency**: Agent ensures all endpoints documented similarly
2. **Accuracy**: Pulls details directly from code
3. **Completeness**: Doesn't forget edge cases or error codes
4. **Speed**: Much faster than manual writing
5. **Up-to-date**: Documentation stays current with code

## Human Review Focus

When reviewing this PR, check:

- [ ] Examples are idiomatic and follow best practices
- [ ] Security advice is appropriate
- [ ] Tone and style match existing docs
- [ ] No sensitive information exposed
- [ ] Links and formatting render correctly

