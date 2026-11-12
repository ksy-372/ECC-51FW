# 스프링 입문 - 6~7장 실습

인프런 강의 *스프링 입문 - 코드로 배우는 스프링 부트, 웹 MVC, DB 접근 기술* (김영한) 6장(스프링 DB 접근 기술), 7장(AOP) 실습 코드.

**1~5장 코드 위에 이어서 적용**하는 파일들이야. 1~3장(`ch01-03-spring-practice`), 4~5장(`ch04-05-spring-practice`) 프로젝트에 아래 파일들을 추가/덮어쓰기 하면 됨.

## 구성

```
sql/ddl.sql                                              # H2에 member 테이블 생성하는 DDL

src/main/java/hello/hellospring
├── SpringConfig.java                                    # 리포지토리 구현체 중 하나를 골라 빈 등록 (주석 참고)
├── domain/Member.java                                   # @Entity 매핑 추가된 버전 (JPA용)
├── repository/JdbcMemberRepository.java                 # 순수 Jdbc 구현체
├── repository/JdbcTemplateMemberRepository.java         # JdbcTemplate 구현체
├── repository/JpaMemberRepository.java                  # JPA(EntityManager) 구현체
├── repository/SpringDataJpaMemberRepository.java        # 스프링 데이터 JPA (인터페이스만)
├── service/MemberService.java                           # 7장 AOP 적용 후 최종 버전 (@Transactional, 시간측정 코드 제거)
└── aop/TimeTraceAop.java                                # 7장: 시간 측정 공통 로직 (AOP)

src/main/resources/application.properties                # H2 접속 정보 + JPA 설정
src/test/java/hello/hellospring/service/MemberServiceIntegrationTest.java  # 스프링 컨테이너+DB 통합 테스트
```

## 적용 방법

1. **H2 데이터베이스 설치 및 실행**: [h2database.com](https://www.h2database.com) 에서 스프링 부트 버전에 맞는 H2 다운로드
   - 스프링 부트 3.x → H2 2.1.214 이상
   - `./h2.sh`(윈도우는 `h2.bat`) 실행 → 최초 1회 `jdbc:h2:~/test`로 접속해 DB 파일 생성 → 이후 `jdbc:h2:tcp://localhost/~/test`로 접속
   - H2 콘솔에서 `sql/ddl.sql` 내용 실행해 `member` 테이블 생성
2. `build.gradle`에 의존성 추가
   ```groovy
   implementation 'org.springframework.boot:spring-boot-starter-jdbc'
   implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
   implementation 'org.springframework.boot:spring-boot-starter-aop'
   runtimeOnly 'com.h2database:h2'
   ```
3. 이 폴더의 `src`, `sql` 내용을 기존 프로젝트에 병합
4. **`SpringConfig.java` 주석을 보고 리포지토리 구현체 중 하나만 선택** (4가지 중 꼭 하나만 활성화 — 여러 개 동시에 켜면 에러)
5. IntelliJ에서 Gradle 재동기화 후 재실행

## 실행 확인

- 앱 실행 후 `/members/new`에서 회원 등록 → 서버 재시작해도 데이터가 남아있으면 DB 연동 성공
- 콘솔에 `START:` / `END: ... ms` 로그가 찍히면 AOP(TimeTraceAop) 정상 동작
- `MemberServiceIntegrationTest` 실행 → `@Transactional`로 롤백되므로 테스트 후 DB에 데이터 안 남음

## 참고

- 스프링 부트 3.0 이상은 `javax.persistence` → `jakarta.persistence`로 변경 (단, `javax.sql.DataSource`는 그대로 유지)
- 스프링 데이터 JPA(`SpringDataJpaMemberRepository`)를 쓸 경우 `SpringConfig`에서 `memberRepository()` 빈을 직접 만들 필요 없음 — README 안 `SpringConfig.java` 파일 하단 주석의 대체 버전 참고
- 실무에서는 JPA + 스프링 데이터 JPA를 기본으로 쓰고, 복잡한 동적 쿼리는 Querydsl 사용
