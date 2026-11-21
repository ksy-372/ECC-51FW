# Do it! 스프링 부트 3 - 1~2장 실습

*Do it! 스프링 부트 3 백엔드 개발자 되기* 1장(스프링 부트 개요), 2장(MVC 패턴 이해와 실습) 실습 코드.

**이전 주차의 "스프링 입문"(인프런, 김영한) 프로젝트와는 별개의 새 교재/새 프로젝트**야. start.spring.io에서 새로 프로젝트를 만들어서 적용해야 함.

## 구성

```
src/main/java/com/example/firstproject
└── controller
    ├── FirstController.java      # 1장~2장: /hi, /bye 페이지
    └── SecondController.java     # 2장 셀프체크: /random-quote (랜덤 명언)

src/main/resources
├── static/hello.html                      # 1장: 정적 파일 "헬로 월드!"
├── application.properties                 # 한글 깨짐 방지 설정
└── templates
    ├── greetings.mustache                 # /hi 페이지
    ├── goodbye.mustache                   # /bye 페이지
    ├── quote.mustache                     # /random-quote 페이지
    └── layouts
        ├── header.mustache                # 공통 헤더(내비게이션 바)
        └── footer.mustache                # 공통 푸터(사이트 정보)
```

## 적용 방법

1. [start.spring.io](https://start.spring.io) 에서 새 프로젝트 생성
   - Project: `Gradle - Groovy`, Language: Java, Spring Boot: `3.x.x`, Packaging: Jar, Java: 17
   - groupId: `com.example`, artifactId: `firstproject`
   - Dependencies: `Spring Web`, `H2 Database`, `Mustache`, `Spring Data JPA`
2. 압축 풀어 받은 프로젝트에 이 폴더의 `src` 내용을 그대로 덮어쓰기(병합)
3. IntelliJ로 열어서 Gradle 동기화 후 `FirstprojectApplication` 실행
4. `http://localhost:8080` 접속해서 동작 확인

## 실행 확인 URL

| URL | 설명 |
|---|---|
| `/hello.html` | 정적 파일 "헬로 월드!" |
| `/hi` | 뷰 템플릿 + 모델 (헤더/푸터 레이아웃 적용) |
| `/bye` | 뷰 템플릿 + 모델 (헤더/푸터 레이아웃 적용) |
| `/random-quote` | 셀프체크 완성본 — 새로고침할 때마다 랜덤 명언 출력 |

## 참고

- 머스테치 파일 기본 위치는 `src/main/resources/templates`. 이 위치에 저장하면 자동으로 로딩됨
- `header.mustache`/`footer.mustache`는 부트스트랩 내비게이션 바·사이트 정보를 담은 레이아웃 템플릿 — `{{>layouts/header}}` 형식으로 다른 페이지에서 불러옴
- 한글이 깨져서 `???`로 보이면 `application.properties`의 `server.servlet.encoding.force=true` 설정이 있는지 확인
