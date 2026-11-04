package Hello.hello_spring.service;

import Hello.hello_spring.domain.Member;
import Hello.hello_spring.repository.MemberRepository;
import Hello.hello_spring.repository.MemoryMemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

//@Service
//@Component
public class MemberService {
    private final MemberRepository memberRepository;

    //@Autowired
    public MemberService(MemberRepository memberRepository){
        this.memberRepository = memberRepository;
    }

    public Long join(Member member){
        validateDuplicateMember(member);

        memberRepository.save(member);
        return member.getId();
    }

    private void validateDuplicateMember(Member member) {
        memberRepository.findByName(member.getName())
                .ifPresent(m ->{
            throw new IllegalStateException("이미 존재하는 회원입니다.");
        });
    }

    public List<Member> FindMembers(){
        return memberRepository.findAll();
    }
    
    public Optional<Member> findOne(Long memberId){
        return memberRepository.findById(memberId);
    }
}
