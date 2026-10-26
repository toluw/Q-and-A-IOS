#!/bin/zsh
set -eu
cd "${0:A:h}/.."
qa_test_output=$(mktemp -d /tmp/qa-cart-tests.XXXXXX)
trap 'rm -rf "$qa_test_output"' EXIT
xcrun swiftc \
  -sdk "$(xcrun --sdk macosx --show-sdk-path)" \
  -target "$(uname -m)-apple-macosx14.0" -parse-as-library \
  'Q and A/Features/Cbt/Model/Exam.swift' \
  'Q and A/Features/Cbt/Model/CartExam.swift' \
  'Q and A/Features/Cbt/db/LegacyExamCartStore.swift' \
  Tests/CartStorageCompatibilityTests.swift \
  -o "$qa_test_output/cart-tests"
"$qa_test_output/cart-tests"
