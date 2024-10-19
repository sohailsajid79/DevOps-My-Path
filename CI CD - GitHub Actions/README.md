# GitHub Actions - CI/CD Pipeline

GitHub Actions enables workflow automation directly from your repositories. You can define workflows using YAML files located in `.github/workflows`, automating tasks like building, testing, and deploying code.

## Table of Contents

1. [CI CD](#ci-cd)

2. [Workflow Triggers](#workflow-triggers)

3. [Workflow, Jobs, Steps, and Actions](#workflow-jobs-steps-and-actions)

4. [Runner Types](#runner-types)

5. [Artifacts in GitHub Actions](#artifacts-in-github-actions)

6. [Conditions and Expressions](#conditions-and-expressions)

7. [Matrix Strategy](#matrix-strategy)

8. [Custom Actions in GitHub](#custom-actions-in-github)

9. [Reusable Workflows](#reusable-workflows)

10. [Custom Actions vs Reusable Workflows](#custom-actions-vs-reusable-workflows)

11. [Production-Ready Workflow](#production-ready-workflow)

## CI CD

CI = Continuous Integration <br>
CD = Continuous Deployment / Continuous Delivery <br>

![cicddevops](./assets/cicd%20devops.png)
[Source](https://www.blackduck.com/glossary/what-is-cicd.html)

CI/CD plays a crucial role in the DevOps process by automating software development workflows and ensuring the smooth delivery of high-quality software at a rapid pace.

**CI Phases: Code → Build → Plan.**

The focus here is to automate the process of building and testing code changes to ensure they integrate seamlessly with the existing system. Continuous testing is central to the CI/CD pipeline, ensuring that new code is frequently validated to avoid bugs and issues.

**CD Phases: Release → Deploy → Operate → Monitor.**

Within CD we automate the deployment of software to production or staging environments. Continuous monitoring and operation ensure smooth functioning.
The loop signifies an ongoing process, where code is continuously improved, integrated, tested, and delivered or deployed.

**CI/CD Pipeline Stages**

![cicdpipeline](./assets/cicd%20pipeline.png)
[Source](https://katalon.com/resources-center/blog/ci-cd-pipeline)

The image outlines the CI/CD pipeline step by step, illustrating the flow of changes from the initial code commit to deployment in production:

- **Commit Change**: Developers submit their code changes to the repository.
- **Trigger Build**: Once the code is committed, the build process is automatically initiated.
- **Build**: The code is compiled, dependencies are resolved, and executable files are generated.
- **Notify of Build Outcome**: The team receives notifications about the success or failure of the build process.
- **Run Tests**: Automated tests are performed to ensure the code behaves as expected.
- **Notify of Test Outcome**: The test results are communicated to the development team.
- **Deliver Build to Staging**: After passing the tests, the build is deployed to a staging environment for further testing.
- **Deploy to Production**: Finally, the application is deployed to the live production environment.

## Workflow Triggers

Workflows in GitHub Actions can be triggered by various types of events. The `on` clause in the workflow definition specifies which events will trigger the workflow - [Documentation](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows)

Trigger on Push or Pull Request:

```
on:
  [push, pull_request]
```

Trigger on Pull Request to a Specific Branch:

```
on:
  pull_request:
    branches:
      - develop
```

Trigger a Workflow Every Weekday from 8am to 5pm with [cron expressions](https://crontab.guru/):

```
on:
  schedule:
    - cron: '0 8-17 * * 1-5'
```

Manual Workflow Trigger:

```
on:
  workflow_dispatch:
```

Webhook Trigger on Wiki Page Update:

```
on:
  gollum:
```

External Events: `repository_dispatch` event is used to listen for custom events triggered via an external POST request sent to `/repos/{owner}/{repo}/dispatches`

```
on:
  repository_dispatch:
```

## Workflow, Jobs, Steps, and Actions

- **Workflow**: An event triggers the workflow, which contains a collection of jobs defined in a YAML file.
- **Jobs**: Jobs are units of work (1 or more) that can be executed sequentially or in parallel within a workflow.
- **Steps**: Steps are individual commands that are executed as part of a job.
- **Actions**: An action is a reusable command that performs a specific task in the workflow.

### Components of GitHub Actions:

![workflow-components](./assets/workflow-components.png) [Source](https://learn.microsoft.com/en-us/training/modules/github-actions-automate-tasks/2b-identify-components-workflow)

### Example Structure:

```
name: CI/CD Pipeline

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'

      - name: Install Dependencies
        run: npm install

      - name: Run Tests
        run: npm test

  deploy:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to Production
        run: echo "Deploying to production"
```

The workflow defines:

- **Trigger**: Runs on a `push` event to the main branch.
- **Jobs**: Two jobs (build and deploy). The deploy job `needs` the build job to complete successfully before it can run.
- **Steps**: Each job has several steps, which includes actions such as `actions/checkout` & `actions/setup-node`, installing dependencies, running tests, and deploying the app.

### Common GitHub Actions Commands

- Cache dependencies: `actions/cache@v4`
- Toolkit: `actions/toolkit`
- Glob pattern matching: `actions/glob`
- Checkout code: `actions/checkout@v4`
- Setup Node.js: `actions/setup-node`

## Runner Types

**GitHub-hosted runners**: GitHub offers hosted virtual machines to run workflows. Best for standard development tasks, such as running tests, building applications, and deploying to various environments; `ubuntu-latest`, `windows-latest`, or `macos-latest`

**Self-hosted runners**: This option offers more control over hardware, OS, and software tools than GitHub-hosted runners. With self-hosted runners they can be physical, virtual, in a container, on-premises, or in a cloud. [Documentation - Adding self-hosted runners to your repo.
](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/adding-self-hosted-runners)

## Artifacts in GitHub Actions

Artifacts allow you to persist data after a job has completed, and share that data with another job in the same workflow. An artifact is a file or collection of files produced during a workflow run. For example, you can use artifacts to save your build and test output after a workflow run has ended.

### Storing Artifacts

The `actions/upload-artifact` action enables you to store artifacts within the workflow, while `actions/download-artifact` retrieves them for later use.

### Example of uploading an artifact:

```
- name: Upload build output
  uses: actions/upload-artifact@v4
  with:
    name: build-output
    path: ./build/
```

### Example of downloading an artifact in another job:

```
- name: Download build output
  uses: actions/download-artifact@v4
  with:
    name: build-output
    path: ./build/
```

Artifacts are stored temporarily and are available for download for up to **90 days** (configurable) from the Actions or repository settings tab.

## Conditions and Expressions

GitHub Actions allows us to control job or step execution with conditional logic using expressions. Conditions are set using the `if` keyword. [Documentation](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/evaluate-expressions-in-workflows-and-actions)

### Example Conditional Job Execution:

The step below will only run if the workflow is triggered on the main branch:

```
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Run tests
        run: npm test
      - name: Deploy only on the main branch
        if: github.ref == 'refs/heads/main'
        run: echo "Deploying because we're on the main branch."
```

## Matrix Strategy

A **matrix strategy** allows you to run multiple variations of a job across different operating systems, environments, or configurations, in parallel. This is useful when you need to test against different versions of a language, dependencies, or platforms.

```
jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: [14, 16, 18]
        os: [ubuntu-latest, windows-latest]
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test
```

## Custom Actions in GitHub

GitHub Actions allows us to create our own custom actions, which can be reused across workflows. You can package scripts, Docker containers, or JavaScript code to handle custom operations. There are three types of actions:

- **Docker Actions**: Actions packaged in a Docker container.
- **JavaScript Actions**: Actions that execute JavaScript code directly in the workflow runner.<br>
- **Composite Actions**: Actions that combine multiple actions or steps into a reusable workflow component.

![custom actions](./assets/custom%20actions.png)

### Example of a Custom JavaScript Action:

```
// index.js
const core = require('@actions/core');

async function run() {
  try {
    const input = core.getInput('my-input');
    core.setOutput('my-output', `Hello ${input}`);
  } catch (error) {
    core.setFailed(error.message);
  }
}

run();
```

### Define the action in action.yml:

```
name: "Greet Action"
description: "Outputs a greeting"
inputs:
  my-input:
    description: "The input for the greeting"
    required: true
outputs:
  my-output:
    description: "The output greeting"
runs:
  using: "node16"
  main: "index.js"
```

### To use this action in a workflow:

```
jobs:
  greet:
    runs-on: ubuntu-latest
    steps:
      - name: Run custom action
        uses: ./actions
        with:
          my-input: "World"
```

## Reusable Workflows

Reusable workflows allow you to define a workflow in one repository and call it from other repositories or workflows. This promotes code reuse and helps keep your workflows DRY (Don’t Repeat Yourself) - [Documentation](https://docs.github.com/en/actions/sharing-automations/reusing-workflows)

## Custom Actions vs Reusable Workflows

**Custom actions** are individual, self-contained units of code that automate a specific task within a GitHub Actions workflow. They can be written in JavaScript, Docker, or a Composite.

They allow developers to encapsulate specific logic, such as building a Docker image, linting code, or interacting with APIs, into reusable components. Custom actions can be shared across multiple workflows or repositories and are often published to the GitHub Marketplace.

Whereas **Reusable workflows** are complete workflow definitions that can be referenced from other workflows. Instead of duplicating logic across multiple repositories or workflows, you can define common workflow patterns in a central location and then reuse them across projects.

They allow you to share entire workflows across repositories without having to replicate the same YAML files. This promotes the DRY (Don't Repeat Yourself) principle, particularly for common tasks like building, testing, or deploying applications.

### Key Differences:

| Aspect     | Custom Actions                            | Reusable Workflows                                  |
| ---------- | ----------------------------------------- | --------------------------------------------------- |
| Scope      | Integrated into a workflow as a task      | Encapsulates multiple tasks (entire workflows)      |
| Usage      | Defined as individual steps within a job  | Called from other workflows using `uses` keyword    |
| Complexity | Performs a single function                | Can handle multiple steps and jobs                  |
| Structure  | Can be written in code (e.g., JS, Docker) | Defined purely in YAML (GitHub workflow format)     |
| Purpose    | Focused on individual task automation     | Focused on sharing and reusing complex workflows    |
| Examples   | Linting, testing, building an image       | Full CI/CD process, multi-step deployment workflows |

In summary, **custom actions** are ideal for reusing individual steps within workflows, while **reusable workflows** are meant to standardise and reuse complex, multi-step pipelines across different repositories.

## Production-Ready Workflow

I wrote this production-ready workflow to build and push a Docker image to AWS Elastic Container Registry (ECR). It is triggered manually using `workflow_dispatch`. The AWS credentials are configured securely in GitHub Secrets, ensuring the sensitive information is protected. Docker is used to build the image, which is then pushed to the ECR, and finllay the Docker image URL is outputed at the end for reference.

```
name: Build and Push Docker Image to ECR

on:
  workflow_dispatch:
    inputs:
      branch:
        description: "Branch to deploy"
        required: true
        default: "main"

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Configure AWS Credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: ${{ secrets.AWS_REGION }}

      - name: Log in to Amazon ECR
        id: login-ecr
        uses: aws-actions/amazon-ecr-login@v1

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2

      - name: Build Docker image
        run: |
          docker build -t rock-paper-scissors-app .
          docker tag rock-paper-scissors-app:latest ${{ steps.login-ecr.outputs.registry }}/rock-paper-scissors-app:latest

      - name: Push Docker image to ECR
        run: |
          docker push ${{ steps.login-ecr.outputs.registry }}/rock-paper-scissors-app:latest

      - name: Output image URL
        run: |
          echo "Image URL: ${{ steps.login-ecr.outputs.registry }}/rock-paper-scissors-app:latest"
```
