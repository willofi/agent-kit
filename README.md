# agent-kit

`agent-kit`은 여러 프로젝트와 여러 AI 도구에서 공통으로 재사용할 수 있는 운영 기준 문서 모음입니다.

목표는 단순합니다. 긴 지침을 매번 새로 쓰지 않고, 필요한 문서만 조합해서 같은 기준으로 작업하게 만드는 것입니다.

## 구성

- `agents/`
  기본 작업 방식과 판단 기준
- `prompts/`
  리팩터링, 디버깅, 리뷰 같은 작업별 프롬프트
- `rules/`
  네이밍, Git 같은 팀 규칙
- `cursor/`
  Cursor용 짧은 규칙 문서
- `templates/`
  새 프로젝트에 복사할 엔트리 문서 템플릿
- `specs/`
  이 저장소 자체의 spec-driven 작업 산출물
- `bin/`
  bootstrap 후 바로 쓰는 `ai-*` 명령
- `scripts/`
  로컬 설치와 갱신용 스크립트

이 저장소의 문서는 짧고 조합 가능해야 합니다. 하나의 거대한 프롬프트보다, 필요한 기준만 선택해서 붙이는 쪽을 기본 사용 방식으로 봅니다.

## 설치와 갱신

저장소를 원하는 브랜치나 커밋 상태로 checkout한 뒤 아래 명령어를 실행합니다.

```bash
bash scripts/bootstrap.sh
```

이 스크립트는 현재 checkout된 저장소 내용을 그대로 `~/.agent-kit`에 동기화합니다.

- 원격 저장소를 직접 clone 하거나 pull 하지 않습니다.
- 지금 로컬에서 보고 있는 버전이 그대로 설치됩니다.
- 문서를 수정했거나 `git pull`로 최신 상태를 받았다면, 다시 실행하면 됩니다.

스크립트는 셸 시작 파일도 함께 갱신합니다.

- `zsh`: `~/.zshrc`
- `bash`: `~/.bashrc` 또는 `~/.bash_profile`
- `.profile`을 읽는 POSIX 셸: `~/.profile`

추가되는 항목은 아래 두 가지입니다.

- `AGENT_KIT_PATH`
- `~/.agent-kit/bin` PATH 등록

그 결과 아래 명령을 셸에서 바로 사용할 수 있게 됩니다.

- `ai-context`
- `ai-cat`
- `ai-pack`
- `ai-scaffold`

설치 후에는 스크립트가 안내한 셸 설정 파일을 다시 불러옵니다.

```bash
source ~/.zshrc
# 또는 source ~/.bashrc
# 또는 source ~/.bash_profile
# 또는 source ~/.profile
```

사용 중인 셸이 위 파일을 자동으로 읽지 않는다면 아래 두 줄을 해당 셸 설정에 맞게 직접 추가하면 됩니다.

```sh
export AGENT_KIT_PATH="$HOME/.agent-kit"
case ":$PATH:" in
  *":$AGENT_KIT_PATH/bin:"*) ;;
  *) export PATH="$AGENT_KIT_PATH/bin:$PATH" ;;
esac
```

## 설치되는 명령

### `ai-context`

설치된 문서 목록을 보여줍니다.

```bash
ai-context
```

출력 대상은 `agents/`, `prompts/`, `rules/`, `cursor/` 아래의 문서 파일입니다.

### `ai-cat`

지정한 문서 내용을 그대로 출력합니다.

```bash
ai-cat agents/core.md agents/coding.md
```

여러 파일을 한 번에 넘길 수 있고, 파일 사이에는 구분선이 들어갑니다. 로컬 파일을 직접 읽지 못하는 AI 도구에 문서 내용을 붙여 넣을 때 가장 유용합니다.

### `ai-pack`

자주 쓰는 문서 조합을 프리셋 이름으로 꺼냅니다.

```bash
ai-pack frontend
ai-pack backend
ai-pack sdd
ai-pack review
ai-pack refactor
ai-pack debug
ai-pack architecture
ai-pack review-strict
```

지원하는 프리셋 목록만 보고 싶다면 아래처럼 실행합니다.

```bash
ai-pack list
```

대상 파일 경로를 뒤에 붙이면, 문서 출력 뒤에 템플릿 형태로 함께 정리해 줍니다.

```bash
ai-pack review src/api/session.ts src/store/authStore.ts
```

예를 들어 `review`는 아래 조합을 한 번에 출력합니다.

- `agents/core.md`
- `agents/coding.md`
- `prompts/review.md`
- `rules/naming.md`

`frontend`는 아래 조합을 한 번에 출력합니다.

- `agents/core.md`
- `agents/coding.md`
- `agents/frontend.md`

`backend`는 아래 조합을 한 번에 출력합니다.

- `agents/core.md`
- `agents/coding.md`
- `agents/backend.md`

