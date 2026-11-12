package hello.hellospring.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

/**
 * 7장 AOP: 모든 메서드 호출 시간을 측정하는 공통 관심사(cross-cutting concern).
 * MemberService 안에 흩어져 있던 시간 측정 로직을 여기로 분리했다.
 * build.gradle에 spring-boot-starter-aop 의존성 추가 필요:
 *   implementation 'org.springframework.boot:spring-boot-starter-aop'
 */
@Component
@Aspect
public class TimeTraceAop {

    @Around("execution(* hello.hellospring..*(..))")
    public Object execute(ProceedingJoinPoint joinPoint) throws Throwable {
        long start = System.currentTimeMillis();
        System.out.println("START: " + joinPoint.toString());
        try {
            return joinPoint.proceed();
        } finally {
            long finish = System.currentTimeMillis();
            long timeMs = finish - start;
            System.out.println("END: " + joinPoint.toString() + " " + timeMs + "ms");
        }
    }
}
