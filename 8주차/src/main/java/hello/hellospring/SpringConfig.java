package hello.hellospring;

import hello.hellospring.repository.MemberRepository;
import hello.hellospring.repository.MemoryMemberRepository;
import hello.hellospring.service.MemberService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 자바 코드로 직접 스프링 빈을 등록하는 설정 클래스.
 * MemberService / MemoryMemberRepository에는 @Service, @Repository, @Autowired를
 * 붙이지 않는다 (컴포넌트 스캔 방식과 병행하면 빈 중복 등록 에러가 날 수 있음).
 */
@Configuration
public class SpringConfig {

    @Bean
    public MemberService memberService() {
        return new MemberService(memberRepository());
    }

    @Bean
    public MemberRepository memberRepository() {
        return new MemoryMemberRepository();
    }
}
