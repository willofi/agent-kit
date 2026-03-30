# Debug Prompt

Use this prompt when you want an AI assistant to diagnose a bug methodically instead of guessing.

## Prompt

Debug the following issue with a strong bias toward root cause analysis.

Goals:

- identify the most likely root cause
- explain how the failure happens
- separate confirmed facts from assumptions
- propose the smallest fix likely to solve the real problem
- describe how to verify the fix

Instructions:

- summarize the symptoms first
- rank the most plausible hypotheses
- narrow them using the available evidence
- explain the failure mechanism before changing code
- call out missing information that would materially change the diagnosis

Output format:

1. Symptom summary
2. Likely root cause
3. Step-by-step reasoning
4. Recommended fix
5. Verification plan
6. Any follow-up hardening worth doing after the issue is resolved

Issue details:

```text
# paste logs, errors, reproduction steps, or code here
```
