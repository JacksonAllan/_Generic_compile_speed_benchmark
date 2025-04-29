#!/bin/bash

echo "Outputting build times (best of five):"

declare -a gcc=(
  "gcc _Generic.c -O1 -std=c11 -o temp/out"
  "gcc _Generic.c -O3 -std=c11 -o temp/out"
)

declare -a clang=(
  "clang _Generic.c -O1 -std=c11 -o temp/out"
  "clang _Generic.c -O3 -std=c11 -o temp/out"
)

for arg in "$@"; do
  if ! declare -p "$arg" &>/dev/null; then
    echo "Unrecognized compiler ${arg}"
    exit 1
  fi
done

# Create temp directory
mkdir -p temp || { echo "Failed to create temp directory." >&2; exit 1; }

for arg in "$@"; do
  commands_var="$arg[@]"
  commands=("${!commands_var}")

  for compileCommand in "${commands[@]}"; do
    bestTime=9223372036854775807  # Largest 64-bit integer

    for i in {1..5}; do
      startTime=$(date +%s%N)  # Time in nanoseconds
      eval "$compileCommand" &> /dev/null
      endTime=$(date +%s%N)
      elapsed=$((endTime - startTime))
      if ((elapsed < bestTime)); then
        bestTime=$elapsed
      fi
    done

    # Convert nanoseconds to seconds and hundredths of a second
    seconds=$((bestTime / 1000000000))
    hundredths=$(( (bestTime % 1000000000) / 10000000 ))
    if (( hundredths < 10 )); then
      hundredths="0$hundredths"
    fi

    printf "  %s: %s.%ss\n" "$compileCommand" "$seconds" "$hundredths"
  done
done

rm -rf temp