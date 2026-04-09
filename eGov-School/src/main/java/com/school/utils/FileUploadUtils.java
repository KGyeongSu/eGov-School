package com.school.utils;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

import com.school.dto.LessonAttachVO;

public class FileUploadUtils {
	
	private final String uploadPath = "c:/school/upload/lessons";
	
	public List <LessonAttachVO> saveFiles (List <MultipartFile> files) throws Exception {
		
		List <LessonAttachVO> attachList = new ArrayList<> ();
		
		// 저장 폴더 없으면 생성
		File saveDir = new File (uploadPath);
		
		if (!saveDir.exists()) saveDir.mkdirs();
		
		if (files != null) {
			
			for (MultipartFile file : files) {
				
				// 파일이 있을 때만
				if (!file.isEmpty()) {
					
					//UUID 생성 : 중복 방지
					String name = file.getOriginalFilename();
					String uuid = UUID.randomUUID().toString();
					String saveName = uuid + "_" + name;
					
					// 실제 파일 저장 
					File target = new File(uploadPath, saveName);
					file.transferTo(target);
					
					// DB에 저장할 정보 담기
					LessonAttachVO attach = new LessonAttachVO();
					attach.setLaName(name);
					attach.setLaSaveName(saveName);
					attach.setLaPath(uploadPath);
					
					// 확장자 타입 구분
					String ext = name.substring(name.lastIndexOf(".") + 1).toLowerCase();
					if (ext.equals("mp4") || ext.equals("avi") || ext.equals("mkv")) {
						
						attach.setLaType("VIDEO");
						
					} else {
						
						attach.setLaType("FILE");
						
					}
					
					attachList.add(attach);
					
				}
				
			}
			
		}
		
		return attachList;
		
	}

}
