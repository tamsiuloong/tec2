package com.jeecms.ext.lucene;


import com.jeecms.cms.entity.main.Content;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

//@Order(5)
//@Aspect
//@Component
public class IndexInterceptor {
    private static final Logger log = LoggerFactory.getLogger(IndexInterceptor.class);
    //@Pointcut("execution(* com.jeecms.cms.lucene.LuceneContentSvcImpl.*(..))")
    @Pointcut("execution(* com.jeecms.cms.lucene.LuceneContentSvc.*Index(..))")
    public void index(){};

    @Around("index()")
    public Object aroundIndex(ProceedingJoinPoint pjp) {
        log.debug("环绕通知方法［ doConcurrentOperation(ProceedingJoinPoint pjp) ］.............");
        try {
            //访问目标方法的参数：
            Object[] args = pjp.getArgs();
            if (args != null && args.length > 0 && args[0] instanceof Content) {
                Content c = (Content) args[0];
            }

            return pjp.proceed();
        } catch (Throwable throwable) {
            throwable.printStackTrace();
        }
        return null;
    }

/*    @Around("index()")
    public Object aroundIndex(ProceedingJoinPoint pjp) {
        log.debug("环绕通知方法［ doConcurrentOperation(ProceedingJoinPoint pjp) ］.............");
        try {
            //访问目标方法的参数：
            Object[] args = pjp.getArgs();
            if (args != null && args.length > 0 && args[0] instanceof Content) {
                Content c = (Content) args[0];
            }

            return pjp.proceed();
        } catch (Throwable throwable) {
            throwable.printStackTrace();
        }
        return null;
    }*/

    /*@Before("execution(public void com.oumyye.dao.impl.UserDAOImpl.save(com.oumyye.model.User))")*/
/*    @Before("index()")
    public void before() {
        System.out.println("method staet");
    }
    @After("index()")
    public void after() {
        System.out.println("method after");
    }
    @AfterReturning("execution(public * com.oumyye.dao..*.*(..))")
    public void AfterReturning() {
        System.out.println("method AfterReturning");
    }
    @AfterThrowing("execution(public * com.oumyye.dao..*.*(..))")
    public void AfterThrowing() {
        System.out.println("method AfterThrowing");
    } */
/***
 * 说明：

 请注意切面实现了 Ordered 接口，这样我们就可以把切面的优先级设定为高于事务通知
 （我们每次重试的时候都想要在一个全新的事务中进行）。maxRetries和order 属性都可以在Spring中配置。
 主要的动作在doConcurrentOperation这个环绕通知方法中发生。
 请注意这个时候我们所有的businessService()方法都会使用这个重试策略。
 我们首先会尝试处理，如果得到一个Exception异常， 我们仅仅重试直到耗尽所有预设的重试次数（spring开发文档）
 */
}

