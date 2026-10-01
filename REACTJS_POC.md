# POC: React CI Checks | Unit Testing

## Author Information

| **Author** | **Created On** | **Version** | **L0 Reviewer** | **L1 Reviewer** | **L2 Reviewer** |
| ---------------- | -------------------- | ----------------- | --------------------- | --------------------- | --------------------- |
| Amrendra         | 01-10-2026           | 1.0               | Shubham Rathi / Sunny | Shreya J / Nikita     | Piyush Upadhyay       |

---

# Table of Contents

1. [Introduction](#1-introduction)
2. [Pre-requisites](#2-pre-requisites)
3. [Step-by-Step Setup Guide](#3-step-by-step-setup-guide)
   - [3.1 Verify Application Structure](#31-verify-application-structure)
   - [3.2 Install Dependencies](#32-install-dependencies)
   - [3.3 Configure Unit Tests and Mocks](#33-configure-unit-tests-and-mocks)
   - [3.4 Execute Unit Tests](#34-execute-unit-tests)
   - [3.5 Generate and Analyze Code Coverage](#35-generate-and-analyze-code-coverage)
4. [Conclusion](#4-conclusion)
5. [Contact Information](#5-contact-information)
6. [References](#6-references)

---

# 1. Introduction

This Proof of Concept (POC) demonstrates Unit Testing for the React frontend application using Jest and Create React App.
It covers test creation, dependency mocking, test execution, code coverage analysis, and production build verification.

---

# 2. Pre-requisites

The following components are required to perform React unit testing:

| Requirement                   | Purpose                                                                         |
| ----------------------------- | ------------------------------------------------------------------------------- |
| **Node.js**             | JavaScript runtime required to run build and test scripts (v18+).               |
| **npm**                 | Package manager used to manage dependencies and trigger test commands.          |
| **React Application**   | Frontend codebase (`ot-go-webapp/frontend`) containing components under test. |
| **Jest via CRA**        | Built-in test runner provided by`react-scripts` using JSDOM.                  |
| **React Test Renderer** | Test utility used to render React components in memory.                         |

---

# 3. Step-by-Step Setup Guide

### 3.1 Verify Application Structure

Navigate to the frontend project directory:

```bash
cd /frontend
```

Verify that the target component file exists:

```bash
ls -l src/EmployeeList.js
```

Verify the existing test configuration in `package.json`:

```json
"scripts": {
  "test": "react-scripts test --env=jsdom"
}
```

Because Create React App includes Jest by default, no extra test runner installation is needed.

<img width="1902" height="951" alt="image" src="https://github.com/user-attachments/assets/7606ad5e-b1f5-4637-8689-aa1e64aede17" />


---

### 3.2 Install Dependencies

Install clean project dependencies using `npm ci`:

```bash
npm ci
```

Check the command exit status:

```bash
echo $?
```

Expected output:

```text
0
```

<img width="1853" height="116" alt="image" src="https://github.com/user-attachments/assets/ae39e158-1573-4a4b-a7cc-c9fd59ad3e8b" />


---

### 3.3 Configure Unit Tests and Mocks

Create the test file `src/EmployeeList.test.js` to test `src/EmployeeList.js`.

The test suite mocks the browser `fetch` function and third-party UI dependencies:

```javascript
// Mock browser fetch API
global.fetch = jest.fn(() =>
  Promise.resolve({
    json: () => Promise.resolve([])
  })
);

// Mock UI wrapper components
jest.mock('./SiteWrapper', () => ({ children }) => <div>{children}</div>);
jest.mock('tabler-react', () => ({
  Card: ({ children }) => <div>{children}</div>,
  Table: ({ children }) => <table>{children}</table>,
  Button: ({ children }) => <button>{children}</button>
}));
```

The test file implements **5 test cases**:

1. **Component Creation:** Verifies that the `EmployeeList` component mounts successfully.
2. **API Invocation:** Verifies that the component calls `/employee/search/all`.
3. **Successful API Response:** Verifies that returned employee data is stored in state and displayed.
4. **Empty API Response:** Verifies graceful handling when the API returns an empty list.
5. **API Failure Handling:** Verifies that the component handles API errors properly.

<img width="1867" height="863" alt="image" src="https://github.com/user-attachments/assets/1895a490-8fc2-40aa-a34a-4d4773ef83e6" />


---

### 3.4 Execute Unit Tests

Run the test suite in non-interactive CI mode:

```bash
npm test -- --watchAll=false
```

Expected output:

```text
PASS  src/EmployeeList.test.js

EmployeeList Unit Tests
  ✓ should create EmployeeList component successfully
  ✓ should call employee search API
  ✓ should display employee data returned by API
  ✓ should handle empty employee API response
  ✓ should handle API failure

Test Suites: 1 passed, 1 total
Tests:       5 passed, 5 total
Snapshots:   0 total
Time:        1.85 s
```

All 5 implemented unit tests passed successfully.

<img width="1542" height="449" alt="image" src="https://github.com/user-attachments/assets/3beab124-599f-4c93-bd93-92e106b8879e" />



---

### 3.5 Generate and Analyze Code Coverage

Generate the code coverage report using Jest:

```bash
npm test -- --coverage --watchAll=false
```

Coverage results for the tested component:

| File                      |  % Statements  |   % Branches   |  % Functions  |    % Lines    |      Status      |
| ------------------------- | :------------: | :------------: | :------------: | :------------: | :--------------: |
| **EmployeeList.js** | **100%** | **100%** | **100%** | **100%** | **Passed** |

The POC achieves **100% code coverage** for `EmployeeList.js`, exercising all statements, branches, and functions.

<img width="1728" height="889" alt="image" src="https://github.com/user-attachments/assets/9769fdf0-c0f4-4739-838e-b19764d58911" />


---


# 4. Conclusion

This Proof of Concept successfully demonstrated Unit Testing for the React frontend application. The test suite validated component rendering, API requests, success responses, and error handling with all 5 tests passing and achieving 100% coverage on `EmployeeList.js`.

**Chosen Tool:**
**Jest with Create React App (`react-scripts`)** is chosen for our React CI pipeline because it is already integrated, requires zero extra configuration, provides fast in-memory JSDOM testing, and includes built-in coverage reporting.

---

# 5. Contact Information

|        Name        |          Email Address          |
| :----------------: | :-----------------------------: |
| **Amrendra** | amrendra.snaatak@mygurukulam.co |

---

# 6. References

| Reference                     | Link                                                          |
| ----------------------------- | ------------------------------------------------------------- |
| **Jest**                | [Jest](https://jestjs.io/)                                     |
| **React**               | [React](https://react.dev/)                                    |
| **Create React App**    | [CRA](https://create-react-app.dev/)                           |
| **React Test Renderer** | [Renderer](https://legacy.reactjs.org/docs/test-renderer.html) |
| **npm Documentation**   | [npm](https://docs.npmjs.com/)                                 |
