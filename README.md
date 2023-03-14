# Luiz Negrini's Pub Api challange

An app that uses the Pub Api Client package to retrieve data from pub.dev oficial site.

## SETUP

### 0 Install Flutter Framework

[See docs here.](https://docs.flutter.dev/get-started/install)


## **1. Tests**

To maintain organization, each test file must be created in the same folder structure as the file being tested. Example:

```bash
# Implementation
/lib
  /domain
    /usecases
      /XYZ_test.dart

# Test
/test
  /domain
    /usecases
      /XYZ_test.dart
```

## **2. Standards and best practices**

Project configured with [Flutter Lints](https://pub.dev/packages/flutter_lints) package.

## **3. Critique**

As a main criticism it would increase test coverage and perform more different types of tests.

Having better error handling is a must, and it's one of the things I would improve on the project.

I didn't find it necessary to create microapps for this project for now, if in the future it is necessary, it will be possible to separate dependencies in another microapp (making the project a monorepo) and also separating each feature in its microapp.