## The difference between `su user1` and `su - user1` lies in how the **environment** is handled when switching to the new user.

### 1. **`su user1`**
- **Switch User Without Login Shell**
  - Switches to `user1` but **does not start a login shell**.
  - The environment variables of the current user are preserved.
  - The working directory remains unchanged.
  - The shell starts as a **sub-shell** (not as a login shell), so the user doesn't get the default environment settings of `user1`.

#### Example:
```bash
su user1
```
- If the current user is `root`:
  - You'll switch to `user1` with `root`'s environment variables and current working directory.

### 2. **`su - user1`**
- **Switch User With Login Shell**
  - Switches to `user1` and **starts a login shell**.
  - This mimics a fresh login by `user1`, loading their default environment (from files like `~/.bashrc`, `~/.bash_profile`, or `/etc/profile`).
  - The environment variables are reset to those specific to `user1`.
  - The working directory changes to `user1`’s home directory (`/home/user1` by default).

#### Example:
```bash
su - user1
```
- You'll be logged in as `user1` with their environment variables, working directory, and shell setup.

### Key Differences

| Feature                | `su user1`                     | `su - user1`                     |
|------------------------|---------------------------------|----------------------------------|
| **Environment Variables** | Current user's environment is preserved. | New environment is loaded for `user1`. |
| **Working Directory**    | Remains unchanged.            | Changes to `user1`'s home directory. |
| **Shell Type**           | Sub-shell (not a login shell). | Login shell for `user1`.         |
| **Use Case**             | Quick command execution as `user1`. | Full switch to `user1`’s session. |


![image](https://github.com/user-attachments/assets/bb594170-bff1-4478-b039-3998c3a57f2a)

---

### Practical Use Cases

1. **`su user1`**:
   - Use it when you need to temporarily switch to another user to run a command or two, without needing their full environment.
   - Example: You’re `root` and want to run a quick task as `user1`.

2. **`su - user1`**:
   - Use it when you need to switch fully to another user and simulate their login session.
   - Example: Debugging issues in `user1`’s environment or working on their behalf for an extended session.
