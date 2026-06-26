# agent-kit

`agent-kit`은 여러 프로젝트와 AI 도구에서 재사용할 수 있는 운영 기준
문서 모음입니다.

목표는 프로젝트마다 긴 지침을 다시 쓰지 않는 것입니다. 재사용 규칙은 이
저장소에 두고, 프로젝트별 사실은 각 프로젝트의 엔트리 파일에 얇게 둡니다.

## 구성

- `agents/`: baseline, coding, SDD, frontend, backend, architecture 지침
- `prompts/`: review, refactor, debug 작업 프롬프트
- `rules/`: naming, Git 같은 공통 규칙
- `cursor/`: Cursor용 adapter 규칙
- `skills/`: Codex, Claude 등에 설치할 수 있는 portable `SKILL.md`
- `templates/`: `ai-scaffold`가 사용하는 generic `AGENTS.md`, `CLAUDE.md`
- `bin/`: 설치 후 사용하는 `ai-context`, `ai-cat`, `ai-pack`, `ai-scaffold`, `ai-skill`
- `scripts/`: bootstrap, scaffold, smoke-test 자동화
- `specs/`: 이 저장소 자체의 spec-driven 작업 산출물

문서는 짧고 조합 가능해야 합니다. 실제 agent 행동을 바꾸지 못하는 설명은
과감하게 줄입니다.

## 설치와 갱신

설치하려는 checkout 상태에서 bootstrap을 실행합니다.

```bash
bash scripts/bootstrap.sh
```

bootstrap은 현재 checkout을 그대로 `~/.agent-kit`에 동기화합니다. 원격
저장소를 clone하거나 pull하지 않습니다. 이 저장소를 수정하거나 업데이트한
뒤에는 다시 실행하면 됩니다.

스크립트는 현재 셸에 맞춰 시작 파일도 갱신합니다.

- `zsh`: `~/.zshrc`
- `bash`: `~/.bashrc` 또는 `~/.bash_profile`
- 그 외 POSIX 계열 셸: `~/.profile`

설치 후 bootstrap이 안내한 파일을 다시 불러옵니다.

```bash
source ~/.zshrc
```

사용 중인 셸이 위 파일을 읽지 않는다면 아래 블록을 직접 추가합니다.

```sh
export AGENT_KIT_PATH="$HOME/.agent-kit"
case ":$PATH:" in
  *":$AGENT_KIT_PATH/bin:"*) ;;
  *) export PATH="$AGENT_KIT_PATH/bin:$PATH" ;;
esac
```

## 명령

### `ai-context`

설치된 context 문서를 나열합니다. 대상은 `agents/`, `prompts/`, `rules/`,
`cursor/`입니다.

```bash
ai-context
```

### `ai-cat`

문서 하나 이상을 구분선과 함께 출력합니다. 로컬 파일을 직접 읽지 못하는 AI
도구에 context를 붙여 넣을 때 사용합니다.

```bash
ai-cat agents/core.md agents/coding.md
```

### `ai-pack`

자주 쓰는 문서 조합을 preset으로 출력합니다.

```bash
ai-pack list
ai-pack frontend
ai-pack backend
ai-pack sdd
ai-pack review
ai-pack review-strict
ai-pack refactor
ai-pack debug
ai-pack architecture
```

Preset 구성:

- `frontend`: `agents/core.md`, `agents/coding.md`, `agents/frontend.md`
- `backend`: `agents/core.md`, `agents/coding.md`, `agents/backend.md`
- `architecture`: `agents/core.md`, `agents/coding.md`, `agents/architecture.md`
- `sdd`: `agents/core.md`, `agents/coding.md`, `agents/architecture.md`, `agents/sdd.md`
- `review`: `agents/core.md`, `agents/coding.md`, `prompts/review.md`, `rules/naming.md`
- `review-strict`: `review` + `rules/git.md`
- `refactor`: `agents/core.md`, `agents/coding.md`, `prompts/refactor.md`
- `debug`: `agents/core.md`, `agents/coding.md`, `prompts/debug.md`

대상 파일 경로를 뒤에 붙이면 간단한 작업 대상 목록도 함께 출력합니다.

```bash
ai-pack review src/api/session.ts src/store/authStore.ts
```

### `ai-scaffold`

`templates/`를 바탕으로 프로젝트 엔트리 파일을 생성합니다.

```bash
ai-scaffold agents
ai-scaffold claude
ai-scaffold all
ai-scaffold list
```

생성 대상:

- `agents`: `AGENTS.md`
- `claude`: `CLAUDE.md`
- `all`: 둘 다 생성
- `list`: 생성 가능한 대상 출력

기존 파일은 덮어쓰지 않습니다. 강제로 다시 만들려면 `--force`를 붙입니다.

```bash
ai-scaffold all --force
```

`ai-scaffold`는 엔트리 파일만 생성합니다. `.kiro/`나 `specs/` 디렉터리는
만들지 않습니다. 프로젝트별 SDD 산출물은 필요한 작업 시점에 해당 프로젝트
안에서 직접 만듭니다.