`architecture`는 아래 조합을 한 번에 출력합니다.

- `agents/core.md`
- `agents/coding.md`
- `agents/architecture.md`

`sdd`는 Kiro-style spec-driven 작업 기준을 아래 조합으로 출력합니다.

- `agents/core.md`
- `agents/coding.md`
- `agents/architecture.md`
- `agents/sdd.md`

### `ai-scaffold`

현재 프로젝트 디렉터리에 엔트리 문서를 생성합니다.

```bash
ai-scaffold agents
ai-scaffold claude
ai-scaffold all
ai-scaffold list
```

생성 대상은 아래와 같습니다.

- `agents`: `AGENTS.md`
- `claude`: `CLAUDE.md`
- `all`: 둘 다 생성
- `list`: 지원 대상 출력

이미 파일이 있으면 덮어쓰지 않습니다. 강제로 다시 만들고 싶다면 `--force`를 붙입니다.

```bash
ai-scaffold all --force
```

이 명령은 `templates/AGENTS.md`와 `templates/CLAUDE.md`를 바탕으로, `~/.agent-kit`의 공용 문서 경로를 참조하는 프로젝트 엔트리 파일을 만들어 줍니다. 저장소 루트의 `AGENTS.md`와 `CLAUDE.md`는 이 저장소 자체를 위한 문서이고, scaffold용 원본은 `templates/` 아래에서 따로 관리합니다.

생성된 파일은 바로 사용할 수 있는 generic 기본값을 포함하고, 나중에 구체화할 부분만 주석으로 남깁니다. 프로젝트 구조나 실행 명령을 아직 적지 않았더라도, 문서가 비어 있는 상태로 시작하지 않도록 하는 쪽을 기본값으로 둡니다. 필요할 때만 불러오는 task-specific 문서 목록도 함께 들어갑니다. 예를 들어 React, Next.js, client-side state 작업용 `agents/frontend.md`, API, DB, server-side logic 작업용 `agents/backend.md`, 비사소한 spec-driven 작업용 `agents/sdd.md`도 안내됩니다. scaffold 기본값에는 non-trivial code 주석 범위, late-MVP 스펙 정합성 리뷰, Docker Compose root env와 per-app env 구분, Playwright 기반 E2E 검증 명시 여부 같은 실무 steering도 generic 형태로 포함됩니다.

`ai-scaffold`는 `.kiro/`나 `specs/` 템플릿을 생성하지 않습니다. 공통 작업 규칙은 `agents/sdd.md`에서 관리하고, 실제 프로젝트별 spec 산출물은 각 프로젝트 안의 `specs/<feature>/requirements.md`, `design.md`, `tasks.md`처럼 작업 단위로 직접 만듭니다.

## Spec-driven 작업 흐름

비사소한 기능 추가, 설계 변경, 복잡한 버그 수정, 회귀 위험이 큰 작업은 `agents/sdd.md`를 함께 사용합니다. 기본 흐름은 아래와 같습니다.

1. `requirements.md`에 사용자 관찰 동작과 제약을 `REQ-001` 같은 ID와 EARS 스타일로 정리합니다.
2. `design.md`에 관련 요구사항, 구조 변경, 인터페이스, 오류 처리, 테스트 전략을 정리합니다.
3. `tasks.md`에 작은 체크박스 task와 검증 기준을 작성합니다.
4. 사용자가 승인하거나 명확히 구현을 지시한 뒤 task 순서대로 구현합니다.
5. 각 task가 구현과 검증까지 끝나면 즉시 `tasks.md`의 체크박스를 갱신합니다.

명백한 오타, 작은 문서 수정, 단순 설정 변경, 명확한 1파일 수정은 Quick Fix로 처리할 수 있습니다. 작업 범위가 커지면 spec-driven 흐름으로 전환합니다.

## 기본 사용 흐름

권장 흐름은 아래와 같습니다.

1. 이 저장소를 수정하거나 최신 상태로 맞춥니다.
2. `bash scripts/bootstrap.sh`를 다시 실행해 `~/.agent-kit`를 갱신합니다.
3. 사용할 AI 도구가 로컬 파일을 직접 읽을 수 있는지 판단합니다.
4. 읽을 수 있으면 필요한 문서 경로를 알려 주고 읽게 합니다.
5. 읽을 수 없거나 기준을 확실히 고정하고 싶으면 `ai-cat` 또는 `ai-pack` 출력 내용을 그대로 붙여 넣습니다.
6. 프로젝트별 엔트리 파일이 필요하면 `ai-scaffold`로 `AGENTS.md`나 `CLAUDE.md`를 생성합니다.
7. 비사소한 작업은 `ai-pack sdd` 또는 `agents/sdd.md`를 사용해 `requirements.md`, `design.md`, `tasks.md`를 먼저 정리합니다.

