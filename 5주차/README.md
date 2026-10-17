# 스프링 입문 - 1~3장 실습

인프런 강의 *스프링 입문 - 코드로 배우는 스프링 부트, 웹 MVC, DB 접근 기술* (김영한) 1장(프로젝트 환경설정), 2장(스프링 웹 개발 기초), 3장(회원 관리 예제 - 백엔드 개발) 실습 코드.

## 구성

```
src
├── main
│   ├── java/hello/hellospring
│   │   ├── controller/HelloController.java      # 2장: 정적 컨텐츠 제외 전체 핸들러(hello, hello-mvc, hello-string, hello-api)
│   │   ├── domain/Member.java                   # 3장: 회원 도메인
│   │   ├── repository/MemberRepository.java      # 3장: 리포지토리 인터페이스
│   │   ├── repository/MemoryMemberRepository.java # 3장: 메모리 기반 구현체
│   │   └── service/MemberService.java            # 3장: 회원 서비스(가입, 조회, 중복 검증)
│   └── resources
│       ├── static/index.html           # 1장: Welcome Page
│       ├── static/hello-static.html    # 2장: 정적 컨텐츠
│       └── templates/hello.html, hello-template.html  # 1~2장: 타임리프 템플릿
└── test
    └── java/hello/hellospring
        ├── repository/MemoryMemberRepositoryTest.java  # 3장: 리포지토리 테스트
        └── service/MemberServiceTest.java               # 3장: 서비스 테스트(DI 적용)
```

## 사용 방법

이 폴더 자체는 완전한 Gradle 프로젝트가 아니라 **소스 코드만 모아둔 것**. 아래 순서로 본인 프로젝트에 적용:

1. [start.spring.io](https://start.spring.io) 에서 새 프로젝트 생성
   - Project: `Gradle - Groovy`, Spring Boot: `3.x.x`, Language: Java, Packaging: Jar, Java: 17 또는 21
   - groupId: `hello`, artifactId: `hello-spring`
   - Dependencies: `Spring Web`, `Thymeleaf`
2. 압축을 풀어 받은 프로젝트에 이 폴더의 `src` 내용을 그대로 덮어쓰기(병합)
3. IntelliJ로 열어서 Gradle 동기화 후 `HelloSpringApplication` 실행
4. `http://localhost:8080` 접속해서 동작 확인

## 실행 확인 URL

| URL | 설명 |
|---|---|
| `/` | Welcome Page (`static/index.html`) |
| `/hello` | 타임리프 템플릿 렌더링 |
| `/hello-static.html` | 정적 컨텐츠 |
| `/hello-mvc?name=spring` | MVC + 템플릿 엔진 |
| `/hello-string?name=spring` | `@ResponseBody` 문자 반환 |
| `/hello-api?name=spring` | `@ResponseBody` 객체(JSON) 반환 |

## 참고

- `MemoryMemberRepository`는 동시성 문제가 고려되지 않은 학습용 구현체. 실무에서는 `ConcurrentHashMap`, `AtomicLong` 사용 고려.
- `MemberServiceTest`는 생성자 주입(DI)이 적용된 버전 기준 — `MemberService`에 기본 생성자(내부에서 `new MemoryMemberRepository()`)가 아니라 **생성자 파라미터로 리포지토리를 주입**받는 구조여야 테스트가 통과함.
