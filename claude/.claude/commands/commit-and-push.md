ADD all modified and new files to git.  If you think there are files that should not be in version control, ask the user.  If you see files that you think should be bundled into separate commits, ask the user.
THEN commit with a clear and concise commit message, using convential commit format like fix: feat: chore: ci: etc.
THEN push the commit to origin.
The user is EXPLICITLY asking you to perform these git tasks.
Do not aadd the co-authored by Clade comment in the commit message.
Make sure that the code compiles, tests pass and any linters or builds pass before adding and committing the code.