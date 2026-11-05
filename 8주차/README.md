# 스프링 입문 - 4~5장 실습

인프런 강의 *스프링 입문 - 코드로 배우는 스프링 부트, 웹 MVC, DB 접근 기술* (김영한) 4장(스프링 빈과 의존관계), 5장(회원 관리 예제 - 웹 MVC 개발) 실습 코드.

**1~3장 코드(`ch01-03-spring-practice`) 위에 이어서 적용하는 파일들**이야. 1~3장 프로젝트에 아래 파일들을 추가/덮어쓰기 하면 됨.

## 구성

```
src/main/java/hello/hellospring
├── SpringConfig.java                          # 4장: 자바 코드로 빈 수동 등록
└── controller
    ├── HomeController.java                    # 5장: 홈 화면 ("/")
    ├── MemberController.java                  # 5장: 회원 등록/조회 (4장에서 만든 DI 구조 사용)
    └── MemberForm.java                        # 5장: 등록 폼 데이터 객체

src/main/resources/templates
├── home.html                                  # 5장: 홈 화면
└── members
    ├── createMemberForm.html                  # 5장: 회원 등록 폼
    └── memberList.html                        # 5장: 회원 목록
```

## 적용 방법

1. `ch01-03-spring-practice` 프로젝트 폴더 기준으로, 이 폴더의 `src` 내용을 같은 위치에 추가
2. **주의 — 빈 등록 방식 충돌**: `SpringConfig.java`로 `MemberService`/`MemoryMemberRepository`를 수동 등록하므로, 혹시 1~3장 코드에 `@Service`/`@Repository` 애노테이션을 붙여놨다면 **반드시 제거**할 것 (컴포넌트 스캔 + 수동 등록이 같이 있으면 빈 중복 등록 에러 발생)
3. IntelliJ에서 Gradle 재동기화 후 애플리케이션 재실행
4. `http://localhost:8080` 접속 → 홈 화면에서 "회원 가입" / "회원 목록" 동작 확인

## 실행 확인 URL

| URL | 설명 |
|---|---|
| `/` | 홈 화면 (회원 가입/목록 링크) |
| `/members/new` | 회원 등록 폼 (GET) / 등록 처리 (POST) |
| `/members` | 회원 목록 조회 |

## 참고

- 생성자가 1개뿐이면 `@Autowired` 생략 가능 (스프링 4.3+)
- 스프링 빈은 기본적으로 **싱글톤**으로 등록됨 (같은 빈이면 항상 같은 인스턴스)
- DI는 필드 주입·setter 주입·생성자 주입 3가지 중 **생성자 주입**이 권장 방식
