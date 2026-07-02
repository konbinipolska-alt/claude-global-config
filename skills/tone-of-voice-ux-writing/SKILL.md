---
name: tone-of-voice-ux-writing
description: Write or audit interface copy and brand voice — buttons, errors, empty states, forms, notifications, onboarding — so text reads as purposeful, consistent, and human rather than generic placeholder copy. Use when writing UI copy/microcopy, defining a brand voice, or reviewing existing copy for consistency.
---

# Tone of Voice & UX Writing

Words are interface material with the same weight as spacing and color —
they're not filled in after the design is "done." Every string a user reads
either helps them understand what to do next or gets in the way.

## Four quality standards

Hold every piece of UI copy to these:

- **Purposeful** — every string exists to help the user do something or
  understand something; cut anything that's there to fill space.
- **Concise** — say it in the fewest words that stay clear; the first draft
  is rarely the shortest correct version.
- **Conversational** — write the way a knowledgeable, respectful person
  would say it out loud, not the way a legal disclaimer or a system log
  would phrase it.
- **Clear** — no jargon the user wouldn't use themselves, no cleverness that
  costs comprehension.

## Voice vs. tone

Define these once per product, then apply consistently:

- **Voice** is constant: the personality that doesn't change screen to
  screen (formal vs. casual, playful vs. serious, terse vs. warm). Document
  it as 3–5 adjectives with a "we sound like X, not Y" contrast for each.
- **Tone** shifts with context: a success confirmation can be warmer than an
  error message, which should be calm and direct rather than apologetic or
  alarmed. The voice stays recognizable across both.

## Write from the user's side of the screen

Name things by what people control and recognize, never by how the system
is implemented — a person manages their *order*, not a `checkout_session`.
Use active voice: a control states exactly what happens when used ("Save
changes," not "Submit" or "OK"). Keep the same name for an action through
the whole flow — a button that says "Publish" should produce a confirmation
that says "Published," not "Success."

## Patterns for common components

- **Buttons/CTAs**: verb + object, states what happens ("Add to cart," not
  "Submit" or "Go"). Primary and secondary actions should never share
  ambiguous labels like "OK"/"Cancel" when a specific verb is available.
- **Errors**: state what happened, in plain terms, and how to fix it. No
  apologies, no vague "Something went wrong" when the actual cause is
  knowable. Never blame the user for a system failure.
- **Empty states**: an invitation to act, not a dead end — explain why it's
  empty and what the next step is, not just "No items found."
- **Forms**: labels describe the field's content, not instructions
  ("Email," not "Please enter your email address"); helper text only for
  genuinely non-obvious constraints (format, why it's needed).
- **Notifications/toasts**: past tense for confirmations ("Changes saved"),
  present/imperative for required action ("Update required").
- **Onboarding**: describe outcomes ("what you'll be able to do"), not
  system features ("what this button does").

## Deliverables

- **Voice definition** — adjectives + contrast pairs, if not already established for the project.
- **Copy** — actual strings, ready to paste into the interface/CMS, matching existing product terminology (check for a glossary/existing copy before inventing new terms for the same concept).
- **Audit findings** (when reviewing) — inconsistent terminology for the same action/object, system-speak leaking into user-facing text, vague errors, flagged with file:line.

## Sources

- Nielsen Norman Group — UX writing and microcopy research: nngroup.com
- Mailchimp Content Style Guide — widely-cited public example of a documented voice/tone system: styleguide.mailchimp.com
- Google Material Design — writing guidelines for UI text: m3.material.io/foundations/content-design
