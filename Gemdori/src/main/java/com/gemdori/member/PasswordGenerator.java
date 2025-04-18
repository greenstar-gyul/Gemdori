package com.gemdori.member;

import java.util.Random;

public class PasswordGenerator {
    // 임시 비밀번호 재조합
	private static final String UPPER = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private static final String LOWER = "abcdefghijklmnopqrstuvwxyz";
    private static final String DIGITS = "0123456789";
    private static final String ALL = UPPER + LOWER + DIGITS;

    public static String generate(int length) {
        Random rnd = new Random();
        StringBuilder sb = new StringBuilder(length);

        while (true) {
            sb.setLength(0);
            for (int i = 0; i < length; i++) {
                sb.append(ALL.charAt(rnd.nextInt(ALL.length())));
            }

            String pw = sb.toString();
            if (pw.matches(".*[A-Z].*") && pw.matches(".*[a-z].*") && pw.matches(".*[0-9].*")) {
                return pw;
            }
        }
    }
}
