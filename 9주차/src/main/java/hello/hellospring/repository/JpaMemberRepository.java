package hello.hellospring.repository;

import hello.hellospring.domain.Member;

import jakarta.persistence.EntityManager;
import java.util.List;
import java.util.Optional;

/**
 * JPA(EntityManager)로 구현한 리포지토리.
 * 스프링 부트 3.0 이상 기준 jakarta.persistence 패키지 사용.
 * (2.x 버전이면 javax.persistence로 바꿔서 사용)
 */
public class JpaMemberRepository implements MemberRepository {

    private final EntityManager em;

    public JpaMemberRepository(EntityManager em) {
        this.em = em;
    }

    public Member save(Member member) {
        em.persist(member);
        return member;
    }

    public Optional<Member> findById(Long id) {
        Member member = em.find(Member.class, id);
        return Optional.ofNullable(member);
    }

    public List<Member> findAll() {
        return em.createQuery("select m from Member m", Member.class)
                .getResultList();
    }

    public Optional<Member> findByName(String name) {
        List<Member> result = em.createQuery("select m from Member m where m.name = :name", Member.class)
                .setParameter("name", name)
                .getResultList();
        return result.stream().findAny();
    }
}
