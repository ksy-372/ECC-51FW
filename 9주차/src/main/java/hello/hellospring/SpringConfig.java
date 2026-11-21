package hello.hellospring;

import hello.hellospring.repository.*;
import hello.hellospring.service.MemberService;
import jakarta.persistence.EntityManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;

/**
 * 6장에서 다루는 4가지 리포지토리 구현체 중 하나를 골라 등록하는 설정.
 * 지금 활성화된 줄만 두고 나머지는 주석 처리 상태로 둔다 — 전부 활성화하면 빈 중복/타입 불일치 에러.
 *
 *   1) 메모리:        new MemoryMemberRepository()                 (의존성 없음)
 *   2) 순수 Jdbc:      new JdbcMemberRepository(dataSource)          (DataSource 필요)
 *   3) JdbcTemplate:   new JdbcTemplateMemberRepository(dataSource)  (DataSource 필요)
 *   4) JPA:            new JpaMemberRepository(em)                  (EntityManager 필요)
 *
 * 스프링 데이터 JPA(SpringDataJpaMemberRepository)를 쓸 경우에는 이 설정 클래스 자체가 필요 없다 —
 * 아래쪽 "스프링 데이터 JPA 버전 SpringConfig" 참고.
 */
@Configuration
public class SpringConfig {

    private final DataSource dataSource;
    private final EntityManager em;

    public SpringConfig(DataSource dataSource, EntityManager em) {
        this.dataSource = dataSource;
        this.em = em;
    }

    @Bean
    public MemberService memberService() {
        return new MemberService(memberRepository());
    }

    @Bean
    public MemberRepository memberRepository() {
        // return new MemoryMemberRepository();
        // return new JdbcMemberRepository(dataSource);
        // return new JdbcTemplateMemberRepository(dataSource);
        return new JpaMemberRepository(em);
    }
}

/*
 * ---------- 스프링 데이터 JPA 버전 SpringConfig ----------
 * SpringDataJpaMemberRepository(인터페이스)를 쓸 경우, 스프링 데이터 JPA가
 * 구현체를 자동 생성해서 빈으로 등록해주므로 memberRepository() 빈을 직접 만들 필요가 없다.
 * 아래 클래스를 쓸 때는 위 SpringConfig는 제거(또는 비활성화)할 것.
 *
 * @Configuration
 * public class SpringConfig {
 *     private final MemberRepository memberRepository;
 *
 *     public SpringConfig(MemberRepository memberRepository) {
 *         this.memberRepository = memberRepository;
 *     }
 *
 *     @Bean
 *     public MemberService memberService() {
 *         return new MemberService(memberRepository);
 *     }
 * }
 */
