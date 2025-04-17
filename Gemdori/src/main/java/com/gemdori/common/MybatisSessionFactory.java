package com.gemdori.common;

import java.io.InputStream;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MybatisSessionFactory {
    private static SqlSessionFactory sqlSessionFactory;

    static {
        try {
            String resource = "com/gemdori/common/mybatis-config.xml"; // 설정파일 경로
            InputStream inputStream = Resources.getResourceAsStream(resource);
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static SqlSessionFactory getInstance() {
        return sqlSessionFactory;
    }
}
