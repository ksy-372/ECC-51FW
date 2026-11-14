package Hello.hello_spring;

import Hello.hello_spring.aop.TimeTraceApp;
import Hello.hello_spring.domain.Member;
import Hello.hello_spring.repository.*;
import Hello.hello_spring.service.MemberService;
import jakarta.persistence.EntityManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;

@Configuration
public class SpringConfig {

    private final MemberRepository memberRepository;

    @Autowired
    public SpringConfig(MemberRepository memberRepository) {
        this.memberRepository = memberRepository;
    }

    //private DataSource dataSource;

    /*
    private EntityManager em;

    @Autowired
    public SpringConfig(DataSource dataSource){
        this.dataSource = dataSource
    }
    @Autowired
    public SpringConfig(EntityManager em){
        this.em = em;
    }
     */

    @Bean
    public MemberService memberService() {
        return new MemberService(memberRepository);
    }

    //@Bean
    //public TimeTraceApp timeTraceApp(){
    //    return new TimeTraceApp();
    //}
    //@Bean
    //public MemberRepository memberRepository(){

        //return new MemoryMemberRepository();
        // return new JdbcMemberRepository(dataSource);
        //return new JdbcTemplateMemberRepository(dataSource);
        // return new JpaMemberRepository(em);
    //}
}
