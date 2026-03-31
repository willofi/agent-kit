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

`architecture`는 아래 조합을 한 번에 출력합니다.

- `agents/core.md`
- `agents/coding.md`
- `agents/architecture.md`

### `ai-scaffold`

현재 프로젝트 디렉터리에 엔트리 문서를 생성합니다.

```bash
ai-scaffold agents
ai-scaffold claude
ai-scaffold all
```

생성 대상은 아래와 같습니다.

- `agents`: `AGENTS.md`
- `claude`: `CLAUDE.md`
- `all`: 둘 다 생성

이미 파일이 있으면 덮어쓰지 않습니다. 강제로 다시 만들고 싶다면 `--force`를 붙입니다.

```bash
ai-scaffold all --force
```

이 명령은 `templates/AGENTS.md`와 `templates/CLAUDE.md`를 바탕으로, `~/.agent-kit`의 공용 문서 경로를 참조하는 프로젝트 엔트리 파일을 만들어 줍니다. 저장소 루트의 `AGENTS.md`와 `CLAUDE.md`는 이 저장소 자체를 위한 문서이고, scaffold용 원본은 `templates/` 아래에서 따로 관리합니다.

생성된 파일은 바로 사용할 수 있는 generic 기본값을 포함하고, 나중에 구체화할 부분만 주석으로 남깁니다. 프로젝트 구조나 실행 명령을 아직 적지 않았더라도, 문서가 비어 있는 상태로 시작하지 않도록 하는 쪽을 기본값으로 둡니다. 필요할 때만 불러오는 task-specific 문서 목록도 함께 들어갑니다. 예를 들어 React, Next.js, client-side state 작업용 `agents/frontend.md`도 안내됩니다.

## 기본 사용 흐름

권장 흐름은 아래와 같습니다.

1. 이 저장소를 수정하거나 최신 상태로 맞춥니다.
2. `bash scripts/bootstrap.sh`를 다시 실행해 `~/.agent-kit`를 갱신합니다.
3. 사용할 AI 도구가 로컬 파일을 직접 읽을 수 있는지 판단합니다.
4. 읽을 수 있으면 필요한 문서 경로를 알려 주고 읽게 합니다.
5. 읽을 수 없거나 기준을 확실히 고정하고 싶으면 `ai-cat` 또는 `ai-pack` 출력 내용을 그대로 붙여 넣습니다.
6. 프로젝트별 엔트리 파일이 필요하면 `ai-scaffold`로 `AGENTS.md`나 `CLAUDE.md`를 생성합니다.

중요한 기준은 하나입니다. 경로를 전달하는 것보다, 실제 문서 내용이 전달되었는지가 더 중요합니다.

## 어떤 문서를 같이 쓰면 좋은가

- 기본 작업
  `agents/core.md` + `agents/coding.md`
- 프론트엔드 작업
  기본 작업 + `agents/frontend.md`
- 구조 변경이나 설계 검토
  기본 작업 + `agents/architecture.md`
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
- 프로젝트 엔트리 파일은 `ai-scaffold`로 생성한 뒤 프로젝트 정보만 얇게 덧붙입니다.
- 문서는 설명보다 의사결정을 바꾸는 문장 위주로 유지합니다.
- 길게 쓰기보다 짧고 재사용 가능하게 유지합니다.
- 규칙이 실제 결과를 바꾸지 못하면 과감하게 정리합니다.