생성된 파일은 바로 사용할 수 있는 generic 기본값을 포함합니다. scaffold
기본값에는 non-trivial code 주석 범위, late-MVP 스펙 정합성 리뷰, Docker
Compose root env와 per-app env 구분, Playwright 기반 E2E 검증 명시 여부 같은
실무 steering도 generic 형태로 포함됩니다.

### `ai-skill`

`skills/` 아래의 portable skill을 Codex나 Claude 경로에 설치합니다.

```bash
ai-skill list
ai-skill install sdd-workflow codex
ai-skill install sdd-workflow claude
ai-skill install sdd-workflow all
```

개인 설치 대상:

- Codex: `${CODEX_HOME:-$HOME/.codex}/skills/<skill>`
- Claude: `$HOME/.claude/skills/<skill>`

현재 프로젝트에만 설치하려면 `--project`를 붙입니다.

```bash
ai-skill install sdd-workflow all --project
```

기존 skill은 덮어쓰지 않습니다. 교체하려면 `--force`를 붙입니다.

## Spec-Driven 작업

비사소한 기능, 설계 변경, 복잡한 버그 수정, 회귀 위험이 큰 작업은
`agents/sdd.md`를 사용합니다. SDD의 단일 출처는 `agents/sdd.md`입니다.

그 문서가 정의하는 내용:

- SDD와 Quick Fix 사용 기준
- `requirements.md`, `design.md`, `tasks.md` 기대사항
- 구현 전 승인 기준
- 검증된 task의 checkbox 갱신
- 구현 중 spec이 바뀔 때의 drift 처리

일반적인 프로젝트 산출물 구조:

```text
specs/<feature-name>/
  requirements.md
  design.md
  tasks.md
```

AI에게는 보통 이렇게 요청합니다.

```text
agents/sdd.md 흐름으로 이 작업을 진행해줘.
먼저 specs/<feature-name>/requirements.md, design.md, tasks.md를 만들거나 갱신하고,
task plan 승인 후 task별로 구현하면서 검증된 항목의 checkbox를 갱신해줘.
```

오타, 작은 문서 수정, 단순 설정 변경, 명확한 1파일 수정은 Quick Fix로 처리할
수 있습니다.

자주 쓰는 도구에는 SDD workflow skill을 설치해 둘 수 있습니다.

```bash
ai-skill install sdd-workflow all
```

## 프로젝트에 적용하기

권장 흐름:

1. 이 저장소를 원하는 상태로 업데이트합니다.
2. `bash scripts/bootstrap.sh`를 실행합니다.
3. `ai-context` 또는 `ai-pack list`로 설치 상태를 확인합니다.
4. 필요하면 `ai-skill install sdd-workflow all`로 개인 skill을 설치합니다.
5. 대상 프로젝트에 엔트리 파일이 없으면 `ai-scaffold all`을 실행합니다.
6. 생성된 엔트리 파일에 프로젝트 구조, 명령, 위험 지점, 제약을 추가합니다.

대상 프로젝트에 이미 `AGENTS.md`나 `CLAUDE.md`가 있다면 그대로 덮어쓰지
말고, 필요한 shared-doc 참조와 SDD 지침만 합치는 편이 안전합니다.

## 어떤 문서를 쓸지

- 기본 작업: `agents/core.md` + `agents/coding.md`
- 프론트엔드: 기본 작업 + `agents/frontend.md`
- 백엔드: 기본 작업 + `agents/backend.md`
- 구조/경계 변경: 기본 작업 + `agents/architecture.md`
- Spec-driven 작업: 기본 작업 + `agents/architecture.md` + `agents/sdd.md`
- 리뷰: 기본 작업 + `prompts/review.md` + `rules/naming.md`
- Git 규칙까지 보는 엄격한 리뷰: 리뷰 문서 + `rules/git.md`
- 리팩터링: 기본 작업 + `prompts/refactor.md`
- 디버깅: 기본 작업 + `prompts/debug.md`

AI 도구가 로컬 파일을 읽을 수 있는지 불확실하면 경로만 전달하지 말고
`ai-cat` 또는 `ai-pack` 출력 내용을 전달하는 편이 더 재현성이 높습니다.

## 도구별 메모

- Cursor: `cursor/rules.md`를 User Rules 또는 Project Rules에 넣습니다.
  세션 context를 고정하려면 `ai-pack`을 사용합니다.
- Claude, ChatGPT 등 채팅형 도구: 로컬 파일 접근이 없으면 `ai-cat` 또는
  `ai-pack` 출력을 붙여 넣습니다.
- 로컬 coding agent: 로컬 파일을 읽을 수 있으면 `~/.agent-kit/...` 경로를
  전달하고, context를 명시적으로 고정하려면 preset을 사용합니다.

## 운영 원칙

- 공통 규칙은 이 저장소에서 관리합니다.
- 프로젝트별 예외는 각 프로젝트 안에서 관리합니다.
- SDD 프로토콜은 `agents/sdd.md`에 두고, 실제 spec은 각 프로젝트의
  `specs/<feature>/`에 둡니다.
- 엔트리 파일은 얇고 프로젝트별이어야 합니다.
- README 예시, preset, template, CLI 동작은 같은 변경 안에서 맞춥니다.
