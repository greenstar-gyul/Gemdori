package com.gemdori.member;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gemdori.common.Control;
import com.gemdori.member.service.UserService;
import com.gemdori.member.service.UserServiceImpl;
import com.gemdori.member.vo.UserFullVO;
import com.gemdori.member.vo.UserProfileVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class UpdateProfileControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
        UserFullVO loginUser = (UserFullVO) session.getAttribute("loginUser");

        if (loginUser == null) {
            resp.sendRedirect("loginForm.do");
            return;
        }

        // 1. 파일 업로드 설정
        String saveDir = req.getServletContext().getRealPath("/img/profile");
        File folder = new File(saveDir);
        if (!folder.exists()) folder.mkdirs(); // 폴더가 없으면 생성
        
        int maxSize = 5 * 1024 * 1024; // 5MB
        String enc = "UTF-8";
        MultipartRequest mr = new MultipartRequest(req, saveDir, maxSize, enc, new DefaultFileRenamePolicy());
        System.out.println("이미지 저장 경로: " + saveDir);
        // 2. 데이터 수집
        String userCode = loginUser.getUserCode();
        String userName = mr.getParameter("userName");
        String userGender = mr.getParameter("userGender");
        String userBirthdayStr = mr.getParameter("userBirthday");
        String userIntro = mr.getParameter("userIntro");
        String uploadedFile = mr.getFilesystemName("userImage"); // 실제 저장된 파일명

        // 기본값: 기존 생일값(java.util.Date → java.sql.Date 변환)
        Date userBirthday = null;
        if (loginUser.getUserBirthday() != null) {
            userBirthday = new java.sql.Date(loginUser.getUserBirthday().getTime());
        }

        // 사용자가 입력한 생일값 처리
        if (userBirthdayStr != null && !userBirthdayStr.trim().isEmpty()) {
            try {
                userBirthday = Date.valueOf(userBirthdayStr); // java.sql.Date.valueOf
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
            }
        }
        // 3. 파일명 변경 처리 (업로드가 된 경우에만)
        String finalImageName = loginUser.getUserImage();
        if (uploadedFile != null) {
            String ext = uploadedFile.substring(uploadedFile.lastIndexOf("."));
            String newFileName = userCode + "_" + System.currentTimeMillis() + ext;

            File oldFile = new File(saveDir, uploadedFile);
            File newFile = new File(saveDir, newFileName);
            try {
                Files.move(oldFile.toPath(), newFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                finalImageName = "profile/" + newFileName;
            } catch (IOException e) {
                e.printStackTrace(); // 실패 시 로그 출력
            }
        }

        // 4. VO 구성
        UserProfileVO userProfile = new UserProfileVO();
        userProfile.setUserCode(userCode);
        userProfile.setUserName(userName);
        userProfile.setUserGender(userGender);
        userProfile.setUserBirthday(userBirthday);
        userProfile.setUserIntro(userIntro);
        userProfile.setUserImage(finalImageName);

        // 5. DB 업데이트
        UserService service = new UserServiceImpl();
        boolean success = service.updateUserProfile(userProfile);

        // 6. 세션 갱신
        if (success) {
        	UserFullVO updatedUser = service.selectUserByUserCode(userCode);
            session.setAttribute("loginUser", updatedUser);
        }

        // 7. 이동
        resp.sendRedirect("myInfo.do?update=success");
    }

}
