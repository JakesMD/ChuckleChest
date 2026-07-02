# Localization

ChuckleChest supports multiple languages using Flutter's built-in `gen_l10n`
tooling and ARB files.

## Supported Locales

| Locale | Language |
| ------ | -------- |
| `en`   | English  |
| `de`   | German   |

## Two L10n Packages

Localization is split across two packages to match the layered architecture:

| Package | Class       | Scope                                               |
| ------- | ----------- | --------------------------------------------------- |
| `app/`  | `CAppL10n`  | UI strings — page titles, buttons, messages         |
| `ccore` | `CCoreL10n` | Shared strings — role names, date/number formatting |

Each has its own ARB files and generated output.

## ARB Files

```
app/lib/localization/arb/
├── intl_en.arb          -- English (template)
└── intl_de.arb          -- German

packages/core/lib/src/localization/arb/
├── intl_en.arb          -- English (template)
└── intl_de.arb          -- German
```

English (`intl_en.arb`) is the template file in both packages.

## Adding a New String

1. Add the key and English value to `intl_en.arb` (anywhere will do, the file
   will be automatically sorted later)
2. Add the translation to `intl_de.arb`
3. Run `hobnob dart:localize` to regenerate
4. Use in code via the context extensions

## Naming Convention

Keys use `pageName_component_detail` format:

```json
"editGemPage_addQuoteButton": "Add a quote"
"createChestPage_hint_chestName": "Chest name"
"collectionView_noGemsTitle": "No gems to show"
```

Generic keys shared across pages use short names: `cancel`, `delete`, `close`.

## Usage in Code

Access strings via context extensions:

```dart
// App strings
context.cAppL10n.editGemPage_addQuoteButton

// Core strings (roles, formatting)
context.cCoreL10n.userRole_owner
```

## Placeholders

ARB files support typed placeholders with ICU syntax:

```json
"changeAvatarPage_title": "Change photo for {year}",
"@changeAvatarPage_title": {
  "placeholders": {
    "year": { "type": "int" }
  }
}
```

```dart
context.cAppL10n.changeAvatarPage_title(2024)
```

## Date and Number Formatting

`ccore` provides locale-aware formatting extensions:

```dart
// Date formatting
myDate.cLocalize(context, dateFormat: CDateFormat.yearMonth)

// Number formatting
myNumber.cLocalize(context, decimalDigits: 2)

// Parse localized number string
"1.234,56".cToLocalizedNum(context)
```

## Adding a New Language

1. Create `intl_{locale}.arb` in both `app/` and `ccore` ARB directories
2. Translate all keys from `intl_en.arb`
3. Add the `Locale` to the `supportedLocales` list in `app.dart`
4. Run `hobnob dart:localize`

---

**See also:** [Architecture](Architecture) · [Hobnob](Hobnob)
