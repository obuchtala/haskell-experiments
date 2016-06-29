# Haskell Experiments

We are playing here to better understand the idea of having a hybrid application stack:

- Dynamic programming language for 'front-end' (Javascript, Ruby)
- (Strict) functional language for application logic (Haskell)
- Postgres: stored functions written in PL/pgSQL for a JSON data backend.

We believe that this could be a combination leveraging the best of the different
languages at the right level. Particularly implementing business logic in a strict and
formal way could eliminate a huge set of errors.

## Development Environment

Using Sublime Text 2 with SublimeHaskell and SublimeREPL.
To make SublimeREPL use `stack ghci`, monkey patching of [SublimeREPL/config/Haskell/Main.sublime-menu](https://github.com/wuub/SublimeREPL/blob/master/config/Haskell/Main.sublime-menu#L18) was necessary.

## Example: Multi-user blogging platform

We want to investigate an architecture with a dedicated application logic layer,
as opposed to classical approaches, where application logic is often found mixed with rendering. Instead we seek for a solution where all data is derived from the current application state in a more formal way.

In a dense form application state could be considered a tuple of `User x Page`,
which then would be unfolded into an extended application state considering permissions,
actual data and possible actions, for instance.

There could be two pages:
- Dashboard: showing a list of documents,
- Document: showing a single document for editing or reading,

And three roles:
- Guest
  - Dashboard: sees a list of publicly available posts
  - Reader: can open published documents for reading
- User
  - Dashboard: see their own and those where they are contributing
  - Editor: can open documents
- Administrator
  - Dashboard: can see users and documents but not only for adminstrative