중요한 기준은 하나입니다. 경로를 전달하는 것보다, 실제 문서 내용이 전달되었는지가 더 중요합니다.

## 로컬과 프로젝트에 적용하기

agent-kit을 수정한 뒤 내 컴퓨터의 전역 기준으로 반영하려면 agent-kit 저장소에서 bootstrap을 다시 실행합니다.

```bash
cd /path/to/agent-kit
bash scripts/bootstrap.sh
source ~/.zshrc
```

설치가 반영되었는지는 아래처럼 확인합니다.

```bash
ai-pack list
ai-pack sdd
```

특정 프로젝트에 agent-kit 기준을 적용하려면 그 프로젝트 루트에서 scaffold를 실행합니다.

```bash
cd /path/to/project
ai-scaffold all
```

이 명령은 `AGENTS.md`와 `CLAUDE.md`를 생성합니다. 이미 같은 파일이 있으면 덮어쓰지 않으므로, 기존 파일이 있는 프로젝트에서는 생성된 템플릿을 그대로 덮기보다 `agents/sdd.md` 참조와 spec-driven 작업 흐름만 기존 지침에 합치는 편이 안전합니다.

비사소한 작업을 시작할 때는 프로젝트 안에 작업별 spec 디렉터리를 만듭니다.

```text
specs/<feature-name>/
  requirements.md
  design.md
  tasks.md
```

AI에게는 보통 이렇게 요청하면 됩니다.

```text
agents/sdd.md 흐름으로 이 작업을 진행해줘.
먼저 specs/<feature-name>/requirements.md, design.md, tasks.md를 만들고,
tasks.md가 승인되면 task별로 구현하면서 완료 시 체크박스도 갱신해줘.
```

## 어떤 문서를 같이 쓰면 좋은가

- 기본 작업
  `agents/core.md` + `agents/coding.md`
- 프론트엔드 작업
  기본 작업 + `agents/frontend.md`
- 백엔드 작업
  기본 작업 + `agents/backend.md`
- 구조 변경이나 설계 검토
  기본 작업 + `agents/architecture.md`
- spec-driven 기능/설계 작업
  기본 작업 + `agents/architecture.md` + `agents/sdd.md`
- 리팩터링
  기본 작업 + `prompts/refactor.md`
- 디버깅
  기본 작업 + `prompts/debug.md`
- 코드 리뷰
  기본 작업 + `prompts/review.md`
- 팀 규칙까지 반영
  필요한 작업 문서 + `rules/naming.md` + `rules/git.md`

예를 들어 코드 리뷰 기준을 묶어서 출력하려면 아래처럼 사용합니다.

```bash
ai-pack review
```

대상 파일까지 같이 붙이고 싶다면 이렇게 사용할 수 있습니다.

```bash
ai-pack review src/api/session.ts src/store/authStore.ts
```

그리고 그 출력 결과 뒤에 실제 diff나 추가 설명을 붙이면 됩니다.

## 도구별 사용 메모

### Cursor

`cursor/rules.md` 내용을 User Rules 또는 Project Rules에 넣는 방식이 가장 단순합니다.

다만 Cursor가 `~/.agent-kit`를 항상 자동으로 읽는다고 가정하지 않는 편이 안전합니다. 세션 초반 기준을 확실히 고정하고 싶다면 `ai-cat`이나 `ai-pack`으로 필요한 내용을 직접 넣는 편이 더 재현성이 높습니다.

### Claude, ChatGPT, 기타 채팅형 도구

로컬 파일 접근이 불확실하면 경로만 보내지 말고 `ai-cat` 또는 `ai-pack` 출력 내용을 직접 붙여 넣는 방식을 기본값으로 두는 것이 좋습니다.

### Codex 같은 로컬 작업형 도구

같은 워크스페이스를 직접 읽을 수 있는 환경이라면 `~/.agent-kit/...` 경로를 읽게 할 수 있습니다. 그래도 세션 기준을 확실히 고정하고 싶다면 `ai-pack review`처럼 작업 단위 프리셋을 쓰는 편이 더 안정적입니다.

## 운영 원칙

- 공통 규칙은 이 저장소에서 관리합니다.
- 프로젝트별 예외는 각 프로젝트 내부 문서에서 관리합니다.
- SDD 프로토콜은 공통 규칙이고, 개별 `requirements.md`, `design.md`, `tasks.md`는 프로젝트별 작업 산출물입니다.
- 프로젝트 엔트리 파일은 `ai-scaffold`로 생성한 뒤 프로젝트 정보만 얇게 덧붙입니다.
- 문서는 설명보다 의사결정을 바꾸는 문장 위주로 유지합니다.
- 길게 쓰기보다 짧고 재사용 가능하게 유지합니다.
- 규칙이 실제 결과를 바꾸지 못하면 과감하게 정리합니다.
