<!-- TODO: LOOK FOR THE BEST WAY TO ADD THE CONTRIBUTING.md FILE TO THE PROJECT -->

# Contributing to Academic Hub

First off, thank you for considering contributing to Academic Hub! It's people like you that make Academic Hub such a great tool. We welcome contributions from everyone, whether it's a bug report, feature suggestion, or code contribution.

## Table of Contents

1. [How Can I Contribute?](#how-can-i-contribute)
   - [Reporting Bugs](#reporting-bugs)
   - [Suggesting Enhancements](#suggesting-enhancements)
   - [Your First Code Contribution](#your-first-code-contribution)
   - [Pull Requests](#pull-requests)
2. [Styleguides](#styleguides)
   - [Git Commit Messages](#git-commit-messages)
   - [TypeScript Styleguide](#typescript-styleguide)
   - [Svelte Styleguide](#svelte-styleguide)
   - [Documentation Styleguide](#documentation-styleguide)
3. [Additional Notes](#additional-notes)

## How Can I Contribute?

### Reporting Bugs

- Ensure the bug was not already reported by searching on GitHub under [Issues](https://github.com/Yrrrrrf/academic-hub/issues)
- If you're unable to find an open issue addressing the problem, [open a new one](https://github.com/Yrrrrrf/academic-hub/issues/new). Be sure to include a title and clear description, as much relevant information as possible, and a code sample or an executable test case demonstrating the expected behavior that is not occurring.

### Suggesting Enhancements

- Open a new issue with a clear title and detailed description
- Provide specific examples to demonstrate the steps
- Describe the current behavior and explain which behavior you expected to see instead and why
- Include screenshots and animated GIFs which help you demonstrate the steps or point out the part of Academic Hub which the suggestion is related to

### Your First Code Contribution

Unsure where to begin contributing to Academic Hub? You can start by looking through these `beginner` and `help-wanted` issues:

- [Beginner issues](https://github.com/Yrrrrrf/academic-hub/labels/beginner) - issues which should only require a few lines of code, and a test or two.
- [Help wanted issues](https://github.com/Yrrrrrf/academic-hub/labels/help%20wanted) - issues which should be a bit more involved than `beginner` issues.

### Pull Requests

1. Fork the repo and create your branch from `main`.
2. If you've added code that should be tested, add tests.
3. If you've changed APIs, update the documentation.
4. Ensure the test suite passes.
5. Make sure your code lints.
6. Issue that pull request!

## Styleguides

### Git Commit Messages

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters or less
- Reference issues and pull requests liberally after the first line

### TypeScript Styleguide

All TypeScript code is linted with [ESLint](https://eslint.org/) and formatted with [Prettier](https://prettier.io/). To ensure your code follows the project's style:

1. Install the ESLint and Prettier extensions for your code editor.
2. Run `npm run lint` before committing to catch any style issues.
3. Use TypeScript's strict mode and avoid using `any` type when possible.
4. Prefer interfaces over types for object definitions.

### Svelte Styleguide

- Follow the [Svelte Style Guide](https://github.com/sveltejs/eslint-plugin-svelte3/blob/master/RULES.md)
- Use Svelte's built-in reactivity where possible
- Keep components small and focused on a single responsibility

### Documentation Styleguide

- Use [Markdown](https://guides.github.com/features/mastering-markdown/) for documentation
- Reference functions, classes, and modules in backticks: \`functionName()\`
- Use code blocks for examples:
  ```typescript
  function exampleFunction(): void {
    console.log('This is an example');
  }
  ```

## Additional Notes

### Issue and Pull Request Labels

This section lists the labels we use to help us track and manage issues and pull requests.

* `bug` - Issues for bugs in the codebase
* `enhancement` - Issues for new features or improvements
* `documentation` - Issues related to documentation
* `good first issue` - Good for newcomers
* `help wanted` - Extra attention is needed
* `question` - Further information is requested

Thank you for contributing to Academic Hub!