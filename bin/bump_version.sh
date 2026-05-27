#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration ---
YAML_FILE="app/pubspec.yaml"
HTML_FILE="app/web/index.html"

# Function to calculate and return the new version string, based on bump type.
# Arguments: $1 (BUMP_TYPE: major|minor|patch)
fetch_new_version() {
    local BUMP_TYPE="$1"

    if [[ -z "$BUMP_TYPE" || ! ("$BUMP_TYPE" == "major" || "$BUMP_TYPE" == "minor" || "$BUMP_TYPE" == "patch") ]]; then
        echo "Error: Invalid or missing bump type." >&2
        echo "Usage: $0 <major|minor|patch>" >&2
        exit 1
    fi
    
    if [ ! -f "$YAML_FILE" ]; then
        echo "Error: '$YAML_FILE' not found." >&2
        exit 1
    fi

    # Extract the current version line
    CURRENT_VERSION_LINE=$(grep -E '^version:[[:space:]]+[0-9]+\.[0-9]+\.[0-9]+' "$YAML_FILE" | head -n 1)

    if [ -z "$CURRENT_VERSION_LINE" ]; then
        echo "Error: Could not find a valid 'version: X.Y.Z' line in '$YAML_FILE'." >&2
        exit 1
    fi

    # Extract the semantic version part (ignoring build numbers if present)
    CURRENT_FULL_VERSION=$(echo "$CURRENT_VERSION_LINE" | awk '{print $2}')
    SEMANTIC_VERSION=$(echo "$CURRENT_FULL_VERSION" | cut -d'+' -f1)
    
    MAJOR=$(echo "$SEMANTIC_VERSION" | cut -d. -f1)
    MINOR=$(echo "$SEMANTIC_VERSION" | cut -d. -f2)
    PATCH=$(echo "$SEMANTIC_VERSION" | cut -d. -f3)

    NEW_MAJOR=$MAJOR
    NEW_MINOR=$MINOR
    NEW_PATCH=$PATCH

    # Increment the version components
    case "$BUMP_TYPE" in
        patch)
            NEW_PATCH=$((PATCH + 1))
            ;;
        minor)
            NEW_MINOR=$((MINOR + 1))
            NEW_PATCH=0
            ;;
        major)
            NEW_MAJOR=$((MAJOR + 1))
            NEW_MINOR=0
            NEW_PATCH=0
            ;;
        *)
            # Should not happen due to initial check
            echo "Error: Internal script error with bump type: $BUMP_TYPE" >&2
            exit 1 
            ;;
    esac

    local NEW_FULL_VERSION="$NEW_MAJOR.$NEW_MINOR.$NEW_PATCH"
    
    # Output the new calculated version for the calling script to capture
    echo "$NEW_FULL_VERSION"
}


# Function to update the version in the pubspec.yaml file.
# Arguments: $1 (NEW_FULL_VERSION: X.Y.Z)
update_pubspec() {
    local NEW_FULL_VERSION="$1"

    if [ ! -f "$YAML_FILE" ]; then
        echo "Error: '$YAML_FILE' not found." >&2
        exit 1
    fi

    # Use perl for in-place text replacement to modify the version line
    perl -pi -e "s/^(version:)\s*([0-9]+\.[0-9]+\.[0-9]+.*)$/\1 ${NEW_FULL_VERSION}/" "$YAML_FILE"

    if [ $? -ne 0 ]; then
        echo "Error: Failed to modify the version line in '$YAML_FILE'." >&2
        exit 1
    fi
}


# Function to update the version query parameter in index.html.
# Arguments: $1 (NEW_FULL_VERSION: X.Y.Z)
update_html() {
    local NEW_FULL_VERSION="$1"

    if [ -f "$HTML_FILE" ]; then
        # Convert X.Y.Z to X_Y_Z for the query parameter
        local NEW_HTML_VERSION=$(echo "$NEW_FULL_VERSION" | tr '.' '_')

        perl -pi -e "s,flutter_bootstrap\.js\?v=[0-9_]*,flutter_bootstrap.js?v=${NEW_HTML_VERSION},g" "$HTML_FILE"
        
        if [ $? -ne 0 ]; then
            echo "Error: Failed to find or modify the version query parameter 'v=X_Y_Z' in '$HTML_FILE'. Check if the script tag exists." >&2
            exit 1
        fi
    else
        echo "Error: '$HTML_FILE' not found." >&2
        exit 1
    fi
}


# --- Execution Block ---
BUMP_TYPE="$1"

NEW_VERSION=$(fetch_new_version "$BUMP_TYPE")

update_pubspec "$NEW_VERSION"
update_html "$NEW_VERSION"

echo "$NEW_VERSION"